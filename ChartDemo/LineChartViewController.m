//
//  LineChartViewController.m
//  ChartDemo
//
//  Created by 吴勇锐 on 2017/12/23.
//  Copyright © 2017年 吴勇锐. All rights reserved.
//

#import "LineChartViewController.h"

#import "PNChart.h"

#import "NSMutableArray+Shuffling.h"

@interface LineChartViewController ()

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma  mark - override

- (void)drawCharts {
    
    NSInteger dataCount = self.testDurations.count;
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    [self.view addSubview:lineChart];
    NSMutableArray<NSString *> *xLabels = [NSMutableArray arrayWithCapacity:dataCount];
    for (int i = 0; i < dataCount; i ++) {
        [xLabels addObject:@""];
    }
    [lineChart setXLabels:xLabels];
    
    // Line Chart No.1
    NSMutableArray *data01Array = [self.testDurations mutableCopy];
    [data01Array shuffle];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    
    lineChart.showSmoothLines = YES;
    lineChart.showYGridLines = YES;
    lineChart.showLabel = NO;
}

@end
