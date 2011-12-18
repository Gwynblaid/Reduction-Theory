//
//  ProbalisticLow.h
//  GoldenTriangle
//
//  Created by Skiv on 18.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProbalisticLow : NSObject{
    float _parametr1;
    float _parametr2;
    SEL _F;
    SEL _f;
    Class _selectorClass;
}

@property (assign) float parametr1;
@property (assign) float parametr2;
@property (assign) Class selectorClass;
@property (assign) SEL F;
@property (assign) SEL f;

-(CGFloat)getFWithX:(CGFloat)x;
-(CGFloat)getfWithX:(CGFloat)x;

@end
