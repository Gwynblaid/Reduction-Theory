//
//  Plot3D.m
//  GoldenTriangle
//
//  Created by Sergey Harchenko on 6/15/13.
//
//

#import "Plot3D.h"

@implementation Plot3D

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
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, dirtyRect.size.width, dirtyRect.size.height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glFrustum(-1, 1, -1, 1, 1, 2);
    glMatrixMode(GL_MODELVIEW);
    //glPushMatrix();
    //glRotatef(-90, 1, 0, 0);
    //glRotatef(45, 0, 0, 1);
    //glTranslatef(-0.3, -0.3, -0.3);
    //glScalef(1.29, 1.29, 1.29);
    glColor3f(0, 1, 0);//x - green
    glBegin(GL_TRIANGLES);
    glVertex3f (-1, -1, 0);
    glVertex3f (-1, 1, 0) ;
    glVertex3f (1, 0, 0.5);
    glEnd();
    /*glBegin(GL_TRIANGLES);
    glVertex3f(0, 0, 0);
    glVertex3f(1, 0, 0);
    glVertex3f(1, 0, 1);
    glEnd();*/
    glFlush();
    //glPopMatrix();

    //glPopMatrix();
}

@end
