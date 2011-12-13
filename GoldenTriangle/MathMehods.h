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
+(CGFloat*)solveEquationVolteraWithKernel:(SEL)kernel f:(SEL)f selectorTarget:(id)selTarget isStatic:(BOOL)isStatic withEndPoint:(float)point lambda:(float)lambda andStep:(float)h;

@end
