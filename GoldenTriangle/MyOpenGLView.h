//
//  MyOpenGLView.h
//  GoldenTriangle
//
//  Created by Skiv on 19.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

enum{
    DRAW_GAMMA_GRAPH = 0,
    DRAW_NORMAL_GRAPH,
    DRAW_VEIBUL_GRAP
}DrawGrafType;

@interface MyOpenGLView : NSOpenGLView{
    
    CGPoint startPointCoordinates;
    CGPoint endPointCoordinates;

}

-(void)plotWithX:(CGFloat*)x y:(CGFloat*)y withPointsNum:(NSInteger)point_num;
-(void)drawGrawWithGraphType:(ushort)graphType andGraphCount:(uint)graphCount;
-(void)clearGraphWithXStart:(float)xStart xEnd:(float)xEnd yStart:(float)yStart yEnd:(float)yEnd;

@end
