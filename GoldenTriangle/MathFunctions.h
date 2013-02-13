//
//  MathFunctions.h
//  GoldenTriangle
//
//  Created by Skiv on 21.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef GoldenTriangle_MathFunctions_h
#define GoldenTriangle_MathFunctions_h

int sign(float dig){
    if(dig < 0)
        return -1;
    if(dig > 0)
        return 1;
    return 0;
}

double sh(double x){
    return (exp(x) - exp(-x)) / 2.;
}

double ch(double x){
    return (exp(x) + exp(-x)) / 2.;
}

#endif
