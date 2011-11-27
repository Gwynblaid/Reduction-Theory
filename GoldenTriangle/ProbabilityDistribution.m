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

float gammaF(float k, float eta, float x){
    if(x<=0) return 0;
    return powf(eta, k)*powf(x, k-1)*exp(-eta*x)/gamma(k);
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(CGFloat*)getGammaLowDistributionWithK:(float)k eta:(float)eta andNumOfElements:(uint)numElements{
    CGFloat* result = malloc(sizeof(CGFloat)*numElements);
    
    int k_int = (int)k;
    
    for(int i = 0; i < numElements; ++i){
        for(int j = 0; j < k_int; ++j){
            result[i]-=log(gammaF(k_int, 1, ((rand()+1)%1000)/100.0));
        }
    }
    
    if(k-k_int>eps){
        float teta = k-k_int;
        float v0 = M_E/(M_E+teta);
        for (int m = 0; m < numElements; ++m) {
            float xm,ym;
            do{
            float v2m = gammaF(teta, 1, ((rand()+1)%100)/30.0);
            float v2m1 = gammaF(teta, 1, ((rand()+1)%100)/30.0);
            if(v2m <= v0){
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

@end
