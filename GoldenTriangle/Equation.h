//
//  Equation.h
//  GoldenTriangle
//
//  Created by Sergey Harchenko on 6/5/13.
//
//

#import <Foundation/Foundation.h>
#include "VeibulGnedenkoDestribution.h"
#include "NormalizeDestribution.h"

@interface Equation : NSObject{
    NormalizeDestribution* normalDestr;
}

-(double)Kx:(double)x s:(double)s y:(double)y l:(double)l;
-(double)fx:(double)x y:(double)y;
-(NSArray *)solutionForx:(double)x y:(double)y;

@end
