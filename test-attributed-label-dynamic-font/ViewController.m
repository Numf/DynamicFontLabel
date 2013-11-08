//
//  ViewController.m
//  test-attributed-label-dynamic-font
//
//  Created by Paul Malikov on 11/8/13.
//  Copyright (c) 2013 Paul Malikov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (IBAction)onTextChange:(id)sender
{
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:@"I like pictures!"
                                                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:24]}];
    self.label.attributedText = attributedText;
}

@end
