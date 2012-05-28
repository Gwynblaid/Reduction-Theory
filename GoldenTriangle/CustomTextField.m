//
//  CustomTextField.m
//  GoldenTriangle
//
//  Created by Skiv on 28.05.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
    NSString* tempStr = self.stringValue;
    self.stringValue = [NSString stringWithFormat:@"%@: %@",self.placeholderString,self.stringValue];
    [super drawWithFrame:cellFrame inView:controlView];
    self.stringValue = tempStr;
}


@end
