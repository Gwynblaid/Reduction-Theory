//
//  MathMehods.h
//  GoldenTriangle
//
//  Created by Skiv on 13.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathMehods : NSObject

//kernel must be implement in same class and have same mode like f
+(double*)solveEquationVolteraWithKernel:(SEL)kernel f:(SEL)f selectorTarget:(id)selTarget isStatic:(BOOL)isStatic withEndPoint:(double)point lambda:(double)lambda andStep:(double)h;

@end
