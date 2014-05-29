//
//  GraphView.m
//  GoldenTriangle
//
//  Created by Sergey Harchenko on 5/20/13.
//
//

#import "GraphView.h"
#import "MatrixOperation.h"
#include <FTGL/ftgl.h>
#include <FTGL/FTGLBitmapFont.h>
#import <OpenGL/gl.h>

typedef enum{
    none = 0,
    Graph2D,
    Graph3D,
    Gist
} GraphType;

typedef enum{
    OrtaX,
    OrtaY,
    OrtaZ
} Orta;

Point3D Point3DMake(CGFloat x, CGFloat y, CGFloat z){
    Point3D* result = new Point3D();
    result->x = x;
    result->y = y;
    result->z = z;
    return *result;
}

@interface GraphView()
@property(nonatomic) GraphType type;
@property(nonatomic) CGPoint xRange;
@property(nonatomic) CGPoint yRange;
@property(nonatomic) CGPoint zRange;

-(void)drawCoordinatesWithXRange:(CGPoint)xRange andYRange:(CGPoint)yRange;
-(void)drawCoordinatesWithXRange:(CGPoint)xRange yRange:(CGPoint)yRange andZRange:(CGPoint)zRange;
-(CGFloat)getStepInRange:(CGPoint)range;

-(void)drawDottedLineWithStartPoint:(Point3D)startPoint EndPoint:(Point3D)endPoint andLineColor:(CGFloat*)color;
-(void)drawArrowInPoint:(Point3D)arrowPoint withColor:(CGFloat*)color withAngle:(CGFloat)ang around:(Orta)orta;
-(void)drawText:(NSString*)text inPoint:(Point3D)textPoint withFontSize:(int)font_size;

@end

@implementation GraphView

static CGFloat step_delta = 0.145;
static float max_delta = 0.05;

-(NSString *)xLabel{
    if(!_xLabel){
        _xLabel = @"x";
    }
    return _xLabel;
}

-(NSString *)yLabel{
    if(!_yLabel){
        _yLabel = @"y";
    }
    return _yLabel;
}

