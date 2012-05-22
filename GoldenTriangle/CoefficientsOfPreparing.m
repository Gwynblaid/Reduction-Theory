//
//  CoefficientsOfPreparing.m
//  GoldenTriangle
//
//  Created by Skiv on 22.05.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoefficientsOfPreparing.h"
#import "ProbalisticLow.h"
#import "MathMehods.h"


@interface CoefficientsOfPreparing()
//additional functions
-(double)intToNonestationary:(double)x;
-(double)intToStationary:(double)x;
-(double)H1:(double)x;
-(double)complexFunctionFxG:(double)x;
-(double)intComplexFunction:(double)x;
-(double)kernelWithX:(double)x andT:(double)t;
@end

@implementation CoefficientsOfPreparing

@synthesize GLow = _GLow;
@synthesize FLow = _FLow;
@synthesize x = _parametrX;
@synthesize t = _parametrT;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

// нестационарный коэффициент готовности
-(double)calculateNonstationaryAvailabilityFactorWithT:(double)t{
    self.t = t;
    return 1 - [self.FLow getFWithX:(self.x + t)] + [MathMehods simpsonFromFunction:@selector(intToNonestationary:) selectorTarget:self isStatic:NO withBorder:CGPointMake(0, t) andHalfNumSteps:100000];
}

//  нестационарный оперативный коэффициент готовности
-(double)calculateNonstationaryOpperativeAvailabilityFactorWithT:(double)t{
    double temp_x = self.x;
    self.x = 0;
    double res = [self calculateNonstationaryAvailabilityFactorWithT:t];
    self.x = temp_x;
    return res;
}

// стационарный коэффициент готовности
-(double)calculateStationaryAvailabilityFactorWithT:(double)t{
    return 0; 
}

//  стационарный оперативный коэффициент готовности
-(double)calculateStationaryOpperativeAvailabilityFactorWithT:(double)t{
    double temp_x = self.x;
    self.x = 0;
    double res = [self calculateStationaryAvailabilityFactorWithT:t];
    self.x = temp_x;
    return res;
}

//private methods

-(double)intToNonestationary:(double)alf{
    double x_temp = self.x;
    self.x = alf;
    double res  = (1. - [self.FLow getFWithX:(self.t - self.x - alf)])*[MathMehods fluctionFromFunction:@selector(H1:) selectorTarget:self isStatic:NO withParametr:self.x];
    self.x = x_temp;
    return res;
}

-(double)intToStationary:(double)x{
    return 1 - [self.FLow getFWithX:(self.x + x)];
}

-(double)H1:(double)x{
    int numSteps = 10000;
    return [MathMehods solveEquationVolteraWithKernel:@selector(kernelWithX:andT:) f:@selector(complexFunctionFxG:) selectorTarget:self isStatic:NO withEndPoint:x lambda:1 andStep:x/numSteps][numSteps];
}

-(double)complexFunctionFxG:(double)x{
    tempParametr = x;
    return [MathMehods simpsonFromFunction:@selector(intComplexFunction:) selectorTarget:self isStatic:NO withBorder:CGPointMake(0, tempParametr) andHalfNumSteps:100000];
}

-(double)intComplexFunction:(double)x{
    return [self.FLow getFWithX:(tempParametr - x)]*[self.GLow getfWithX:x];
}

-(double)kernelWithX:(double)x andT:(double)t{
    
    double temptempParametr = tempParametr;
    tempParametr = x - t;
    double result = [MathMehods fluctionFromFunction:@selector(complexFunctionFxG:) selectorTarget:self isStatic:NO withParametr:(x - t)];
    tempParametr = temptempParametr;
    
    return result;
}

@end
