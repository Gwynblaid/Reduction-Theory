//
//  MyOpenGLView.m
//  GoldenTriangle
//
//  Created by Skiv on 19.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyOpenGLView.h"
#include <OpenGL/gl.h>
#import "MatrixOperation.h"
#include <FTGL/ftgl.h>
#include <FTGL/FTGLBitmapFont.h>
#include "MathFunctions.h"
#include "ProbabilityDistribution.h"
#import  <objc/objc.h>
#import  <objc/Object.h>

@interface MyOpenGLView()
-(void)draw2DCoordinatesXStart:(float)xStart xEnd:(float)xEnd yStart:(float)yStart yEnd:(float)yEnd;
-(void)drawDottedLineWithStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint andLineColor:(CGFloat*)color;
-(void)drawArrowInPoint:(CGPoint)arrowPoint withColor:(CGFloat*)color andAngle:(CGFloat)ang;
-(void)drawText:(NSString*)text inPoint:(CGPoint)textPoint withFontSize:(int)font_size;
-(CGFloat)getStepInRange:(CGPoint)range;
-(CGPoint)transformCoordinate:(CGPoint)point;
-(void)drawGraphWithParametr1:(float)parametr1 parametr2:(float)parametr2 countGraph:(uint)count andSelector:(SEL)selector;
//-(void)drawGamma;
@end

@implementation MyOpenGLView

@synthesize writeToFile = _writeToFile;
@synthesize fileName = _fileName;

static CGFloat step_delta = 1.9/11.0;

static float max_delta = 0.05;

-(NSString*)fileName{
    if(!_fileName){
        _fileName = @"Output.txt";
    }
    return _fileName;
}

-(CGPoint)transformCoordinate:(CGPoint)point{
    return CGPointMake((point.x-startPointCoordinates.x)/(endPointCoordinates.x - startPointCoordinates.x)*(1-step_delta+0.9)-0.9, (point.y-startPointCoordinates.y)/(endPointCoordinates.y - startPointCoordinates.y)*(1-step_delta+0.9)-0.9);
}

-(void)draw2DCoordinatesXStart:(float)xStart xEnd:(float)xEnd yStart:(float)yStart yEnd:(float)yEnd{
    assert(xStart < xEnd);
    assert(yStart < yEnd);
    CGFloat* color = new CGFloat[3];
    color[0] = 0.0;
    color[1] = 0.0;
    color[2] = 0.0;
    
    CGFloat delta_x = [self getStepInRange:CGPointMake(xStart, xEnd)];
    CGFloat delta_y = [self getStepInRange:CGPointMake(yStart, yEnd)];
    
    CGFloat curr_x = (int(xStart/delta_x)+sign(xStart))*delta_x;
    CGFloat curr_y = (int(yStart/delta_y)+sign(yStart))*delta_y;
    // If something went wrong, bail out.
    
    startPointCoordinates = CGPointMake(curr_x, curr_y);
    
    CGFloat* colorDottedLines = new CGFloat[3];
    colorDottedLines[0] = 0.0;
    colorDottedLines[1] = 0.5;
    colorDottedLines[2] = 1.0;
    
    for(float delt = -0.9; delt<1.0; delt+=step_delta){
        [self drawDottedLineWithStartPoint:CGPointMake(delt, -0.9) EndPoint:CGPointMake(delt, 0.9) andLineColor:colorDottedLines];
        [self drawDottedLineWithStartPoint:CGPointMake(-0.9, delt) EndPoint:CGPointMake(0.9, delt) andLineColor:colorDottedLines];
        glBegin(GL_LINES);
        glLineWidth(2.0);
        glColor3f(color[0], color[1], color[2]);
        glVertex2f(delt, -0.9);
        glVertex2f(delt, -0.85);
        glVertex2f(-0.9, delt);
        glVertex2f(-0.85, delt);
        glEnd();
        
        if(delt> -0.8){
            glColor3f( 0.0, 0.0, 0.0);
            [self drawText:[NSString stringWithFormat:@"%1.1f",curr_x] inPoint:CGPointMake(delt-step_delta/6, -0.95) withFontSize:12];
            [self drawText:[NSString stringWithFormat:@"%1.0f",curr_y] inPoint:CGPointMake(-0.97, delt) withFontSize:12];
        }
        curr_x+=delta_x;
        curr_y+=delta_y;
    }
    
    endPointCoordinates = CGPointMake(curr_x-delta_x, curr_y - delta_y);
    
    static const float coordinates[]=
    {
        -0.9, 0.9, 0,
        -0.9, -0.9, 0,
        0.9, -0.9, 0,
    };
    glEnableClientState(GL_VERTEX_ARRAY);
    glLineWidth(2.0);
    glColor3f(color[0], color[1], color[2]);
    glVertexPointer(3, GL_FLOAT, 0, coordinates);
    glDrawArrays(GL_LINE_STRIP, 0, 3);
    glDisableClientState(GL_VERTEX_ARRAY);
    
    [self drawArrowInPoint:CGPointMake(0.9, 0.9) withColor:color andAngle:M_PI_2];
    [self drawArrowInPoint:CGPointMake(0.9, -0.9) withColor:color andAngle:0];
    glColor3f( 1.0, 0.0, 0.0);
    [self drawText:@"T" inPoint:CGPointMake(0.92, -0.9) withFontSize:20];
    [self drawText:@"N(t)" inPoint:CGPointMake(-0.89, 0.89) withFontSize:20];
    
}

