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
#import "CoefficientsOfPreparing.h"
#import "ProbalisticLow.h"
#import "ProbabilityDistribution.h"

@implementation AppController
@synthesize graphView = _graphView;
@synthesize numGraphsStepperController = _numGraphsStepperController;
@synthesize selectedGraph = _selectedGraph;
@synthesize selectedDistribution2 = _selectedDistribution2;
@synthesize parametr1 = _parametr1;
@synthesize parametr2 = _parametr2;
@synthesize parametr2_1 = _parametr2_1;
@synthesize parametr2_2 = _parametr2_2;
@synthesize writeToFileCheckBox = _writeToFileCheckBox;
@synthesize fileNameTextField = _fileNameTextField;
@synthesize calculationCoeffModule = _calculationCoeffModule;
@synthesize parametrT = _parametrT;
@synthesize parametrX = _parametrX;
@synthesize mainWindow = _mainWindow;
@synthesize graph2View = _graph2View;

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
    _graphView.writeToFile = self.writeToFileCheckBox.state;
    _graphView.fileName = self.fileNameTextField.stringValue;
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
    
    self.parametr2_1.stringValue = @"";
    self.parametr2_2.stringValue = @"";
    switch ([self.selectedDistribution2 indexOfSelectedItem]) {
        case DRAW_GAMMA_GRAPH:{
            [self.parametr2_1.cell setPlaceholderString:@"k"];
            [self.parametr2_2.cell setPlaceholderString:@"θ"];
            break;
        }
        case DRAW_NORMAL_GRAPH:{
            [self.parametr2_1.cell setPlaceholderString:@"m"];
            [self.parametr2_2.cell setPlaceholderString:@"σ"];
            break;
        }
        case DRAW_VEIBUL_GRAPH:{
            [self.parametr2_1.cell setPlaceholderString:@"k"];
            [self.parametr2_2.cell setPlaceholderString:@"λ"];
            break;
        }
        default:
            break;
    }
}

-(IBAction) touchCleanButton:(id)sender{
    [_graphView clearGraphWithXStart:0 xEnd:10.0 yStart:0 yEnd:10];
}

-(IBAction) clickWriteToFileCheckBox:(id)sender{
    [self.fileNameTextField setHidden:!self.writeToFileCheckBox.state];
}

-(IBAction) clickCalculateButton:(id)sender{
    //check for empty
    assert(![self.parametr1.stringValue isEqualToString:@""]);
    assert(![self.parametr2.stringValue isEqualToString:@""]);
    assert(![self.parametr2_1.stringValue isEqualToString:@""]);
    assert(![self.parametr2_2.stringValue isEqualToString:@""]);
    ProbalisticLow* low1 = [ProbalisticLow new];
    ProbalisticLow* low2 = [ProbalisticLow new];
    
    low1.selectorClass = [ProbabilityDistribution class];
    low2.selectorClass = [ProbabilityDistribution class];
    
    switch ([_selectedGraph indexOfSelectedItem]) {
        case DRAW_GAMMA_GRAPH:{
            low1.f_m = @selector(getGammaDensityWithK:eta:andX:);
            low1.F = @selector(getGammaDestributionFunctionWithK:eta:andX:);
            break;
        }
        case DRAW_NORMAL_GRAPH:{
            low1.f_m = @selector(getNormalyzeDensityWithM:sigma:andX:);
            low1.F = @selector(getNormalyzeDestributionFunctionWithM:eta:andX:);
            break;
        }
        case DRAW_VEIBUL_GRAPH:{
            low1.f_m = @selector(getVeibulDensity:lambda:andX:);
            low1.F = @selector(getVeibulDestributionFunctionWithK:lambda:andX:);
            break;
        }
        default:
            break;
    }
    
    low1.parametr1 = [self.parametr1.stringValue doubleValue];
    low1.parametr2 = [self.parametr2.stringValue doubleValue];
    
    switch ([self.selectedDistribution2 indexOfSelectedItem]) {
        case DRAW_GAMMA_GRAPH:{
            low2.f_m = @selector(getGammaDensityWithK:eta:andX:);
            low2.F = @selector(getGammaDestributionFunctionWithK:eta:andX:);
            break;
        }
        case DRAW_NORMAL_GRAPH:{
            low2.f_m = @selector(getNormalyzeDensityWithM:sigma:andX:);
            low2.F = @selector(getNormalyzeDestributionFunctionWithM:eta:andX:);
            break;
        }
        case DRAW_VEIBUL_GRAPH:{
            low2.f_m = @selector(getVeibulDensity:lambda:andX:);
            low2.F = @selector(getVeibulDestributionFunctionWithK:lambda:andX:);
            break;
        }
        default:
            break;
    }
    
    low2.parametr1 = [self.parametr2_1.stringValue doubleValue];
    low2.parametr2 = [self.parametr2_2.stringValue doubleValue];
    
    self.calculationCoeffModule.FLow = low1;
    self.calculationCoeffModule.GLow = low2;
    assert(![self.parametrX.stringValue isEqualToString:@""]);
    assert(![self.parametrT.stringValue isEqualToString:@""]);
    self.calculationCoeffModule.x = [self.parametrX doubleValue];
    //NSLog(@"Result of calculations: %f", [self.calculationCoeffModule calculateStationaryOpperativeAvailabilityFactorWithT:0]);
    //NSLog(@"Result of calculations: %f", [self.calculationCoeffModule calculateStationaryAvailabilityFactorWithT:[self.parametrX.stringValue doubleValue]]);
    [self.graph2View drawGraphForCoefficient:self.calculationCoeffModule andEndingT:[self.parametrT.stringValue doubleValue]];
    
}

-(void)controlTextDidEndEditing:(NSNotification *)obj{
    [self.mainWindow.window makeFirstResponder:self.mainWindow];
}


@end
