//
//  DFLabel.m
//  test-attributed-label-dynamic-font
//
//  Created by Paul Malikov on 11/8/13.
//  Copyright (c) 2013 Paul Malikov. All rights reserved.
//

#import "DFLabel.h"
#import "UIApplication+ContentSize.h"

@interface DFLabel ()
{
    NSDictionary *_fontDescriptors;
}

@end

@implementation DFLabel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(contentSizeCategoryDidChange)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
    
    [self updateFontDescriptors];
    [self contentSizeCategoryDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self updateFontDescriptors];
    [self contentSizeCategoryDidChange];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self updateFontDescriptors];
    [self contentSizeCategoryDidChange];
}

- (void)updateFontDescriptors
{
    NSMutableDictionary *fontDescriptors = [NSMutableDictionary dictionary];
    
    [self.attributedText
     enumerateAttribute:NSFontAttributeName
     inRange:NSMakeRange(0, self.attributedText.length)
     options:0
     usingBlock:^(UIFont *font, NSRange range, BOOL *stop) {
         fontDescriptors[NSStringFromRange(range)] = font.fontDescriptor;
     }];
    
    _fontDescriptors = fontDescriptors;
}

- (void)contentSizeCategoryDidChange
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    for (NSString *rangeString in _fontDescriptors.allKeys) {
        UIFontDescriptor *fontDescriptor = _fontDescriptors[rangeString];
        CGFloat preferredSize = [fontDescriptor.fontAttributes[UIFontDescriptorSizeAttribute] floatValue];
        preferredSize += [UIApplication sharedApplication].contentSizeDelta;
        
        [attributedText addAttribute:NSFontAttributeName value:[UIFont fontWithDescriptor:fontDescriptor size:preferredSize] range:NSRangeFromString(rangeString)];
    }
    
    [super setAttributedText:attributedText];
    [self invalidateIntrinsicContentSize];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}
@end
