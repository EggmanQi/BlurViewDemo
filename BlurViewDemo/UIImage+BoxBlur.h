//
//  UIImage+BoxBlur.h
//  BlurViewDemo
//
//  Created by eggman qi on 2019/7/9.
//  Copyright © 2019 EBrainStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage(BoxBlur)

- (UIImage *)boxblurImageWithBlurNumber:(CGFloat)blur; 

@end

NS_ASSUME_NONNULL_END
