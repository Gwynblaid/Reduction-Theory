//
//  MathMehods.m
//  GoldenTriangle
//
//  Created by Skiv on 13.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MathMehods.h"
//#import "TestData.h"
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

+(double*)solveEquationVolteraWithKernel:(SEL)kernel f:(SEL)f selectorTarget:(id)selTarget isStatic:(BOOL)isStatic withEndPoint:(double)point lambda:(double)lambda andStep:(double)h{
    
    //init kernel and f invocation
    NSInvocation* kernelInvocation = nil;
    NSInvocation* fInvocation = nil;
    NSMethodSignature* sig1;
    NSMethodSignature* sig2;
    if(isStatic){
        Method method1 = class_getInstanceMethod(selTarget, kernel);
        Method method2 = class_getInstanceMethod(selTarget, f);
        struct objc_method_description* desc1 = method_getDescription(method1);
        if (desc1 == NULL || desc1->name == NULL)
            return nil;
        struct objc_method_description* desc2 = method_getDescription(method2);
        if (desc2 == NULL || desc2->name == NULL)
            return nil;
        sig1 = [NSMethodSignature signatureWithObjCTypes:desc1->types];
        sig2 = [NSMethodSignature signatureWithObjCTypes:desc2->types];
    }else{
        sig1 = [selTarget methodSignatureForSelector:kernel];
        sig2 = [selTarget methodSignatureForSelector:f];
        
    }
    kernelInvocation = [NSInvocation invocationWithMethodSignature:sig1];
    fInvocation = [NSInvocation invocationWithMethodSignature:sig2];
    [fInvocation setTarget:selTarget];
    [kernelInvocation setTarget:selTarget];
    [kernelInvocation setSelector:kernel];
    [fInvocation setSelector:f];
    
    int numSteps = point/h;
    double x = 0, t = 0, Kij = 0;
    double* result = malloc(sizeof(double)*numSteps);
    [fInvocation setArgument:&x atIndex:2];
    [fInvocation invoke];
    [fInvocation getReturnValue:&result[0]];
    
    NSLog(@"Result[0]: %f", result[0]);
    for(int i = 1; i < numSteps; ++i){
        x = i*h;
        //NSLog(@"X: %f",x);
        [fInvocation setArgument:&x atIndex:2];
        [fInvocation invoke];
        [fInvocation getReturnValue:&result[i]];
        //NSLog(@"result[i]: %f", result[i]);
        t = 0;
        [kernelInvocation setArgument:&x atIndex:2];
        [kernelInvocation setArgument:&t atIndex:3];
        [kernelInvocation invoke];
        [kernelInvocation getReturnValue:&Kij];
        //NSLog(@"Kij: %f",Kij);
        result[i]+=lambda*Kij*h*result[0]/2.f;
        double s = 0;
        for(int j = 1; j < i; ++j){
            t=h*j;
            [kernelInvocation setArgument:&x atIndex:2];
            [kernelInvocation setArgument:&t atIndex:3];
            [kernelInvocation invoke];
            [kernelInvocation getReturnValue:&Kij];
            s+=Kij*result[j];
            //NSLog(@"Kij: %f",Kij);
        }
        s*=(h*lambda);
        //NSLog(@"S: %f",s);
        t = x;
        [kernelInvocation setArgument:&x atIndex:2];
        [kernelInvocation setArgument:&t atIndex:3];
        [kernelInvocation invoke];
        [kernelInvocation getReturnValue:&Kij];
        result[i] = (result[i]+s)/(1-lambda*h*Kij/2.);
        NSLog(@"result[i]: %f",result[i]);
    }
    return result;
}

@end