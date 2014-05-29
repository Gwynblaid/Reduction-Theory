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

struct MyGLColor{
    double red;
    double green;
    double blue;
    double alplha;
};

@class ProbalisticLow;
@class CoefficientsOfPreparing;

@interface MyOpenGLView : NSOpenGLView{
    
    CGPoint startPointCoordinates;
    CGPoint endPointCoordinates;
    float max_x;
    BOOL _writeToFile;
    NSString* _fileName;
    ProbalisticLow* low;

}

@property (assign) BOOL writeToFile;
@property (retain, nonatomic) NSString* fileName;
@property (strong, nonatomic) NSString* yLabel;
@property (strong, nonatomic) NSString* xLabel;

-(void)drawGrawWithGraphType:(ushort)  graphType andGraphCount:(uint)graphCount withParameter1:(float)parametr1 andParametr2:(float)parametr2;
-(void)clearGraphWithXStart:(float)xStart xEnd:(float)xEnd yStart:(float)yStart yEnd:(float)yEnd;
-(void)plotGraphWithXArray:(CGFloat*)xArray andYArray:(CGFloat*)yArray andNumPoints:(uint)numPoints withColor:(struct MyGLColor)color;
-(void)drawGraphForCoefficient:(CoefficientsOfPreparing *)coefData andEndingT:(double)t;

//test data for Simpson
-(double)testFun:(double)x;

//test data for Summ

-(double)kernelWithX:(double)x andT:(double)t;
-(double)fX:(double)x;
-(double)solution:(double)x;
-(void)drawLabGraph;
-(void)drawLabGraph2;
-(void)drawLabGraph3;

@end
