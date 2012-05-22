//
//  CoefficientsOfPreparing.h
//  GoldenTriangle
//
//  Created by Skiv on 22.05.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProbalisticLow;

@interface CoefficientsOfPreparing : NSObject{
    
    ProbalisticLow* _FLow;
    ProbalisticLow* _GLow;
    double _parametrX;
    double _parametrT;
    double tempParametr;
    
}

@property (nonatomic, retain) ProbalisticLow* FLow;
@property (nonatomic, retain) ProbalisticLow* GLow;
@property (nonatomic, assign) double x;
@property (nonatomic, assign) double t;

-(double)calculateNonstationaryAvailabilityFactorWithT:(double)t; // нестационарный коэффициент готовности
-(double)calculateNonstationaryOpperativeAvailabilityFactorWithT:(double)t; //  нестационарный оперативный коэффициент готовности

-(double)calculateStationaryAvailabilityFactorWithT:(double)t; // стационарный коэффициент готовности
-(double)calculateStationaryOpperativeAvailabilityFactorWithT:(double)t; // стационарный оперативный коэффициент готовности
@end
