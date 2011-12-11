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
    DRAW_VEIBUL_GRAPH
};

@interface MyOpenGLView : NSOpenGLView{
    
    CGPoint startPointCoordinates;
    CGPoint endPointCoordinates;
    float max_x;
    BOOL _writeToFile;
    NSString* _fileName;

}

@property (assign) BOOL writeToFile;
@property (retain) NSString* fileName;

-(void)drawGrawWithGraphType:(ushort)graphType andGraphCount:(uint)graphCount withParameter1:(float)parametr1 andParametr2:(float)parametr2;
-(void)clearGraphWithXStart:(float)xStart xEnd:(float)xEnd yStart:(float)yStart yEnd:(float)yEnd;

@end
