//
//  FullEquation.m
//  GoldenTriangle
//
//  Created by Sergey Harchenko on 05.06.14.
//
//

#import "FullEquation.h"

@interface FullEquation()

@property (nonatomic, assign) double c_x;
@property (nonatomic, assign) double c_y;

@end

@implementation FullEquation
@synthesize c_x = c_x;
@synthesize c_y = c_y;

-(double)fx:(double)x y:(double)y{
    int i = (x / c_x) * (self.childEquation.x_size - 1);
    int j = (y / c_y) * (self.childEquation.y_size - 1);
    return self.childEquation.result[i][j];
}

-(double ** )solutionForx:(double)x y:(double)y{
    [self.childEquation solutionForx:x y:y];
    c_x = x;
    c_y = y;
    return [super solutionForx:x y:y];
}

@end
