//
//  AppController.m
//  GoldenTriangle
//
//  Created by Skiv on 27.11.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "MyOpenGLView.h"
#import "StepperController.h"

@implementation AppController
@synthesize graphView = _graphView;
@synthesize numGraphsStepperController = _numGraphsStepperController;
@synthesize selectedGraph = _selectedGraph;
@synthesize parametr1 = _parametr1;
@synthesize parametr2 = _parametr2;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib{
    [_selectedGraph selectItemAtIndex:0];
}

-(IBAction) touchBulidGraphButton:(id)sender{
    [_graphView drawGrawWithGraphType:[_selectedGraph indexOfSelectedItem] andGraphCount:_numGraphsStepperController.stepperValue withParameter1:[self.parametr1.stringValue floatValue] andParametr2:[self.parametr2.stringValue floatValue]];
}

-(void)comboBoxSelectionDidChange:(NSNotification *)notification{
    self.parametr1.stringValue = @"";
    self.parametr2.stringValue = @"";
    switch ([_selectedGraph indexOfSelectedItem]) {
        case DRAW_GAMMA_GRAPH:{
            [self.parametr1.cell setPlaceholderString:@"k"];
            [self.parametr2.cell setPlaceholderString:@"θ"];
            break;
        }
        case DRAW_NORMAL_GRAPH:{
            [self.parametr1.cell setPlaceholderString:@"m"];
            [self.parametr2.cell setPlaceholderString:@"σ"];
            break;
        }
        case DRAW_VEIBUL_GRAPH:{
            [self.parametr1.cell setPlaceholderString:@"k"];
            [self.parametr2.cell setPlaceholderString:@"λ"];
            break;
        }
        default:
            break;
    }
}

-(IBAction) touchCleanButton:(id)sender{
    [_graphView clearGraphWithXStart:0 xEnd:100.0 yStart:0 yEnd:10];
}

@end
