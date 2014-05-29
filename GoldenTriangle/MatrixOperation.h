//
//  MatrixOperation.h
//  GoldenTriangle
//
//  Created by Skiv on 20.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatrixOperation : NSObject

+(void)zRotationCoordinates:(float*)coord withNumCoordinates:(NSInteger)numCoord byAngle:(float)angle;
+(void)yRotationCoordinates:(float*)coord withNumCoordinates:(NSInteger)numCoord byAngle:(float)angle;
+(void)xRotationCoordinates:(float*)coord withNumCoordinates:(NSInteger)numCoord byAngle:(float)angle;

@end
