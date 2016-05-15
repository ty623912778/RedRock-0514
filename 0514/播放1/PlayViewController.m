//
//  PlayViewController.m
//  TYPlayer
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "musicModel.h"
#import "UIImage+ImageEffects.h"
#import "RotatingView.h"



@interface PlayViewController ()<NSURLSessionDelegate>
{
    AVPlayer *avPlayer;
}

@property (nonatomic, strong) AVAudioPlayer *voicePlayer;
@property (strong, nonatomic)UIProgressView *progressView;



@property (weak, nonatomic) IBOutlet UIImageView *songBigpic;
@property (weak, nonatomic) IBOutlet UILabel *singer;
@property (weak, nonatomic) IBOutlet UILabel *song;
@property (weak, nonatomic) IBOutlet UISlider *soundSlide;
@property (weak, nonatomic) IBOutlet UIButton *previousSong;
@property (weak, nonatomic) IBOutlet UIButton *playSong;
@property (weak, nonatomic) IBOutlet UIButton *nextSong;

@property (nonatomic, strong)NSString* mp3url;

@property (weak, nonatomic) IBOutlet UIButton *modeButton;

@end

@implementation PlayViewController
@synthesize arrayData;

static PlayViewController *s_defaultManager = nil;

+ (PlayViewController *)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        s_defaultManager = [storyBoard instantiateViewControllerWithIdentifier:@"PlayViewController"];
    });
    return s_defaultManager;
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [avPlayer play];
}

- (void)initAllshould
{
    
    [self initWithProgressView];
}
- (IBAction)clickPlayerMode {
    
        if ([self.modeButton.titleLabel.text isEqualToString:@"顺序播放"]) {
            [self.modeButton setTitle:@"随机播放" forState:UIControlStateNormal];
            self.modeButton.titleLabel.text = @"随机播放";
    
        }else if ([self.modeButton.titleLabel.text isEqualToString:@"随机播放"]){
            [self.modeButton setTitle:@"单曲循环" forState:UIControlStateNormal];
            self.modeButton.titleLabel.text = @"单曲循环";
    
        }else{
            [self.modeButton setTitle:@"顺序播放" forState:UIControlStateNormal];
            self.modeButton.titleLabel.text = @"顺序播放";
            
        }
    
}
- (IBAction)collectButton:(id)sender {
    NSLog(@"收藏成功");
}


- (void)initWithProgressView
{
    if (!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(70, 501, 235, 31);
        _progressView.progressTintColor = [UIColor blueColor];
        [self.view addSubview:_progressView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllshould];
    
    
    
    
    self.song.text = _listDictionary[@"songname"];
    self.singer.text = _listDictionary[@"singername"];
    self.songBigpic.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_listDictionary[@"albumpic_big"]]]];
    
    avPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://ws.stream.qqmusic.qq.com/106237460.m4a?fromtag=46"]];
    
    
    
}

- (IBAction)privious:(id)sender {
    
}
- (IBAction)play:(id)sender {
    NSURL *url =  [[NSURL alloc]initWithString:@"http://up.haoduoge.com/mp3/2016-05-06/1462524045.mp3"];
    
    //创建一个默认的会话配置方式
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //创建一个会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:100];
    //下载任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    
    //任务开始
    [task resume];
    
    
    
    //downloadmusic
    
//    musicModel *m = [musicModel musicWithName:self.song Photo:self.songBigpic Mp3Url:self.mp3url Singer:self.singer];
//    
//    if (_block) {
//        _block(m);
//    }
    
    _playSong.selected = ! _playSong.selected;
//    [self.audio play];
//    if (_playSong.selected) {
//       [_voicePlayer play];
//        
//    }else
//    {
//       [_voicePlayer pause];
//        
//    }
//

}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    _voicePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:location error:nil];
    [_voicePlayer  setVolume:1];
    _voicePlayer.numberOfLoops = -1;
    [_voicePlayer play];
    NSLog(@"下载完成");
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
    NSLog(@"%f",totalBytesWritten/(double)totalBytesExpectedToWrite);
    
    [_progressView setProgress:totalBytesWritten/(double)totalBytesExpectedToWrite];
}

- (IBAction)next:(id)sender {
    if (self.musicIndex == 0) {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
