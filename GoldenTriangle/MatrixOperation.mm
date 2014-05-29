//
//  MatrixOperation.m
//  GoldenTriangle
//
//  Created by Skiv on 20.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MatrixOperation.h"

@implementation MatrixOperation

+(void)zRotationCoordinates:(float*)coord withNumCoordinates:(NSInteger)numCoord byAngle:(float)angle{
    assert(numCoord%3==0);
    float cos_angle = cos(angle);
    float sin_angle = sin(angle);
    float x,y;
    for(int i = 0; i < numCoord; i+=3){
        x = coord[i]*cos_angle - coord[i+1]*sin_angle;
        y = coord[i]*sin_angle + coord[i+1]*cos_angle;
        coord[i]   = x;
        coord[i+1] = y;
    }
}

+(void)yRotationCoordinates:(float*)coord withNumCoordinates:(NSInteger)numCoord byAngle:(float)angle{
    assert(numCoord%3==0);
    float cos_angle = cos(angle);
    float sin_angle = sin(angle);
    float x,y;
    for(int i = 0; i < numCoord; i+=3){
        x = coord[i]*cos_angle + coord[i+2]*sin_angle;
        y = -coord[i]*sin_angle + coord[i+2]*cos_angle;
        coord[i]   = x;
        coord[i+1] = y;
    }
}

+(void)xRotationCoordinates:(float*)coord withNumCoordinates:(NSInteger)numCoord byAngle:(float)angle{
    assert(numCoord%3==0);
    float cos_angle = cos(angle);
    float sin_angle = sin(angle);
    float x,y;
    for(int i = 0; i < numCoord; i+=3){
        x = coord[i+1]*cos_angle - coord[i+2]*sin_angle;
        y = coord[i+1]*sin_angle + coord[i+2]*cos_angle;
        coord[i]   = x;
        coord[i+1] = y;
    }
}

@end
