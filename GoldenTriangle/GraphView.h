//
//  GraphView.h
//  GoldenTriangle
//
//  Created by Sergey Harchenko on 5/20/13.
//
//

#import <Cocoa/Cocoa.h>

typedef struct{
    CGFloat x;
    CGFloat y;
    CGFloat z;
}Point3D;

Point3D Point3DMake(CGFloat x, CGFloat y, CGFloat z);

struct MyGLColor{
    double red;
    double green;
    double blue;
    double alplha;
};

@interface GraphView : NSOpenGLView

@property(nonatomic, strong) NSString* xLabel;
@property(nonatomic, strong) NSString* yLabel;
@property(nonatomic, strong) NSString* zLabel;


-(void)drawGraphWithX:(NSArray *)xArray andY:(NSArray *)yArray;
-(void)drawGraphWithX:(NSArray *)xArray Y:(NSArray *)yArray andZ:(NSArray *)zArray;

@end