-(NSString *)zLabel{
    if(!_zLabel){
        _zLabel = @"z";
    }
    return _zLabel;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    glClearColor(1, 1, 1, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    NSMutableArray* xArray = [NSMutableArray array];
    NSMutableArray* yArray = [NSMutableArray array];
    NSMutableArray* zArray = [NSMutableArray array];
    for(double i = 0;  i < 1; i+=0.001){
        for(double j = 0;  j < 1; j+=0.001){
            [xArray addObject:@(i)];
            [yArray addObject:@(j)];
            [zArray addObject:@(sin(i + j))];
        }
    }
    [self drawGraphWithX:xArray Y:yArray andZ:zArray];
    //[self drawCoordinatesWithXRange:CGPointMake(0, 1) yRange:CGPointMake(0, 1) andZRange:CGPointMake(0, 1)];
    glFlush();
}


-(CGFloat)getStepInRange:(CGPoint)range{
    CGFloat delta = fabs(range.x -range.y);
    return delta/10.0;
}

-(void)drawGraphWithX:(NSArray *)xArray andY:(NSArray *)yArray{
    self.type = Graph2D;
    NSLog(@"Not realized");
}

-(void)drawGraphWithX:(NSArray *)xArray Y:(NSArray *)yArray andZ:(NSArray *)zArray{
    self.type = Graph3D;
    CGPoint xRange = CGPointMake([[xArray valueForKeyPath:@"@min.self"] doubleValue], [[xArray valueForKeyPath:@"@max.self"] doubleValue]);
    CGPoint yRange = CGPointMake([[yArray valueForKeyPath:@"@min.self"] doubleValue], [[yArray valueForKeyPath:@"@max.self"] doubleValue]);
    CGPoint zRange = CGPointMake([[zArray valueForKeyPath:@"@min.self"] doubleValue], [[zArray valueForKeyPath:@"@max.self"] doubleValue]);
    [self drawCoordinatesWithXRange:xRange yRange:yRange andZRange:zRange];
    glBegin(GL_POINTS);
    for(int i = 0;i < xArray.count; ++i){
        NSNumber* x = xArray[i];
        NSNumber* y = yArray[i];
        NSNumber* z = zArray[i];
        Point3D point = [self transformCoordinate:Point3DMake(x.doubleValue, y.doubleValue, z.doubleValue)];
        glVertex3f(point.x, point.y, point.z);
    }
    glEnd();
}

-(void)drawCoordinatesWithXRange:(CGPoint)xRange andYRange:(CGPoint)yRange{
    [self drawCoordinatesWithXRange:xRange yRange:yRange andZRange:CGPointMake(0, 0)];
}

-(Point3D)transformCoordinate:(Point3D)point{
    return Point3DMake((point.y-self.yRange.x)/(self.yRange.y - self.yRange.x)*(1.33) + (point.x - self.xRange.x)/(self.xRange.y - self.xRange.x)*(-0.67)-0.33, (point.z-self.zRange.x)/(self.zRange.y - self.zRange.x)*(1.33) + (point.x - self.xRange.x)/(self.xRange.y - self.xRange.x)*(-0.67)-0.33, (point.z-self.zRange.x)/(self.zRange.y - self.zRange.x)*2 - 1);
}

-(void)drawCoordinatesWithXRange:(CGPoint)xRange yRange:(CGPoint)yRange andZRange:(CGPoint)zRange{
    assert(xRange.x < xRange.y);
    assert(yRange.x < yRange.y);
    self.xRange = xRange;
    self.yRange = yRange;
    self.zRange = zRange;
    if(self.type == none){
        if(zRange.x == zRange.y){
            self.type = Graph2D;
        }else{
            self.type = Graph3D;
        }
    }
    CGFloat* color = new CGFloat[3];
    color[0] = 0.1;
    color[1] = 0.1;
    color[2] = 0.6;
    
    CGFloat delta_x = [self getStepInRange:CGPointMake(xRange.x, xRange.y)];
    CGFloat delta_y = [self getStepInRange:CGPointMake(yRange.x, yRange.y)];
    CGFloat delta_z = [self getStepInRange:CGPointMake(zRange.x, zRange.y)];
    CGFloat curr_x = xRange.x;
    CGFloat curr_z = zRange.x;
    CGFloat curr_y = yRange.x;
    
    CGFloat* colorDottedLines = new CGFloat[3];
    colorDottedLines[0] = 0.0;
    colorDottedLines[1] = 0.5;
    colorDottedLines[2] = 1.0;
    
    for(float delt = -0.9; delt<1.1; delt+=step_delta){
        if(self.type == Graph2D || self.type == Gist){
            [self drawDottedLineWithStartPoint:Point3DMake(-0.9, delt, 0) EndPoint:Point3DMake(0.9, delt, 0) andLineColor:colorDottedLines];
            [self drawDottedLineWithStartPoint:Point3DMake(delt, -0.9, 0) EndPoint:Point3DMake(delt, 0.9, 0) andLineColor:colorDottedLines];
        }else{
            
        }
        if(self.type != Graph3D){
            glBegin(GL_LINES);
            glLineWidth(2.0);
            glColor3f(color[0], color[1], color[2]);
            glVertex3f(delt, -0.9, 0);
            glVertex3f(delt, -0.85, 0);
            glVertex3f(-0.9, delt , 0);
            glVertex3f(-0.85, delt, 0);
            glEnd();
            glColor3f( 0.0, 0.0, 0.0);
            if(delt> -0.8){
                [self drawText:[NSString stringWithFormat:@"%1.1f",curr_x] inPoint:Point3DMake(delt-step_delta/6, -0.95, 0) withFontSize:12];
                [self drawText:[NSString stringWithFormat:@"%1.1f",curr_y] inPoint:Point3DMake(-0.97, delt, 0) withFontSize:12];
            }
        }else{
            glBegin(GL_LINES);
            glLineWidth(2.0);
            glColor3f(color[0], color[1], color[2]);
            glVertex3f(-0.33 + ((delt + 0.9)/1.9) * 1.67, -0.33, -1);
            glVertex3f(-0.33 + ((delt + 0.9)/1.9) * 1.67 - 0.03, -0.36, -1);
            glVertex3f(-0.33, -0.33 + ((delt + 0.9)/1.9) * 1.67 , -1);
            glVertex3f(-0.315, -0.33 + ((delt + 0.9)/1.9) * 1.67, -1);
            glVertex3f(-0.33 - ((delt + 0.9)/1.9) * 0.67, -0.33 - ((delt + 0.9)/1.9) * 0.67 , delt);
            glVertex3f(-0.3 - ((delt + 0.9)/1.9) * 0.67, -0.33 - ((delt + 0.9)/1.9) * 0.67, delt);
            glEnd();
            glColor3f(0, 0, 0);
            if(delt > -0.89
               ){
                [self drawText:[NSString stringWithFormat:@"%1.1f",curr_y] inPoint:Point3DMake(-0.33 + ((delt + 0.9)/1.9) * 1.67, -0.3, -1) withFontSize:12];
                [self drawText:[NSString stringWithFormat:@"%1.1f",curr_z] inPoint:Point3DMake(-0.4, -0.36 + ((delt + 0.9)/1.9) * 1.67 , -1) withFontSize:12];
                [self drawText:[NSString stringWithFormat:@"%1.1f",curr_x] inPoint:Point3DMake(-0.4 - ((delt + 0.9)/1.9) * 0.67, -0.33 - ((delt + 0.9)/1.9) * 0.67 , delt) withFontSize:12];
            }
        }
        
        curr_x+=delta_x;
        curr_y+=delta_y;
        curr_z+=delta_z;
    }
    
    if(self.type == Graph3D){
        static const float coordinates3D[] =
        {
            -0.33, 1, -1,
            -0.33, -0.33, -1,
            -0.33, -0.33, -1,
             1, -0.33, -1,
            -0.33, -0.33, -1,
            -1, -1, 1,
        };
        glEnableClientState(GL_VERTEX_ARRAY);
        glLineWidth(2.0);
        glColor3f(color[0], color[1], color[2]);
        glVertexPointer(3, GL_FLOAT, 0, coordinates3D);
        glDrawArrays(GL_LINES, 0, 6);
        glDisableClientState(GL_VERTEX_ARRAY);
        glColor3f( 1.0, 0.0, 0.0);
        [self drawText:self.xLabel inPoint:Point3DMake(-0.99, -0.95, 0.95) withFontSize:20];
        [self drawText:self.yLabel inPoint:Point3DMake(0.95, -0.25, -1) withFontSize:20];
        [self drawText:self.zLabel inPoint:Point3DMake(-0.28, 0.95, -1) withFontSize:20];
        
        //[self drawArrowInPoint:Point3DMake(1, 0.33, -1) withColor:color withAngle:M_PI_2 around:OrtaZ];
        //[self drawArrowInPoint:Point3DMake(1, -0.33, -1) withColor:color withAngle:0 around:OrtaZ];
        //[self drawArrowInPoint:Point3DMake(0.6, 1, 1) withColor:color withAngle:5*M_PI_4 around:OrtaZ];
    }else{
        static const float coordinates2D[] =
        {
            -0.9, 0.9, 0,
            -0.9, -0.9, 0,
            -0.9, -0.9, 0,
            0.9, -0.9, 0,
            -0.9, -0.9, -0.9,
            -0.9, -0.9, 0.9,
        };
        glEnableClientState(GL_VERTEX_ARRAY);
        glLineWidth(2.0);
        glColor3f(color[0], color[1], color[2]);
        glVertexPointer(3, GL_FLOAT, 0, coordinates2D);
        glDrawArrays(GL_LINES, 0, 4);
        glDisableClientState(GL_VERTEX_ARRAY);
        [self drawArrowInPoint:Point3DMake(0.9, 0.9, 0) withColor:color withAngle:M_PI_2 around:OrtaZ];
        [self drawArrowInPoint:Point3DMake(0.9, -0.9, 0) withColor:color withAngle:0 around:OrtaZ];
        glColor3f( 1.0, 0.0, 0.0);
        [self drawText:self.xLabel inPoint:Point3DMake(0.92, -0.9, 0) withFontSize:20];
        [self drawText:self.yLabel inPoint:Point3DMake(-0.89, 0.89, 0) withFontSize:20];
    }
    delete []color;
    delete []colorDottedLines;
}

-(void)drawDottedLineWithStartPoint:(Point3D)startPoint EndPoint:(Point3D)endPoint andLineColor:(CGFloat*)color{
    float lenght = sqrtf(powf(startPoint.x-endPoint.x, 2)+powf((startPoint.y-endPoint.y), 2) + powf((startPoint.z-endPoint.z), 2));
    float delta = lenght/10.0;
    if(delta > max_delta){
        delta = max_delta;
    }
    float yAlf = (endPoint.y-startPoint.y)/lenght;
    float xAlf = (endPoint.x-startPoint.x)/lenght;
    float zAlf = (endPoint.z - startPoint.z)/lenght;
    glEnable(GL_BLEND);
    glColor4f(color[0], color[1], color[2], 0.1);
    glLineWidth(0.01);
    glBegin(GL_LINES);
    for(float step = 0.0; step < lenght; step+=(1.5*delta)){
        float endLine = step+delta;
        if(endLine > lenght){
            endLine = lenght;
        }
        glVertex3f(startPoint.x+step*xAlf,startPoint.y+step*yAlf,startPoint.z+step*zAlf );
        glVertex3f(startPoint.x+endLine*xAlf,startPoint.y+endLine*yAlf, startPoint.z+endLine*zAlf);
        
    }
    glEnd();
}

-(void)drawArrowInPoint:(Point3D)arrowPoint withColor:(CGFloat*)color withAngle:(CGFloat)ang around:(Orta)orta{
    float angle = M_PI/6;
    float cos_angle = cos(angle);
    float sin_angle = sin(angle);
    float arrow_coordinates[] = {
        arrowPoint.x - 0.05*cos_angle, arrowPoint.y+0.05*sin_angle, arrowPoint.z,
        arrowPoint.x,                  arrowPoint.y,                arrowPoint.z,
        arrowPoint.x - 0.05*cos_angle, arrowPoint.y-0.05*sin_angle, arrowPoint.z
    };
    switch (orta) {
        case OrtaX:
            [MatrixOperation xRotationCoordinates:arrow_coordinates withNumCoordinates:9 byAngle:ang];
            break;
        case OrtaY:
            [MatrixOperation yRotationCoordinates:arrow_coordinates withNumCoordinates:9 byAngle:ang];
            break;
        case OrtaZ:
            [MatrixOperation zRotationCoordinates:arrow_coordinates withNumCoordinates:9 byAngle:ang];
            break;
        default:
            assert(NO);
            break;
    }

    glEnableClientState(GL_VERTEX_ARRAY);
    glLineWidth(2);
    glColor3f(color[0], color[1], color[2]);
    glVertexPointer(3, GL_FLOAT, 0, arrow_coordinates);
    glDrawArrays(GL_LINE_STRIP, 0, 3);
    glDisableClientState(GL_VERTEX_ARRAY);
}

-(void)drawText:(NSString*)text inPoint:(Point3D)textPoint withFontSize:(int)font_size{
    FTGLBitmapFont* font = new FTGLBitmapFont( "/Library/Fonts/Apple Chancery.ttf" );
    
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
    glRasterPos3f( textPoint.x, textPoint.y, textPoint.z);
    font->Render( [text cStringUsingEncoding:NSUTF8StringEncoding]);
    delete font;
}

@end
