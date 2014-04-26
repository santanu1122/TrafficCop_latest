//
//  HMSegmentedControl.m
//  HMSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "SegmentedControl.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>

@interface ScrollView : UIScrollView
@end

typedef enum {
    SegmentedControlTypeText,
    SegmentedControlTypeImages
} SegmentedControlType;

@interface SegmentedControl ()

@property (nonatomic, assign) SegmentedControlType type;
@property (nonatomic, strong) CALayer *selectionIndicatorStripLayer;
@property (nonatomic, strong) CALayer *selectionIndicatorBoxLayer;
@property (nonatomic, readwrite) CGFloat segmentWidth;
@property (nonatomic, strong) ScrollView *scrollView;

@end

@implementation ScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.dragging) {
        [self.nextResponder touchesMoved:touches withEvent:event];
    } else{
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

@end

@implementation SegmentedControl

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithSectionTitles:(NSArray *)sectiontitles {
    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        [self commonInit];
        self.sectionTitles = sectiontitles;
        self.type = SegmentedControlTypeText;
    }
    
    return self;
}

- (id)initWithSectionImages:(NSArray*)sectionImages sectionSelectedImages:(NSArray*)sectionSelectedImages {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        [self commonInit];
        self.sectionImages = sectionImages;
        self.sectionSelectedImages = sectionSelectedImages;
        self.type = SegmentedControlTypeImages;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (void)commonInit {
    
    self.scrollView = [[ScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.font = [UIFont fontWithName:GLOBALTEXTFONT size:13.0f];
    self.textColor = UIColorFromRGB(0x666666);
    self.selectedTextColor = [UIColor blackColor];
    self.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.opaque = NO;
    self.selectedSegmentIndex = 0;
    self.selectionIndicatorColor = UIColorFromRGB(0xde1d23);
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.selectionIndicatorHeight = 2.0f;
    self.selectionStyle = SegmentedControlSelectionStyleTextWidthStripe;
    self.selectionIndicatorLocation = SegmentedControlSelectionIndicatorLocationUp;
    self.type = SegmentedControlTypeText;
    self.selectionIndicatorStripLayer = [CALayer layer];
    self.selectionIndicatorBoxLayer = [CALayer layer];
    self.selectionIndicatorBoxLayer.opacity = 0.2;
    self.selectionIndicatorBoxLayer.borderWidth = 1.0f;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.type == SegmentedControlTypeText && self.sectionTitles) {
        [self updateSegmentsRects];
    } else if(self.type == SegmentedControlTypeImages && self.sectionImages) {
        [self updateSegmentsRects];
    }
    
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {    
    [self.backgroundColor setFill];
    UIRectFill([self bounds]);

    self.selectionIndicatorStripLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
    self.selectionIndicatorBoxLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
    self.selectionIndicatorBoxLayer.borderColor = self.selectionIndicatorColor.CGColor;
    
    self.layer.zPosition = 999999999;
    self.layer.shadowColor = UIColorFromRGB(0xd1d1d1).CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0, 0.5);
    self.layer.shadowOpacity = 0.9;
    
    // Remove all sublayers to avoid drawing images over existing ones
    self.scrollView.layer.sublayers = nil;
    
    if (self.type == SegmentedControlTypeText) {
        [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
            CGFloat stringHeight = roundf([titleString sizeWithFont:self.font].height);
            // Text inside the CATextLayer will appear blurry unless the rect values are rounded
            CGFloat y = roundf(((CGRectGetHeight(self.frame) - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - stringHeight / 2));
            CGRect rect = CGRectMake(self.segmentWidth * idx, y, self.segmentWidth, stringHeight+20);
            CATextLayer *titleLayer = [CATextLayer layer];
            titleLayer.frame = rect;
            titleLayer.font = (__bridge CFTypeRef)(self.font.fontName);
            titleLayer.fontSize = self.font.pointSize;
            titleLayer.alignmentMode = kCAAlignmentCenter;
            titleLayer.string = titleString;
            titleLayer.truncationMode = kCATruncationEnd;
            
            if (self.selectedSegmentIndex == idx) {
                titleLayer.foregroundColor = self.selectedTextColor.CGColor;
            } else {
                titleLayer.foregroundColor = self.textColor.CGColor;
            }
            
            titleLayer.contentsScale = [[UIScreen mainScreen] scale];
            [self.scrollView.layer addSublayer:titleLayer];
        }];
    } else if (self.type == SegmentedControlTypeImages) {
        [self.sectionImages enumerateObjectsUsingBlock:^(id iconImage, NSUInteger idx, BOOL *stop) {
            UIImage *icon = iconImage;
            CGFloat imageWidth = icon.size.width;
            CGFloat imageHeight = icon.size.height;
            CGFloat y = ((CGRectGetHeight(self.frame) - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - imageHeight / 2);
            CGFloat x = self.segmentWidth * idx + (self.segmentWidth - imageWidth)/2.0f;
            CGRect rect = CGRectMake(x, y, imageWidth, imageHeight);
            
            CALayer *imageLayer = [CALayer layer];
            imageLayer.frame = rect;
            
            switch (self.selectedSegmentIndex) {
                case 0:
                    self.selectionIndicatorColor = UIColorFromRGB(0xde1d23);
                    break;
                case 1:
                    self.selectionIndicatorColor = UIColorFromRGB(0x1aad4b);
                    break;
                case 2:
                    self.selectionIndicatorColor = UIColorFromRGB(0xfcb714);
                    break;
                case 3:
                    self.selectionIndicatorColor = UIColorFromRGB(0xde1d23);
                    break;
                case 4:
                    self.selectionIndicatorColor = UIColorFromRGB(0xfcb714);
                    break;
                default:
                    break;
            }
                
            if (self.selectedSegmentIndex == idx) {
                if (self.sectionSelectedImages) {
                    UIImage *highlightIcon = [self.sectionSelectedImages objectAtIndex:idx];
                    imageLayer.contents = (id)highlightIcon.CGImage;
                } else {
                    imageLayer.contents = (id)icon.CGImage;
                }
            } else {
                imageLayer.contents = (id)icon.CGImage;
            }
            
            [self.scrollView.layer addSublayer:imageLayer];
        }];
    }
    
    // Add the selection indicators
    if (self.selectedSegmentIndex != SegmentedControlNoSegment && !self.selectionIndicatorStripLayer.superlayer) {
        self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
        [self.scrollView.layer addSublayer:self.selectionIndicatorStripLayer];
        
        if (self.selectionStyle == SegmentedControlSelectionStyleBox && !self.selectionIndicatorBoxLayer.superlayer) {
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            [self.scrollView.layer insertSublayer:self.selectionIndicatorBoxLayer atIndex:0];
        }
    }
}

- (CGRect)frameForSelectionIndicator {
    
    CGFloat indicatorYOffset = 0.0f;
        
    if (self.selectionIndicatorLocation == SegmentedControlSelectionIndicatorLocationDown)
        indicatorYOffset = self.bounds.size.height - self.selectionIndicatorHeight;
    
    CGFloat sectionWidth = 0.0f;

    if (self.type == SegmentedControlTypeText) {
        CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedSegmentIndex] sizeWithFont:self.font].width;
        sectionWidth = stringWidth;
    } else if (self.type == SegmentedControlTypeImages) {
        UIImage *sectionImage = [self.sectionImages objectAtIndex:self.selectedSegmentIndex];
        CGFloat imageWidth = sectionImage.size.width;
        sectionWidth = imageWidth;
    }
    
    if (self.selectionStyle == SegmentedControlSelectionStyleTextWidthStripe && sectionWidth <= self.segmentWidth) {
        CGFloat widthToEndOfSelectedSegment = (self.segmentWidth * self.selectedSegmentIndex) + self.segmentWidth;
        CGFloat widthToStartOfSelectedIndex = (self.segmentWidth * self.selectedSegmentIndex);
        
        CGFloat x = ((widthToEndOfSelectedSegment - widthToStartOfSelectedIndex) / 2) + (widthToStartOfSelectedIndex - sectionWidth / 2);
        return CGRectMake(x, indicatorYOffset, sectionWidth, self.selectionIndicatorHeight);
    } else {
        return CGRectMake(self.segmentWidth * self.selectedSegmentIndex, indicatorYOffset, self.segmentWidth, self.selectionIndicatorHeight);
    }
}

- (CGRect)frameForFillerSelectionIndicator {
    return CGRectMake(self.segmentWidth * self.selectedSegmentIndex, 0, self.segmentWidth, CGRectGetHeight(self.frame));
}

- (void)updateSegmentsRects {
    
    self.scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));

    // When `scrollEnabled` is set to YES, segment width will be automatically set to the width of the biggest segment's text or image,
    // otherwise it will be equal to the width of the control's frame divided by the number of segments.
    if (self.type == SegmentedControlTypeText) {
        self.segmentWidth = floorf(self.frame.size.width / self.sectionTitles.count);
    } else if (self.type == SegmentedControlTypeImages) {
        self.segmentWidth = floorf(self.frame.size.width / self.sectionImages.count);
    }
    
    if (self.isScrollEnabled) {
        if (self.type == SegmentedControlTypeText) {
            for (NSString *titleString in self.sectionTitles) {
#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
                CGFloat stringWidth = [titleString sizeWithAttributes:@{NSFontAttributeName: self.font}].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
#else
                CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
#endif
                self.segmentWidth = MAX(stringWidth, self.segmentWidth);
            }
        } else if (self.type == SegmentedControlTypeImages) {
            for (UIImage *sectionImage in self.sectionImages) {
                CGFloat imageWidth = sectionImage.size.width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
                self.segmentWidth = MAX(imageWidth, self.segmentWidth);
            }
        }
    }
    
    if ([self segmentedControlNeedsScrolling]) {
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake([self totalSegmentedControlWidth], self.frame.size.height);
    } else {
		self.scrollView.scrollEnabled = NO;
        self.scrollView.contentSize = self.frame.size;
	}
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    [self updateSegmentsRects];
}

