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

-(double)getGammaDensityWithK:(float)k eta:(float)eta andX:(float)x;
-(double)getNormalyzeDensityWithM:(float)m sigma:(float)sigma andX:(float)x;
-(double)getVeibulDensity:(float)k lambda:(float)lambda andX:(float)x;

@end
