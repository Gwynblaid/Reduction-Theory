//
//  MathMehods.m
//  GoldenTriangle
//
//  Created by Skiv on 13.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MathMehods.h"
#import  <objc/objc.h>
#import  <objc/Object.h>

@implementation MathMehods

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(CGFloat*)solveEquationVolteraWithKernel:(SEL)kernel f:(SEL)f selectorTarget:(id)selTarget isStatic:(BOOL)isStatic withEndPoint:(float)point lambda:(float)lambda andStep:(float)h{
    
    //init kernel and f invocation
    NSInvocation* kernelInvocation = nil;
    NSInvocation* fInvocation = nil;
    if(isStatic){
        Method method1 = class_getInstanceMethod(selTarget, kernel);
        Method method2 = class_getInstanceMethod(selTarget, f);
        struct objc_method_description* desc1 = method_getDescription(method1);
        if (desc1 == NULL || desc1->name == NULL)
            return nil;
        struct objc_method_description* desc2 = method_getDescription(method2);
        if (desc2 == NULL || desc2->name == NULL)
            return nil;
        NSMethodSignature* sig1 = [NSMethodSignature signatureWithObjCTypes:desc1->types];
        NSMethodSignature* sig2 = [NSMethodSignature signatureWithObjCTypes:desc2->types];
        kernelInvocation = [NSInvocation invocationWithMethodSignature:sig1];
        fInvocation = [NSInvocation invocationWithMethodSignature:sig2];
    }else{
        NSMethodSignature* sig1 = [selTarget methodSignatureForSelector:kernel];
        NSMethodSignature* sig2 = [selTarget methodSignatureForSelector:f];
        kernelInvocation = [NSInvocation invocationWithMethodSignature:sig1];
        fInvocation = [NSInvocation invocationWithMethodSignature:sig2];
    }
    [kernelInvocation setTarget:selTarget];
    [fInvocation setTarget:selTarget];
    [kernelInvocation setSelector:kernel];
    [fInvocation setSelector:f];
    
    int numSteps = point/h+1;
    float x = 0, t = 0, Kij = 0;
    CGFloat* result = malloc(sizeof(CGFloat)*numSteps);
    [fInvocation setArgument:&x atIndex:2];
    [fInvocation invoke];
    [fInvocation getReturnValue:&result[0]];
    for(int i = 1; i < numSteps; ++i){
        x = i*h;
        [fInvocation setArgument:&x atIndex:2];
        [fInvocation invoke];
        [fInvocation getReturnValue:&result[i]];
        t = 0;
        [kernelInvocation setArgument:&x atIndex:2];
        [kernelInvocation setArgument:&t atIndex:3];
        [kernelInvocation invoke];
        [kernelInvocation getReturnValue:&Kij];
        result[i]+=lambda*Kij*h*result[0]/2.f;
        float s = 0;
        for(int j = 1; j < i-1; ++j){
            t+=h;
            [kernelInvocation setArgument:&x atIndex:2];
            [kernelInvocation setArgument:&t atIndex:3];
            [kernelInvocation invoke];
            [kernelInvocation getReturnValue:&Kij];
            s+=Kij*result[j];
        }
        s*=(h*lambda);
        t = x;
        [kernelInvocation setArgument:&x atIndex:2];
        [kernelInvocation setArgument:&t atIndex:3];
        [kernelInvocation invoke];
        [kernelInvocation getReturnValue:&Kij];
        result[i] = (result[i]+s)/(1-lambda*h*Kij/2.);
    }
    return result;
}

@end