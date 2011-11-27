//
//  MyOpenGLView.h
//  GoldenTriangle
//
//  Created by Skiv on 19.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface MyOpenGLView : NSOpenGLView{
    
    CGPoint startPointCoordinates;
    CGPoint endPointCoordinates;

}

-(void)plotWithX:(CGFloat*)x y:(CGFloat*)y withPointsNum:(NSInteger)point_num;
-(void)drawGamma;

@end
