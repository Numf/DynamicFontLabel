//
//  UIApplication+ContentSize.m
//  test-fonts
//
//  Created by Paul Malikov on 9/26/13.
//  Copyright (c) 2013 Paul Malikov. All rights reserved.
//

#import "UIApplication+ContentSize.h"

@implementation UIApplication (ContentSize)

- (NSInteger)contentSizeDelta
{
    static NSArray *contentSizeCategories;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contentSizeCategories = @[UIContentSizeCategoryExtraSmall,
                                  UIContentSizeCategorySmall,
                                  UIContentSizeCategoryMedium,
                                  UIContentSizeCategoryLarge,
                                  UIContentSizeCategoryExtraLarge,
                                  UIContentSizeCategoryExtraExtraLarge,
                                  UIContentSizeCategoryExtraExtraExtraLarge];
    });
    
    // assume UIContentSizeCategoryLarge is default category
    NSInteger contentSizeDelta = [contentSizeCategories indexOfObject:self.preferredContentSizeCategory];
    contentSizeDelta -= [contentSizeCategories indexOfObject:UIContentSizeCategoryLarge];
    
    return contentSizeDelta;
}

@end
