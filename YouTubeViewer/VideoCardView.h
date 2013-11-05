//
//  VideoCardView.h
//  YouTubeViewer
//
//  Created by Udo Hoppenworth on 11/4/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCardView : UIView

- (instancetype)initWithTitle:(NSString *)title
                       author:(NSString *)author
               thumbnailImage:(UIImage *)thumbnailImage
                    viewCount:(long long int)viewCount
                  description:(NSString *)description
                   contentURL:(NSURL *)contentURL
                        frame:(CGRect)frame;

@end
