//
//  CircleDownloadView.m
//
//  Created by Zabolotnyy S. on 17.11.15.
//

#import "CircleDownloadView.h"

@interface CircleDownloadView ()

@property (nonatomic, strong) CAShapeLayer *circlePathLayer;
@property (nonatomic, strong) CABasicAnimation *rotationAnimation;

@end

@implementation CircleDownloadView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self config];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self config];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.circlePathLayer setFrame:self.bounds];
   
    CGFloat radius = MIN(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
    CGRect circleFrame = CGRectMake(0, 0, radius, radius);
    self.circlePathLayer.path = [UIBezierPath bezierPathWithRoundedRect:circleFrame cornerRadius:radius].CGPath;
}

- (void)config
{
    self.circlePathLayer = [CAShapeLayer layer];
    [self.circlePathLayer setFrame:self.bounds];
    self.circlePathLayer.lineWidth = 2;
    self.circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    self.circlePathLayer.strokeColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:self.circlePathLayer];
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.rotationAnimation.toValue = @(M_PI);
    self.rotationAnimation.duration = .5;
    self.rotationAnimation.cumulative = YES;
    self.rotationAnimation.repeatCount = UINT16_MAX;
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    self.circlePathLayer.strokeColor = strokeColor.CGColor;
}

- (void)setProgress:(CGFloat)progress
{
    CGFloat newProgress = MIN(MAX(0, progress), 1);
    _progress = newProgress;
    self.circlePathLayer.strokeEnd = _progress;
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    
    if (hidden)
    {
        [self.layer removeAnimationForKey:@"rotationAnimation"];
    }
    else
    {
        [self.layer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
    }
}

@end
