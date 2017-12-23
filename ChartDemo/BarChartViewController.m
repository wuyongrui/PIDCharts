//
//  BarChartViewController.m
//  ChartDemo
//
//  Created by 吴勇锐 on 2017/12/23.
//  Copyright © 2017年 吴勇锐. All rights reserved.
//

#import "BarChartViewController.h"

#import "PNChart.h"

@interface BarChartViewController ()

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - override

- (void)drawCharts {
    
    /*
     每个1秒统计次数
     */
    
    NSMutableArray<NSNumber *> *sortDurations = [self.testDurations mutableCopy];
    [sortDurations sortUsingComparator:^NSComparisonResult(NSNumber * obj1, NSNumber * obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableDictionary<NSString *,NSArray<NSNumber *> *> *dataDict = [NSMutableDictionary new];
    for (NSNumber *duration in self.testDurations) {
        NSInteger floorDuration = (NSInteger)duration.floatValue;
    
        NSString *floorDurationKey = [NSString stringWithFormat:@"%@",@(floorDuration)];
        NSMutableArray<NSNumber *> *arr = [dataDict[floorDurationKey] mutableCopy];
        if (!arr) {
            arr = [NSMutableArray new];
        }
        [arr addObject:duration];
        dataDict[floorDurationKey] = arr;
    }
    
    // 排序
    NSArray *sortedKeys = [[dataDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    NSMutableArray<NSArray<NSNumber *> *> *sortedValues = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
        [sortedValues addObject:[dataDict objectForKey: key]];
    }

    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    barChart.yChartLabelWidth = 20.0;
    barChart.chartMarginLeft = 30.0;
    barChart.chartMarginRight = 10.0;
    barChart.chartMarginTop = 5.0;
    barChart.chartMarginBottom = 10.0;
    
    barChart.labelMarginTop = 5.0;
    barChart.showChartBorder = YES;
    
    NSMutableArray<NSNumber *> *durationAreaCounts = [NSMutableArray array];
    for (NSMutableArray<NSNumber *> *durations in sortedValues) {
        [durationAreaCounts addObject:@(durations.count)];
    }
    NSMutableArray<NSString *> *durationAverages = [NSMutableArray array];
    for (NSMutableArray<NSNumber *> *durations in sortedValues) {
        [durationAverages addObject:[NSString stringWithFormat:@"%.2f",[self averageOfNumbers:durations]]];
    }
    
    [barChart setYValues:durationAreaCounts];
    [barChart setXLabels:durationAverages];
    
    [barChart setStrokeColors:@[PNGreen, PNGreen, PNGreen, PNGreen, PNRed]];
    barChart.isGradientShow = NO;
    barChart.isShowNumbers = NO;
    
    [barChart strokeChart];
    
    [self.view addSubview:barChart];
}

- (CGFloat)averageOfNumbers:(NSArray<NSNumber *> *)numbers {
    if (numbers.count == 0) {
        return 0.0;
    }
    CGFloat total = 0.0;
    for (NSNumber *number in numbers) {
        total += number.floatValue;
    }
    return total / numbers.count;
}

@end
