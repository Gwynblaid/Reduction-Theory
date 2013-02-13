//
//  CheckNumberFormatter.m
//  GoldenTriangle
//
//  Created by Skiv on 04.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckNumberFormatter.h"

@implementation CheckNumberFormatter

static NSString * digString = @"0123456789.";

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
    }
    
    return self;
}

-(BOOL)isPartialStringValid:(NSString **)partialStringPtr
      proposedSelectedRange:(NSRangePointer)proposedSelRangePtr
             originalString:(NSString *)origString 
      originalSelectedRange:(NSRange)origSelRange
           errorDescription:(NSString **)error
{
    NSCharacterSet *nonDigits;
    NSRange newStuff;
    NSString *newStuffString;
    
    nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    newStuff = NSMakeRange(origSelRange.location,
                           proposedSelRangePtr->location
                           - origSelRange.location);
    newStuffString = [*partialStringPtr substringWithRange: newStuff];
    NSString* checkString = [NSString stringWithFormat:@"%@%@",origString,newStuffString];
    unsigned long countDoth = [[checkString componentsSeparatedByString:@"."] count] - 1;
    if ((([digString rangeOfString:newStuffString].location!=NSNotFound)&&(countDoth<2)&&(![checkString isEqualToString:@"."])&&(![checkString isEqualToString:@"00"]))|| ([newStuffString isEqualToString:@""])) {
        *error = nil;
        return (YES);
    } else {
        *error = @"Input is not an integer";
        return (NO);
    }
}

@end
