//
//  AppController.h
//  GoldenTriangle
//
//  Created by Skiv on 27.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomTextField.h"

@class MyOpenGLView;
@class StepperController;
@class CoefficientsOfPreparing;
typedef NS_ENUM(NSUInteger, ComboBoxDestribution) {
    CBNormalizeDestribution = 0,
    CBVeibulGnedenkoDestribution,
};

@interface AppController : NSObject<NSComboBoxDelegate, NSTextFieldDelegate>{
    NSTextField *fileResultTextField;
}

@property (retain) IBOutlet NSView* mainWindow;

@property (retain) IBOutlet StepperController* numGraphsStepperController;

@property (assign) IBOutlet NSComboBox *FComboBox;
@property (assign) IBOutlet NSComboBox *GComboBox;
@property (assign) IBOutlet NSTextField *FXTextField;
@property (assign) IBOutlet NSTextField *FYTextField;
@property (assign) IBOutlet NSTextField *GXTextField;
@property (assign) IBOutlet NSTextField *GYTextField;
- (IBAction)calculateAction:(id)sender;
@property (assign) IBOutlet NSTextField *fileResultTextField;

@property (retain) IBOutlet CoefficientsOfPreparing* calculationCoeffModule;



@end
