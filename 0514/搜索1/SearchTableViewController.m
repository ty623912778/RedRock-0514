//
//  SearchTableViewController.m
//  TYPlayer
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 mac. All rights reserved.
//
//#import "AppDelegate.h"

#import "SearchTableViewController.h"
#import "SearchCell.h"
#import "PlayViewController.h"

#define CellIdentifier @"searchCell"

#define musicapi @"http://route.showapi.com/213-1?showapi_sign=a3b9cb3921c74e0ba31d2d7b2fbbed77&showapi_appid=6091&keyword=nil"

@interface SearchTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>
{
    NSMutableArray *array;

    BOOL isSearch;
    BOOL isUnicode;
    BOOL isChar;
}

@property (nonatomic, strong) NSMutableArray *searchList;

@property (nonatomic, strong) NSMutableArray *visableArray;
@property (nonatomic, strong) NSMutableArray *unicodeArray;
@property (nonatomic, strong) NSMutableArray *charactorArray;
@property (nonatomic, strong) NSMutableArray *charactorTempArray;
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _visableArray = [NSMutableArray array];

    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.backgroundColor = [UIColor redColor];
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 40);
    
    //  self.searchController.searchResultsUpdater = resultsController;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    
    
    
    
    _dataSource=[NSMutableArray new];
    array = [NSMutableArray new];
    self.tableView.rowHeight=110;
    NSURL *URL = [NSURL URLWithString:musicapi];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:100.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request1 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil){
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            array = [[[dic objectForKey:@"showapi_res_body"] objectForKey:@"pagebean" ] objectForKey:@"contentlist"];
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                if ([[obj allKeys] containsObject:@"songname"]) {
                    
                    [_dataSource addObject:obj];
                }
            }];
            [self bikeArraySet];
            [self charactorArraySet];
            
            [self.tableView reloadData];
            
            
        }
    }];
    [task resume];
}

- (void)bikeArraySet {
    
    _unicodeArray = [NSMutableArray array];
    [_dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *unicode = [(NSString *)[obj objectForKey:@"songname"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [_unicodeArray addObject:unicode];
    }];
}

- (void)charactorArraySet {
    
    _charactorArray = [NSMutableArray array];
    [_dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString *charactorStr = [self firstCharactor:(NSString *)[obj objectForKey:@"songname"]];
        [_charactorArray addObject:charactorStr];
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.searchController.active) {
//        return [self.searchList count];
//    }else{
//        return _dataSource.count;
//    }
    
    if (!_visableArray || _visableArray.count == 0) {
        
        if (isUnicode) {
            
            return _visableArray.count;
        }
        if (isChar) {
            
            return _visableArray.count;
        }
        _visableArray = _dataSource;
    }
    return _visableArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil].firstObject;
    }
    
    if (!_visableArray || _visableArray.count == 0) {
        
        _visableArray = _dataSource;
    }
    if (isUnicode) {}
    else {}
    
    _dic2 = [_visableArray objectAtIndex:indexPath.row];
    cell.song.text = _dic2[@"songname"];
    cell.singer.text = _dic2[@"singername"];
    cell.songPic.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_dic2[@"albumpic_small"]]]];
    //    }
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
   
    
    {
        
        NSString *filterString = searchController.searchBar.text;
        
        if ([filterString isEqual:@""] || filterString == nil) {
            
            isUnicode = NO;
            isChar = NO;
            _visableArray = _dataSource;
            [self.tableView reloadData];
            return;
        }
        
        unichar c = [filterString characterAtIndex:0];
        if (c >= 0x4E00 && c <= 0x9FFF) {
            
            
            isUnicode = YES;
            NSMutableArray *tempArr = [NSMutableArray array];
            for (int i = 0; i < _unicodeArray.count; i++) {
                
                if ([_unicodeArray[i] rangeOfString:[filterString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]].location != NSNotFound) {
                    
                    [tempArr addObject:_dataSource[i]];
                }
            }
            
            _visableArray = tempArr;
        }
        else if ([self isCharacter:filterString]){
            
            filterString = [filterString lowercaseString];
            _charactorTempArray = [NSMutableArray array];
            for (int i = 0; i < _charactorArray.count; i++) {
                
                NSRange range = [_charactorArray[i] rangeOfString:filterString];
                if (range.location != NSNotFound) {
                    
                    [_charactorTempArray addObject:[_dataSource objectAtIndex:i]];
                }
            }
            
            isChar = YES;
            self.visableArray = _charactorTempArray;
        }
        else {
            
            [self.visableArray removeAllObjects];
        }
        
        [self.tableView reloadData];
        
    }
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索Begin");
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索End");
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    PlayViewController *playView = [[PlayViewController alloc]init];
    
    //playView.listDictionary = _dic2;
    
    [self.navigationController pushViewController:playView animated:YES];
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (BOOL)isCharacter:(NSString *)str {
    
    NSString *ZIMU = @"[a-zA-Z]";
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZIMU];
    BOOL isC = false;
    for (int i = 0; i < str.length; i++) {
        
        if ([regextestA evaluateWithObject:[str substringWithRange:NSMakeRange(i, 1)]])
        {
            isC = YES;
        }
        else
        {
            isC = NO;
        }
        
    }
    return isC;
}

- (NSString *)firstCharactor:(NSString *)aString
{
    NSMutableString *charactorStr = [NSMutableString string];
    
    if (aString && aString.length > 1) {
        
        for (int i = 0; i < aString.length; i++) {
            
            NSMutableString *str = [NSMutableString stringWithString:[aString substringWithRange:NSMakeRange(i, 1)]];
            CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
            CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
            NSString *pinYin = [str lowercaseString];
            NSString *firstChar = [pinYin substringToIndex:1];
            [charactorStr appendFormat:@"%@",firstChar];
        }
        
        return charactorStr;
    }
    else    return nil;
}

@end
