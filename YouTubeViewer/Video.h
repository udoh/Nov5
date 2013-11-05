//
//  VideoItem.h
//  YouTubeViewer
//
//  Created by Udo Hoppenworth on 11/4/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoCardView.h"

@interface Video : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (nonatomic) long long viewCount;
@property (strong, nonatomic) NSString *descriptionText;
@property (strong, nonatomic) NSURL *contentURL;
@property (strong, nonatomic) NSURL *thumbnailURL;
@property (strong, nonatomic) NSURL *linkURL;
@property (strong, nonatomic) UIImage *thumbnailImage;

@end
