//
//  ProbalisticLow.m
//  GoldenTriangle
//
//  Created by Skiv on 18.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProbalisticLow.h"
#import  <objc/objc.h>
#import  <objc/Object.h>

@implementation ProbalisticLow
@synthesize parametr1 = _parametr1;
@synthesize parametr2 = _parametr2;
@synthesize f_m = _f;
@synthesize F = _F;
@synthesize selectorClass = _selectorClass;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(double)getFWithX:(double)x{
    double result;
    
    Method method = class_getClassMethod(_selectorClass, _F);
    struct objc_method_description* descr = method_getDescription(method);
    if(descr == NULL || descr->name == NULL){
        NSLog(@"Error: can't get method description");
        return 0;
    }
    NSInvocation* invokation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:descr->types]];
    [invokation setTarget:_selectorClass];
    [invokation setSelector:_F];
    [invokation setArgument:&_parametr1 atIndex:2];
    [invokation setArgument:&_parametr2 atIndex:3];
    [invokation setArgument:&x atIndex:4];
    [invokation invoke];
    [invokation getReturnValue:&result];
    return result;
}

-(double)getfWithX:(double)x{
    double result;
    
    Method method = class_getClassMethod(_selectorClass, _f);
    struct objc_method_description* descr = method_getDescription(method);
    if(descr == NULL || descr->name == NULL){
        NSLog(@"Error: can't get method description");
        return 0;
    }
    NSInvocation* invokation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:descr->types]];
    [invokation setTarget:_selectorClass];
    [invokation setSelector:_f];
    [invokation setArgument:&_parametr1 atIndex:2];
    [invokation setArgument:&_parametr2 atIndex:3];
    [invokation setArgument:&x atIndex:4];
    [invokation invoke];
    [invokation getReturnValue:&result];
    return result;
}

-(double)getFWithX:(double)x andT:(double)t{
    return [self getFWithX:(x-t)];
}

-(double)getfWithX:(double)x andT:(double)t{
    return [self getfWithX:(x-t)];
}

@end
