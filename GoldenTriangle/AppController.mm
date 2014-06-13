//
//  AppController.m
//  GoldenTriangle
//
//  Created by Skiv on 27.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "StepperController.h"
#import "CoefficientsOfPreparing.h"
#import "ProbalisticLow.h"
#import "ProbabilityDistribution.h"
#import "Equation.h"
#include "NormalizeDestribution.h"
#include "VeibulGnedenkoDestribution.h"
#import "FullEquation.h"

@interface AppController ()

-(ProbabilityDestribution *)distributionWithTag:(NSUInteger) tag x:(CGFloat)x andY:(CGFloat)y;

@end

@implementation AppController
@synthesize fileResultTextField;

- (IBAction)calculateAction:(id)sender {
    Equation* eq = [[Equation alloc] init];
    eq.FDestribution = [self distributionWithTag:self.FComboBox.selectedTag x:[self.FXTextField doubleValue] andY:[self.FYTextField doubleValue]];
    eq.GDestribution = [self distributionWithTag:self.GComboBox.selectedTag x:[self.GXTextField doubleValue] andY:[self.GYTextField doubleValue]];
    eq.resultFile = [self.fileResultTextField stringValue];
    
    FullEquation* fEq = [[FullEquation alloc] init];
    fEq.childEquation = eq;
    fEq.FDestribution = new VeibulGnedenkoDestribution(1, 1);
    fEq.GDestribution = new VeibulGnedenkoDestribution(1, 1);
    fEq.resultFile = [NSString stringWithFormat:@"feq_%@",eq.resultFile];
    [fEq solutionForx:10 y:10];
}

-(ProbabilityDestribution *)distributionWithTag:(NSUInteger) tag x:(CGFloat)x andY:(CGFloat)y{
    if(tag == CBNormalizeDestribution){
        return new NormalizeDestribution(x, y);
    }else if(tag == CBVeibulGnedenkoDestribution){
        return new VeibulGnedenkoDestribution(x, y);
    }
    return NULL;
}

@end
