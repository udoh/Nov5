//
//  ViewController.m
//  YouTubeViewer
//
//  Created by Udo Hoppenworth on 11/4/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"
#import "VideoCardView.h"

#define kRequestURL @"http://gdata.youtube.com/feeds/api/standardfeeds/most_popular?v=2&alt=json"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *videos;
@end

@implementation ViewController

- (NSMutableArray *)videos
{
    if (!_videos) {
        _videos = [[NSMutableArray alloc] init];
    }
    return _videos;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadVideos];
}

- (void)loadVideos
{
    NSURL *youTubeURL = [NSURL URLWithString:kRequestURL];
    CGRect bounds = self.view.bounds;
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("YouTube download queue", NULL);
    
    [self.spinner startAnimating];
    self.loadingLabel.hidden = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
    dispatch_async(downloadQueue, ^{
        NSData *youTubeData = [NSData dataWithContentsOfURL:youTubeURL];        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:youTubeData options:kNilOptions error:&error];
            if (!error) {
                // parse JSON
                NSDictionary *feed = json[@"feed"];
                NSArray *entries = [[NSArray alloc] initWithArray:feed[@"entry"]];
                
                // Create video object for each entry found in JSON data
                for (NSDictionary *entry in entries) {
                    Video *video = [[Video alloc] init];
                    video.title = entry[@"title"][@"$t"];
                    video.author = [entry[@"author"] firstObject][@"name"][@"$t"];
                    // sub 2 is HQ thumbnail
                    video.thumbnailURL = [NSURL URLWithString:entry[@"media$group"][@"media$thumbnail"][2][@"url"]];
                    video.contentURL = [NSURL URLWithString:entry[@"media$group"][@"media$content"][0][@"url"]];
                    video.linkURL = [NSURL URLWithString:[entry[@"link"] firstObject][@"href"]];
                    video.viewCount = [entry[@"yt$statistics"][@"viewCount"] intValue];
                    video.descriptionText = entry[@"media$group"][@"media$description"][@"$t"];
                    video.thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:video.thumbnailURL]];
                    [self.videos addObject:video];
                }
            } else {
                // report error
                NSLog(@"Error loading URL!");
            }
            
            // Create a videoCardView for each video in array and add to scrollView
            for (int i = 0; i < [self.videos count]; i++) {
                
                Video *video = self.videos[i];
                VideoCardView *videoCard = [[VideoCardView alloc] initWithTitle:video.title author:video.author thumbnailImage:video.thumbnailImage viewCount:video.viewCount description:video.descriptionText contentURL:video.linkURL frame:CGRectMake((i * bounds.size.width), 0, bounds.size.width, bounds.size.height)];
                [self.scrollView addSubview:videoCard];
            }
            
            [self.spinner stopAnimating];
            self.loadingLabel.hidden = YES;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            // Set contentSize of scrollView
            self.scrollView.contentSize = CGSizeMake(([self.videos count] * bounds.size.width), bounds.size.height);
        });
    });
}


@end