#pragma mark - Touch

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = (touchLocation.x + self.scrollView.contentOffset.x) / self.segmentWidth;
        
        if (segment != self.selectedSegmentIndex) {
            [self setSelectedSegmentIndex:segment animated:YES notify:YES];
        }
    }
}

#pragma mark - Scrolling

- (BOOL)segmentedControlNeedsScrolling {
    if ([self totalSegmentedControlWidth] > self.frame.size.width && self.isScrollEnabled) {
        return YES;
    }
    return NO;
}

- (CGFloat)totalSegmentedControlWidth {
    if (self.type == SegmentedControlTypeText) {
        return self.sectionTitles.count * self.segmentWidth;
    } else {
        return self.sectionImages.count * self.segmentWidth;
    }
}

- (void)scrollToSelectedSegmentIndex {
    CGRect rectForSelectedIndex = CGRectMake(self.segmentWidth * self.selectedSegmentIndex,
                                             0,
                                             self.segmentWidth,
                                             self.frame.size.height);
    
    CGFloat selectedSegmentOffset = (CGRectGetWidth(self.frame) / 2) - (self.segmentWidth / 2);
    CGRect rectToScrollTo = rectForSelectedIndex;
    rectToScrollTo.origin.x -= selectedSegmentOffset;
    rectToScrollTo.size.width += selectedSegmentOffset * 2;
    [self.scrollView scrollRectToVisible:rectToScrollTo animated:YES];
}

