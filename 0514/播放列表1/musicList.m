//
//  musicList.m
//  TYPlayer
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "musicList.h"

#import "musicListCell.h"
#import "PlayViewController.h"


#import "musicModel.h"


//m4a 歌曲
#define CellIdentifier @"musiclist"

#define musicapi @"http://route.showapi.com/213-4?showapi_sign=a3b9cb3921c74e0ba31d2d7b2fbbed77&showapi_appid=6091&topid=5"

@interface musicList ()



@end

@implementation musicList



- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource=[NSMutableArray new];
    self.tableView.rowHeight=110;
    NSURL *URL = [NSURL URLWithString:musicapi];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:100.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil){
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
           _dataSource = [[[dic objectForKey:@"showapi_res_body"] objectForKey:@"pagebean" ] objectForKey:@"songlist"];
            

            [self.tableView reloadData];

            
        }
    }];
    [task resume];
    
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    musicListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[NSBundle mainBundle] loadNibNamed:@"musicListCell" owner:self options:nil].firstObject;
    }
  
   _dic2 = [_dataSource objectAtIndex:indexPath.row];
  cell.song.text = _dic2[@"songname"];
    cell.singer.text = _dic2[@"singername"];
    cell.songPic.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_dic2[@"albumpic_small"]]]];
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 PlayViewController *playView = [[PlayViewController alloc]init];
    playView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"myPlayViewController"];
    playView.listDictionary = _dic2;
    
    playView.musicIndex = indexPath.row;

    
    [self.navigationController pushViewController:playView animated:YES];
    

    
}

@end
