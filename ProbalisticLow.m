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
@synthesize f = _f;
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

-(CGFloat)getFWithX:(CGFloat)x{
    float result;
    
    Method method = class_getClassMethod(_selectorClass, _F);
    struct objc_method_description* descr = method_getDescription(method);
    if(descr == NULL || descr->name == NULL){
        NSLog(@"Error: can't get method description");
        return nil;
    }
    NSInvocation* invokation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:descr->types]];
    [invokation setTarget:_selectorClass];
    [invokation setSelector:_F];
    [invokation setArgument:&x atIndex:2];
    [invokation invoke];
    [invokation getReturnValue:&result];
    
    return result;
}

-(CGFloat)getfWithX:(CGFloat)x{
    float result;
    
    Method method = class_getClassMethod(_selectorClass, _f);
    struct objc_method_description* descr = method_getDescription(method);
    if(descr == NULL || descr->name == NULL){
        NSLog(@"Error: can't get method description");
        return nil;
    }
    NSInvocation* invokation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:descr->types]];
    [invokation setTarget:_selectorClass];
    [invokation setSelector:_f];
    [invokation setArgument:&x atIndex:2];
    [invokation invoke];
    [invokation getReturnValue:&result];
    
    return result;
}

@end
