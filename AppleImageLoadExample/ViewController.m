//
//  ViewController.m
//  AppleImageLoadExample
//
//  Created by Q on 2018/8/1.
//  Copyright © 2018年 Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize targetSize = CGSizeMake(300, 600);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 300, 600)];
    imageView.backgroundColor = [UIColor yellowColor];
    NSURL *imagePath = [[NSBundle mainBundle] URLForResource:@"001" withExtension:@"JPG"];
    [self.view addSubview:imageView];
    imageView.image = [self loadSample:imagePath size:targetSize scale:1];
    
}

- (UIImage *)loadSample:(NSURL *)filePathUrl size:(CGSize)pointSize scale:(NSInteger)scale {
     pointSize = !CGSizeEqualToSize(CGSizeZero, pointSize) ? pointSize : CGSizeMake(200, 100);
    scale = scale > 1 ? scale : 1;
    NSMutableDictionary *sourceOpt = [[NSMutableDictionary alloc] initWithCapacity:1];
    sourceOpt[(id)kCGImageSourceShouldCache] = @(false);
    
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)filePathUrl, (__bridge CFDictionaryRef)sourceOpt);
    CGFloat maxDimension = MAX(pointSize.width, pointSize.height) * scale;
    NSMutableDictionary *downsampleOpt = [[NSMutableDictionary alloc] initWithCapacity:4];
    downsampleOpt[(id)kCGImageSourceCreateThumbnailFromImageAlways] = @(true);
    downsampleOpt[(id)kCGImageSourceShouldCacheImmediately] = @(true);
    downsampleOpt[(id)kCGImageSourceCreateThumbnailWithTransform] = @(true);
    downsampleOpt[(id)kCGImageSourceThumbnailMaxPixelSize] = @(maxDimension);
    CGImageRef downsampleImage = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef)downsampleOpt);
    UIImage *targetImage = [UIImage imageWithCGImage:downsampleImage];
    return targetImage;
}



@end
