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
}

-(double)Kx:(double)x s:(double)s y:(double)y l:(double)l;
-(double)fx:(double)x y:(double)y;
-(double **)solutionForx:(double)x y:(double)y;

@property (nonatomic, assign) ProbabilityDestribution* GDestribution;
@property (nonatomic, assign) ProbabilityDestribution* FDestribution;
@property (nonatomic, strong) NSString* resultFile;

@property (nonatomic, assign, readonly) NSUInteger x_size;
@property (nonatomic, assign, readonly) NSUInteger y_size;
@property (nonatomic, assign, readonly) double ** result;

@end
