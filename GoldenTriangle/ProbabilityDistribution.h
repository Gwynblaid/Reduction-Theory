//
//  ProbabilityDistribution.h
//  GoldenTriangle
//
//  Created by Skiv on 26.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProbabilityDistribution : NSObject

+(CGFloat*)getGammaLowDistributionWithK:(float)k eta:(float)eta andNumOfElements:(uint)numElements;
+(CGFloat*)getNormalyzeLowDistributionWithM:(float)m andSigma:(float)sigma andNumElements:(uint)numElements;
+(CGFloat*)getVeibulLowDistributionWithK:(float)k andLambda:(float)lambda andNumElements:(uint)numElements;

+(double)getGammaDensityWithK:(double)k eta:(double)eta andX:(double)x;
+(double)getNormalyzeDensityWithM:(double)m sigma:(double)sigma andX:(double)x;
+(double)getVeibulDensity:(double)k lambda:(double)lambda andX:(double)x;

+(double)getGammaDestributionFunctionWithK:(double)k eta:(double)eta andX:(double)x;
+(double)getNormalyzeDestributionFunctionWithM:(double)m eta:(double)eta andX:(double)x;
+(double)getVeibulDestributionFunctionWithK:(double)k lambda:(double)lambda andX:(double)x;

@end
