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

-(void)setF:(SEL)F{
    _F = F;
    if(self.selectorClass){
        Method method = class_getClassMethod(self.selectorClass, _F);
        struct objc_method_description* descr = method_getDescription(method);
        if(descr == NULL || descr->name == NULL){
            NSLog(@"Error: can't get method description");
            return ;
        }
        _FInvocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:descr->types]];
        [_FInvocation setTarget:self.selectorClass];
        [_FInvocation setSelector:_F];
    }
}

-(void)setF_m:(SEL)f_m{
    _f = f_m;
    if(self.selectorClass){
        Method method = class_getClassMethod(_selectorClass, _f);
        struct objc_method_description* descr = method_getDescription(method);
        if(descr == NULL || descr->name == NULL){
            NSLog(@"Error: can't get method description");
            return ;
        }
        _fInvocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:descr->types]];
        [_fInvocation setTarget:_selectorClass];
        [_fInvocation setSelector:_f];
    }
}

-(void)setSelectorClass:(Class)selectorClass{
    _selectorClass = selectorClass;
    if(self.F){
        Method method = class_getClassMethod(self.selectorClass, _F);
        struct objc_method_description* descr = method_getDescription(method);
        if(descr == NULL || descr->name == NULL){
            NSLog(@"Error: can't get method description");
            return ;
        }
        _FInvocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:descr->types]];
        [_FInvocation setTarget:self.selectorClass];
        [_FInvocation setSelector:_F];
    }
    
    if(self.f_m){
        Method method = class_getClassMethod(_selectorClass, _f);
        struct objc_method_description* descr = method_getDescription(method);
        if(descr == NULL || descr->name == NULL){
            NSLog(@"Error: can't get method description");
            return ;
        }
        _fInvocation = [NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:descr->types]];
        [_fInvocation setTarget:_selectorClass];
        [_fInvocation setSelector:_f];
    }
}

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
    [_FInvocation setArgument:&_parametr1 atIndex:2];
    [_FInvocation setArgument:&_parametr2 atIndex:3];
    [_FInvocation setArgument:&x atIndex:4];
    [_FInvocation invoke];
    [_FInvocation getReturnValue:&result];
    return result;
}

-(double)getfWithX:(double)x{
    double result;
    [_fInvocation setArgument:&_parametr1 atIndex:2];
    [_fInvocation setArgument:&_parametr2 atIndex:3];
    [_fInvocation setArgument:&x atIndex:4];
    [_fInvocation invoke];
    [_fInvocation getReturnValue:&result];
    return result;
}

-(double)getFWithX:(double)x andT:(double)t{
    return [self getFWithX:(x-t)];
}

-(double)getfWithX:(double)x andT:(double)t{
    return [self getfWithX:(x-t)];
}

@end
