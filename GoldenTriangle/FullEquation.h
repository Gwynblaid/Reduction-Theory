//
//  FullEquation.h
//  GoldenTriangle
//
//  Created by Sergey Harchenko on 05.06.14.
//
//

#import "Equation.h"

@interface FullEquation : Equation

@property(nonatomic, strong) Equation* childEquation;

@end
