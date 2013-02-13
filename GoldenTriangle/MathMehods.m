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
    double* result = malloc(sizeof(double)*(numSteps+1));
    [fInvocation setArgument:&x atIndex:2];
    [fInvocation invoke];
    [fInvocation getReturnValue:&result[0]];
    
    NSLog(@"Result[0]: %f", result[0]);
    for(int i = 1; i <= numSteps; ++i){
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
        NSLog(@"result in %f: %f",i*h,result[i]);
    }
    return result;
}

+(double)simpsonFromFunction:(SEL)fun selectorTarget:(id)selTarget isStatic:(BOOL)isStatic withBorder:(CGPoint)border andHalfNumSteps:(NSInteger) numSteps{
    double h = (border.y - border.x)/(numSteps*2);
    double res = 150;
    NSInvocation* funInvocation = nil;
    NSMethodSignature* funSignature = nil;
    if(isStatic){
        Method method = class_getClassMethod(selTarget, fun);
        struct objc_method_description* description = method_getDescription(method);
        if(description == NULL || description -> name == NULL){
            NSLog(@"Error: can't create description");
            return 0;
        }
        funSignature = [NSMethodSignature signatureWithObjCTypes:description->types];
    }else{
        funSignature = [selTarget methodSignatureForSelector:fun];
    }
    funInvocation = [NSInvocation invocationWithMethodSignature:funSignature];
    [funInvocation setTarget:selTarget];
    [funInvocation setSelector:fun];
    double x = border.x;
    [funInvocation setArgument:&x atIndex:2];
    [funInvocation invoke];
    double partRes;
    [funInvocation getReturnValue:&partRes];
    res = partRes;
    for(int i = 1; i < numSteps*2; i+=2){
        x = border.x + i*h;
        [funInvocation setArgument:&x atIndex:2];
        [funInvocation invoke];
        [funInvocation getReturnValue:&partRes];
        res+=(4.*partRes);
    }
    for(int i = 2; i < numSteps*2; i+=2){
         x = border.x + i*h;
        [funInvocation setArgument:&x atIndex:2];
        [funInvocation invoke];
        [funInvocation getReturnValue:&partRes];
        res+=(2.*partRes);
    }
    x = border.y;
    [funInvocation setArgument:&x atIndex:2];
    [funInvocation invoke];
    [funInvocation getReturnValue:&partRes];
    res+=partRes;
    return res*(h/3.);
}

+(double)fluctionFromFunction:(SEL)fun selectorTarget:(id)selTarget isStatic:(BOOL)isStatic withParametr:(double)x{
    NSInvocation* funInvocation = nil;
    NSMethodSignature* funSig = nil;
    if(isStatic){
        Method method = class_getClassMethod(selTarget, fun);
        struct objc_method_description* description = method_getDescription(method);
        if(description == NULL || description -> name == NULL){
            NSLog(@"Error: can't create description");
            return 0;
        }
        funSig = [NSMethodSignature signatureWithObjCTypes:description->types];
    }else{
        funSig = [selTarget methodSignatureForSelector:fun];
    }
    funInvocation = [NSInvocation invocationWithMethodSignature:funSig];
    [funInvocation setSelector:fun];
    [funInvocation setTarget:selTarget];
    double h = 0.0000000001;
    double xe = x + h;
    double xs = x;
    
    [funInvocation setArgument:&xe atIndex:2];
    [funInvocation invoke];
    [funInvocation getReturnValue:&xe];
    
    [funInvocation setArgument:&xs atIndex:2];
    [funInvocation invoke];
    [funInvocation getReturnValue:&xs];
    
    return (xe - xs)/h;
}

@end