#pragma mark - Index change

- (void)setSelectedSegmentIndex:(NSInteger)index {
    [self setSelectedSegmentIndex:index animated:NO notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    [self setSelectedSegmentIndex:index animated:animated notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated notify:(BOOL)notify {
    _selectedSegmentIndex = index;
    [self setNeedsDisplay];
    
    if (index == SegmentedControlNoSegment) {
        [self.selectionIndicatorStripLayer removeFromSuperlayer];
        [self.selectionIndicatorBoxLayer removeFromSuperlayer];
    } else {
        [self scrollToSelectedSegmentIndex];
        
        if (animated) {
            // If the selected segment layer is not added to the super layer, that means no
            // index is currently selected, so add the layer then move it to the new
            // segment index without animating.
            if ([self.selectionIndicatorStripLayer superlayer] == nil) {
                [self.scrollView.layer addSublayer:self.selectionIndicatorStripLayer];
                
                if (self.selectionStyle == SegmentedControlSelectionStyleBox && [self.selectionIndicatorBoxLayer superlayer] == nil)
                    [self.scrollView.layer insertSublayer:self.selectionIndicatorBoxLayer atIndex:0];
                
                [self setSelectedSegmentIndex:index animated:NO notify:YES];
                return;
            }
            
            if (notify)
                [self notifyForSegmentChangeToIndex:index];
            
            // Restore CALayer animations
            self.selectionIndicatorStripLayer.actions = nil;
            self.selectionIndicatorBoxLayer.actions = nil;
            
            // Animate to new position
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.15f];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            [CATransaction commit];
        } else {
            // Disable CALayer animations
            NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
            self.selectionIndicatorStripLayer.actions = newActions;
            self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
            
            self.selectionIndicatorBoxLayer.actions = newActions;
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            
            if (notify)
                [self notifyForSegmentChangeToIndex:index];
        }
    }
}

- (void)notifyForSegmentChangeToIndex:(NSInteger)index {
    if (self.superview)
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    if (self.indexChangeBlock)
        self.indexChangeBlock(index);
}

@end
