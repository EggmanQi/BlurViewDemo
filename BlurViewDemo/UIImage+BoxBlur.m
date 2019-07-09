//
//  UIImage+BoxBlur.m
//  BlurViewDemo
//
//  Created by eggman qi on 2019/7/9.
//  Copyright © 2019 EBrainStudio. All rights reserved.
//

#import "UIImage+BoxBlur.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage(BoxBlur)

- (UIImage *)boxblurImageWithBlurNumber:(CGFloat)blur{
	if (blur < 0.f || blur > 1.f) {
		blur = 0.5f;
	}
	int boxSize = (int)(blur * 40);
	boxSize = boxSize - (boxSize % 2) + 1;
	
	CGImageRef img = self.CGImage;
	
	vImage_Buffer inBuffer, outBuffer;
	
	void *pixelBuffer;
	
	CGDataProviderRef inProvider = CGImageGetDataProvider(img);
	CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
	
	inBuffer.width = CGImageGetWidth(img);
	inBuffer.height = CGImageGetHeight(img);
	inBuffer.rowBytes = CGImageGetBytesPerRow(img);
	
	inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
	
	pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
						 CGImageGetHeight(img));
	
	if(pixelBuffer == NULL){
		NSLog(@"NO pixel buffer");
	}
	
	outBuffer.data = pixelBuffer;
	outBuffer.width = CGImageGetWidth(img);
	outBuffer.height = CGImageGetHeight(img);
	outBuffer.rowBytes = CGImageGetBytesPerRow(img);
	
	vImage_Error error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
	if (error) {
		NSLog(@"error from convolution %ld", error);
	}
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef ctx = CGBitmapContextCreate(
											 outBuffer.data,
											 outBuffer.width,
											 outBuffer.height,
											 8,
											 outBuffer.rowBytes,
											 colorSpace,
											 kCGImageAlphaNoneSkipLast);
	CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
	UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
	
	//clean up
	CGContextRelease(ctx);
	CGColorSpaceRelease(colorSpace);
	
	free(pixelBuffer);
	CFRelease(inBitmapData);
	
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(imageRef);
	
	return returnImage;
}

@end
