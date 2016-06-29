//
//  ExampleContentDetailViewController.m
//  BMLSegmentNavigation
//
//  Created by 伯明利 on 16/5/23.
//  Copyright © 2016年 bomingli. All rights reserved.
//

#import "ExampleContentDetailViewController.h"
#import "BMLTableView.h"

@interface ExampleContentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ExampleContentDetailViewController
{
    NSArray *sources;
    
    UITableView *tableView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    CGRect frame = self.view.frame;
//    frame.size.height -= 40;
//    
//    tableView.frame = frame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    float ver =[[[UIDevice currentDevice] systemVersion] floatValue];
//    if(ver>=7.0)
//    {
//        self.edgesForExtendedLayout =UIRectEdgeNone;
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    sources = @[@"爱情",@"婚姻",@"恋爱",@"情感",@"励志与成功",@"家庭事业",@"亲自",@"教育",@"爱情",@"婚姻",@"恋爱",@"情感",@"励志与成功",@"家庭事业"];
//    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    
//    [self.view addSubview:tableView];
    
    BMLTableView *bTableView = [[BMLTableView alloc] init];
    [bTableView creatTableViewWithFrame:self.view.frame style:UITableViewStyleGrouped target:self];
    bTableView.kDataSource = [NSMutableArray arrayWithArray:@[@[@"爱情",@"婚姻",@"恋爱",@"情感",@"励志与成功",@"家庭事业",@"亲自"],@[@"教育",@"爱情",@"婚姻",@"恋爱",@"情感",@"励志与成功",@"家庭事业"],@[@"亲自"]]];
    
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return sources.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellResuable"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellResuable"];
//    }
//    cell.textLabel.text = sources[indexPath.row];
//    cell.textLabel.textColor = [UIColor redColor];
//    
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@",sources[indexPath.row]);
//}

- (IBAction)clickContentButton:(UIButton *)sender {
    
    _contentLabel.text = _contentString;
    NSLog(@"点击了%@",[sender titleForState:UIControlStateNormal]);
}
- (void)setContentString:(NSString *)contentString {
    _contentString = contentString;
    
    _contentLabel.text = _contentString;
    
    [self loadViewIfNeeded];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
