//
//  TestData.m
//  GoldenTriangle
//
//  Created by Skiv on 10.01.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TestData.h"

@implementation TestData

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(double)kernelX:(double)x s:(double)s{
    return exp(-x-s);
}

-(double)fX:(double)x{
    return 0.5*(exp(-x) + exp(-3*x));
}

@end