-(CGFloat)getStepInRange:(CGPoint)range{
    CGFloat delta = fabs(range.x)+fabs(range.y);
    /*int it = 0;
    if(delta < 1){
        while (delta < 1) {
            --it;
            delta*=10;
        }
    }else{
        while (delta > 1) {
            ++it;
            delta/=10;
        }
    }*/
    return delta/10.0;
}

-(void)drawArrowInPoint:(CGPoint)arrowPoint withColor:(CGFloat*)color andAngle:(CGFloat)ang{
    float angle = M_PI/6;
    float cos_angle = cos(angle);
    float sin_angle = sin(angle);
    float arrow_coordinates[] = {
        arrowPoint.x - 0.05*cos_angle, arrowPoint.y+0.05*sin_angle, 0.0,
        arrowPoint.x,                  arrowPoint.y,                0.0,
        arrowPoint.x - 0.05*cos_angle, arrowPoint.y-0.05*sin_angle, 0.0
    };
    [MatrixOperation zRotationCoordinates:arrow_coordinates withNumCoordinates:9 byAngle:ang];
    glEnableClientState(GL_VERTEX_ARRAY);
    glLineWidth(2);
    glColor3f(color[0], color[1], color[2]);
    glVertexPointer(3, GL_FLOAT, 0, arrow_coordinates);
    glDrawArrays(GL_LINE_STRIP, 0, 3);
    glDisableClientState(GL_VERTEX_ARRAY);
    
}

-(void)drawDottedLineWithStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint andLineColor:(CGFloat*)color{
    float lenght = sqrtf(powf(startPoint.x-endPoint.x, 2)+powf((startPoint.y-endPoint.y), 2));
    float delta = lenght/10.0;
    if(delta > max_delta){
        delta = max_delta;
    }
    float sin_alf = (endPoint.y-startPoint.y)/lenght;
    float cos_alf = (endPoint.x-startPoint.x)/lenght;
    glEnable(GL_BLEND);
    glColor4f(color[0], color[1], color[2], 0.1);
    glLineWidth(0.01);
    glBegin(GL_LINES);
    for(float step = 0.0; step < lenght; step+=(1.5*delta)){
        float endLine = step+delta;
        if(endLine > lenght){
            endLine = lenght;
        }
        glVertex2f(startPoint.x+step*cos_alf,startPoint.y+step*sin_alf);
        glVertex2f(startPoint.x+endLine*cos_alf,startPoint.y+endLine*sin_alf);
       
    }
     glEnd();
}

-(void)drawText:(NSString*)text inPoint:(CGPoint)textPoint withFontSize:(int)font_size{
    FTGLBitmapFont* font = new FTGLBitmapFont( "/Library/Fonts/Arial Bold.ttf" );
    
    if( font->Error() )
    {
        fprintf( stderr, "Failed to open font" );
        exit(1);
    }
    if( !font->FaceSize( font_size ) ) 
    {
        fprintf( stderr, "Failed to set size");
        exit(1);
    }
    glRasterPos2f( textPoint.x, textPoint.y); 
    font->Render( [text cStringUsingEncoding:NSUTF8StringEncoding] );
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)drawRect:(NSRect)dirtyRect{
    [self clearGraphWithXStart:0 xEnd:10 yStart:0 yEnd:10];
}

