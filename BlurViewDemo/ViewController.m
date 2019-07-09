//
//  ViewController.m
//  BlurViewDemo
//
//  Created by eggman qi on 2019/7/9.
//  Copyright © 2019 EBrainStudio. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+StackBlur.h"
#import "UIImage+BoxBlur.h"

typedef enum : NSUInteger {
	BlurType_BOX,
	BlurType_STACK,
} BlurType;

@interface ViewController ()
@property (nonatomic, assign) BlurType type;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_type = BlurType_STACK; 
	
//	[UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionRepeat animations:^{
//		CGAffineTransform transform = CGAffineTransformScale(self.img_blur.transform, 5, 5);
//		[self.img_blur setTransform:transform];
//	} completion:^(BOOL finished) {
//		CGAffineTransform transform = CGAffineTransformInvert(CGAffineTransformMakeScale(1, 1));
//		[self.img_blur setTransform:transform];
//	}];
	
}

- (IBAction)didSlide:(UISlider *)sender {
	NSLog(@"%f", sender.value);
	UIImage *source = self.img.image;
	switch (_type) {
		case BlurType_BOX:
				self.img_blur.image = [source boxblurImageWithBlurNumber:sender.value];
			break;
		case  BlurType_STACK:
		default:
			self.img_blur.image = [source stackBlur:sender.value];
			break;
	}
}

- (IBAction)didChangBlueType:(UIButton *)sender {
	
	self.img_blur.image = self.img.image;
	
	_slider.value = 0;
	
	if ([sender.currentTitle isEqualToString:@"BOX"]) {
		[sender setTitle:@"STACK" forState:UIControlStateNormal];
		_slider.maximumValue = 20;
		_type = BlurType_STACK;
	}else {
		[sender setTitle:@"BOX" forState:UIControlStateNormal];
		_slider.maximumValue = 1.0;
		_type = BlurType_BOX;
	}
}


@end
