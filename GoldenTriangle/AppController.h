//
//  AppController.h
//  GoldenTriangle
//
//  Created by Skiv on 27.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyOpenGLView;

@interface AppController : NSObject{
    MyOpenGLView* _graphView;
    NSInteger numGraphs;
}

@property (assign) IBOutlet MyOpenGLView* graphView;

-(IBAction) touchBulidGraphButton:(id)sender;

@end
