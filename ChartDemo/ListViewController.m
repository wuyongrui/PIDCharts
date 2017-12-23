//
//  ListViewController.m
//  ChartDemo
//
//  Created by 吴勇锐 on 2017/12/23.
//  Copyright © 2017年 吴勇锐. All rights reserved.
//

#import "ListViewController.h"

#import "BarChartViewController.h"
#import "LineChartViewController.h"
#import "PieChartViewController.h"
#import "ChartViewController.h"

@interface ListViewController ()

@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *testDurations;

@end

@implementation ListViewController

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"Bar Chart",@"Line Chart",@"Circle Char"];
    [self loadDurations];
}

- (void)loadDurations {
    NSMutableArray<NSNumber *> *testDurations = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@(i)] ofType:@"plist"];
        NSArray<NSNumber *> *durations = [NSArray arrayWithContentsOfFile:path];
        testDurations = [[testDurations arrayByAddingObjectsFromArray:durations] mutableCopy];
    }
    [testDurations sortUsingComparator:^NSComparisonResult(NSNumber * obj1, NSNumber * obj2) {
        return [obj1 compare:obj2];
    }];
    self.testDurations = [NSMutableArray arrayWithCapacity:testDurations.count];
    for (NSNumber *duration in testDurations) {
        [self.testDurations addObject:@([duration integerValue] - 1.0)];
    }
    NSLog(@"时间：%@",self.testDurations);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listtableviewcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listtableviewcell"];
    }
    cell.textLabel.text = self.titles[indexPath.item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item <= 1) {
        ChartViewController *viewController;
        if (indexPath.item == 0) {
            viewController = [BarChartViewController new];
        } else if (indexPath.item == 1) {
            viewController = [LineChartViewController new];
        }
        viewController.testDurations = self.testDurations;
        viewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.item == 2) {
        PieChartViewController *viewController = [PieChartViewController new];
        viewController.fasterCount = 36;
        viewController.slowerCount = 14.0;
        viewController.nearCount = 10.0;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        NSAssert(YES, @"unknow indexpath");
    }
}

@end
