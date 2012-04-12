//
//  ProbabilityDistribution.m
//  GoldenTriangle
//
//  Created by Skiv on 26.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProbabilityDistribution.h"
#import "ProbalisticLow.h"
#import "MathMehods.h"

static const double eps = 0.0000001;

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
            double x = (double)(rand()%10000+1)/10000.0;
            result[i]-=logf(x);
        }
    }
    
    if(k-k_int>eps){
        double teta = k-k_int;
        double v0 = M_E/(M_E+teta);
        for (int m = 0; m < numElements; ++m) {
            double xm,ym;
            do{
            double v2m = (rand()%10000+1)/10000.;
            double v2m1 = (rand()%10000+1)/10000.;
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


+(double)getGammaDensityWithK:(double)k eta:(double)eta andX:(double)x{
    if(x<0)return 0;
    return pow(x, k-1)*exp(-x/eta)/(pow(eta, k)*gamma(k));
}

+(double)getNormalyzeDensityWithM:(double)m sigma:(double)sigma andX:(double)x{
    return exp(-pow(x-m, 2)/(2*sigma*sigma))/(sqrt(2*M_PI)*sigma);
}

+(double)getVeibulDensity:(double)k lambda:(double)lambda andX:(double)x{
    if(x<0)return 0;
    double res = (k/lambda)*pow(x/lambda, k-1)*exp(-x/lambda);
    return res;
}

+(double)getGammaDestributionFunctionWithK:(double)k eta:(double)eta andX:(double)x{
    ProbalisticLow* low = [ProbalisticLow new];
    low.f_m = @selector(getGammaDensityWithK:eta:andX:);
    low.parametr1 = k;
    low.parametr2 = eta;
    low.selectorClass = [ProbabilityDistribution class];
    return [MathMehods simpsonFromFunction:@selector(getfWithX:) selectorTarget:low isStatic:NO withBorder:CGPointMake(0.0, x) andHalfNumSteps:10000];
}

+(double)getNormalyzeDestributionFunctionWithM:(double)m eta:(double)eta andX:(double)x{
    ProbalisticLow* low = [ProbalisticLow new];
    low.f_m = @selector(getNormalyzeDensityWithM:sigma:andX:);
    low.parametr1 = m;
    low.parametr2 = eta;
    low.selectorClass = [ProbabilityDistribution class];
    return [MathMehods simpsonFromFunction:@selector(getfWithX:) selectorTarget:low isStatic:NO withBorder:CGPointMake(0.0, x) andHalfNumSteps:10000];
}

+(double)getVeibulDestributionFunctionWithK:(double)k lambda:(double)lambda andX:(double)x{
    double res = 1 - exp(-pow(x/lambda, k));
    //NSLog(@"%f", res);
    return res;
}

@end
