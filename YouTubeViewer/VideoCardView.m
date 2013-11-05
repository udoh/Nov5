//
//  VideoCardView.m
//  YouTubeViewer
//
//  Created by Udo Hoppenworth on 11/4/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "VideoCardView.h"

#define SIDE_BORDER 20
#define TOP_BORDER 20
#define TITLE_LABLE_HEIGHT 30
#define STANDARD_LABEL_HEIGHT 21

@interface VideoCardView()
@property (strong, nonatomic) NSURL *contentURL;
@end

@implementation VideoCardView

- (instancetype)initWithTitle:(NSString *)title
                       author:(NSString *)author
               thumbnailImage:(UIImage *)thumbnailImage
                    viewCount:(long long int)viewCount
                  description:(NSString *)description
                   contentURL:(NSURL *)contentURL
                        frame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if (self) {
        CGRect bounds = self.bounds;
        
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        self.contentURL = contentURL;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_BORDER, TOP_BORDER, bounds.size.width - 2 * SIDE_BORDER, TITLE_LABLE_HEIGHT)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.numberOfLines = 2;
        titleLabel.minimumScaleFactor = 0.7;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.text = title;
        [self addSubview:titleLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SIDE_BORDER, 58, bounds.size.width - 2 * SIDE_BORDER, 190)];
        imageView.image = thumbnailImage;
        [self addSubview:imageView];
        
        UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_BORDER, 256, bounds.size.width - 2 * SIDE_BORDER, STANDARD_LABEL_HEIGHT)];
        authorLabel.font = [UIFont systemFontOfSize:17];
        authorLabel.numberOfLines = 1;
        authorLabel.minimumScaleFactor = 0.7;
        authorLabel.adjustsFontSizeToFitWidth = YES;
        authorLabel.text = author;
        [self addSubview:authorLabel];
        
        UILabel *viewCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIDE_BORDER, 285, bounds.size.width - 2 * SIDE_BORDER, STANDARD_LABEL_HEIGHT)];
        viewCountLabel.font = [UIFont systemFontOfSize:12];
        
        viewCountLabel.text = [@"Views: " stringByAppendingString:[NSNumberFormatter localizedStringFromNumber:@(viewCount) numberStyle:NSNumberFormatterDecimalStyle]];
        [self addSubview:viewCountLabel];
        
        UITextView *descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(SIDE_BORDER, 314, bounds.size.width - 2 * SIDE_BORDER, bounds.size.height - 314 - 58)];
        descriptionTextView.font = [UIFont systemFontOfSize:10];
        descriptionTextView.editable = NO;
        descriptionTextView.text = description;
        [self addSubview:descriptionTextView];
        
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        playButton.frame = CGRectMake(124, bounds.size.height - 50, 73, 30);
        [playButton setTitle:@"Play Video" forState:UIControlStateNormal];
        [self addSubview:playButton];
        
        [playButton addTarget:self action:@selector(playVideoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)playVideoButtonPressed:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:self.contentURL];
}

@end