-(void)clearGraphWithXStart:(float)xStart xEnd:(float)xEnd yStart:(float)yStart yEnd:(float)yEnd{
    glClearColor(1, 1, 1, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    [self draw2DCoordinatesXStart:xStart xEnd:xEnd yStart:yStart yEnd:yEnd];
    glFlush();
}

-(void)drawGrawWithGraphType:(ushort)graphType andGraphCount:(uint)graphCount withParameter1:(float)parametr1 andParametr2:(float)parametr2{
    if(!graphCount){
        NSLog(@"graphCount nust be > 0");
        return;
    }
    if(parametr1<0||parametr2 < 0){
        NSLog(@"Envalid parameters");
        return;
    }
    switch (graphType) {
        case DRAW_GAMMA_GRAPH:
            [self drawGraphWithParametr1:parametr1 parametr2:parametr2 countGraph:graphCount andSelector:@selector(getGammaLowDistributionWithK:eta:andNumOfElements:)];
            break;
        case DRAW_NORMAL_GRAPH:
            [self drawGraphWithParametr1:parametr1 parametr2:parametr2 countGraph:graphCount andSelector:@selector(getNormalyzeLowDistributionWithM:andSigma:andNumElements:)];
            break;
        case DRAW_VEIBUL_GRAPH:
            [self drawGraphWithParametr1:parametr1 parametr2:parametr2 countGraph:graphCount andSelector:@selector(getVeibulLowDistributionWithK:andLambda:andNumElements:)];
            break;
        default:
            NSLog(@"Error, not valid type");
            return;
            break;
    }
}

-(void)drawGraphWithParametr1:(float)parametr1 parametr2:(float)parametr2 countGraph:(uint)count andSelector:(SEL)selector{
    NSString* resultToFile = @"";
    max_x = 0;
    uint parametr3 = 11;
    CGFloat** sv_mat = new CGFloat*[count];
    if(![ProbabilityDistribution respondsToSelector:selector]) return;
    for(uint i = 0 ;i < count; ++i){
        Method method = class_getClassMethod([ProbabilityDistribution class], selector);
        struct objc_method_description* desc = method_getDescription(method);
        if (desc == NULL || desc->name == NULL)
            return;
        
        NSMethodSignature* sig = [NSMethodSignature signatureWithObjCTypes:desc->types];
        CGFloat* sv = nil;
        NSInvocation* invoc = [NSInvocation invocationWithMethodSignature:sig];
        [invoc setTarget:[ProbabilityDistribution class]];
        [invoc setSelector:selector];
        //[invoc setArgument:sv atIndex:1];
        [invoc setArgument:&parametr1 atIndex:2];
        [invoc setArgument:&parametr2 atIndex:3];
        [invoc setArgument:&parametr3 atIndex:4];
        [invoc invoke];
        [invoc getReturnValue:&sv];
        sv_mat[i] = sv;
        CGFloat max_x_temp = 0;
        for(int i = 0; i < 11; ++i){
            max_x_temp+=sv[i];
        }
        if(max_x_temp>max_x){
            max_x = max_x_temp;
        }
    }
    [self clearGraphWithXStart:0 xEnd:max_x yStart:0 yEnd:10];
    
    for(uint i = 0; i < count; ++i){
        float start_x = 0;
        glColor3f(0, 1/(float)i, 0);
        glBegin(GL_LINE_STRIP);
        for(int j = 0; j < 11; ++j){
            CGPoint pt = [self transformCoordinate:CGPointMake(start_x, j)];
            glVertex2f(pt.x, pt.y);
            start_x+=sv_mat[i][j];
            pt = [self transformCoordinate:CGPointMake(start_x, j)];
            glVertex2f(pt.x, pt.y);
            resultToFile = [resultToFile stringByAppendingFormat:@"[%d:%f] ",j,start_x];
        }
        resultToFile = [resultToFile stringByAppendingFormat:@"\n\n"];
        glEnd();
    }
    glFlush();
    if(_writeToFile){
        NSError* err = nil;
        [resultToFile writeToFile:self.fileName atomically:YES encoding:NSUTF8StringEncoding error:&err];
        if(err){
            NSLog(@"error: %@",err);
        }
    }
}

@end
