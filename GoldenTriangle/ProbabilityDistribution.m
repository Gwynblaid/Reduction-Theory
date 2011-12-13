//
//  ProbabilityDistribution.m
//  GoldenTriangle
//
//  Created by Skiv on 26.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProbabilityDistribution.h"

static const float eps = 0.0000001;

@implementation ProbabilityDistribution

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark -
#pragma mark destribution

+(CGFloat*)getGammaLowDistributionWithK:(float)k eta:(float)eta andNumOfElements:(uint)numElements{
    CGFloat* result = malloc(sizeof(CGFloat)*numElements);
    
    int k_int = (int)k;
    
    for(int i = 0; i < numElements; ++i){
        result[i] = 0;
        for(int j = 0; j < k_int; ++j){
            float x = (float)(rand()%10000+1)/10000.0;
            result[i]-=logf(x);
        }
    }
    
    if(k-k_int>eps){
        float teta = k-k_int;
        float v0 = M_E/(M_E+teta);
        for (int m = 0; m < numElements; ++m) {
            float xm,ym;
            do{
            float v2m = (rand()%10000+1)/10000.;
            float v2m1 = (rand()%10000+1)/10000.;
            if(v2m1 <= v0){
                xm = powf((v2m1/v0),1/teta);
                ym = v2m*powf(xm, teta-1);
            }else{
                xm = 1 - log((v2m1-v0)/(1-v0));
                ym = v2m*exp(-xm);
            }
            }while (ym>powf(xm, teta-1)*exp(-xm));
            result[m]+=xm;
            result[m]/=eta;
        }
    }
    
    return result;
}

+(CGFloat*)getNormalyzeLowDistributionWithM:(float)m andSigma:(float)sigma andNumElements:(uint)numElements{
    CGFloat* result = malloc(sizeof(CGFloat)*numElements);
    for(uint i = 0; i < numElements; ++i){
        result[i] = m+(cos(2*M_PI*((rand()%10000+1)/10000.))*sqrtf(-2*log((rand()%10000+1)/10000.)))*sigma;
    }
    return result;
}

+(CGFloat*)getVeibulLowDistributionWithK:(float)k andLambda:(float)lambda andNumElements:(uint)numElements{
    CGFloat* result = malloc(sizeof(CGFloat)*numElements);
    for(uint i = 0; i < numElements; ++i){
        result[i] = lambda*powf(fabsf(logf(1-(rand()%10000+1)/10000.)),1./k);
    }
    return result;
}

#pragma mark -
#pragma mark density


-(double)getGammaDensityWithK:(float)k eta:(float)eta andX:(float)x{
    if(x<0)return 0;
    return pow(x, k-1)*exp(-x/eta)/(pow(eta, k)*gamma(k));
}

-(double)getNormalyzeDensityWithM:(float)m sigma:(float)sigma andX:(float)x{
    return exp(-pow(x-m, 2)/(2*sigma*sigma))/(sqrt(2*M_PI)*sigma);
}

-(double)getVeibulDensity:(float)k lambda:(float)lambda andX:(float)x{
    if(x<0)return 0;
    return (k/lambda)*pow(x/lambda, k-1)*exp(-x/lambda);
}

@end
