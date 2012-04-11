//
//  ProbalisticLow.h
//  GoldenTriangle
//
//  Created by Skiv on 18.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProbalisticLow : NSObject{
    double _parametr1;
    double _parametr2;
    SEL _F;
    SEL _f;
    Class _selectorClass;
}

@property (assign) double parametr1;
@property (assign) double parametr2;
@property (assign) Class selectorClass;
@property (assign) SEL F;
@property (assign) SEL f_m;

-(double)getFWithX:(double)x;
-(double)getfWithX:(double)x;
-(double)getFWithX:(double)x andT:(double)t;
-(double)getfWithX:(double)x andT:(double)t;

@end
