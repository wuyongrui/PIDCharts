//
//  PieChartViewController.m
//  ChartDemo
//
//  Created by 吴勇锐 on 2017/12/23.
//  Copyright © 2017年 吴勇锐. All rights reserved.
//

#import "PieChartViewController.h"
#import "PNChart.h"

@interface PieChartViewController ()

@end

@implementation PieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"与NearLock解锁速度比较";
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:self.fasterCount color:PNLightGreen description:@"我们更快"],
                       [PNPieChartDataItem dataItemWithValue:self.nearCount color:PNButtonGrey description:@"相近"],
                       [PNPieChartDataItem dataItemWithValue:self.slowerCount color:[UIColor brownColor] description:@"NearLock稍快"],
                       ];
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake((CGFloat) (SCREEN_WIDTH / 2.0 - 100), 135, 200.0, 200.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    pieChart.descriptionTextShadowColor = [UIColor clearColor];
    pieChart.showAbsoluteValues = NO;
    pieChart.showOnlyValues = NO;
    [pieChart strokeChart];
    
    
    pieChart.legendStyle = PNLegendItemStyleStacked;
    pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    
    UIView *legend = [pieChart getLegendWithMaxWidth:200];
    [legend setFrame:CGRectMake(130, 350, legend.frame.size.width, legend.frame.size.height)];
    [self.view addSubview:legend];
    
    [self.view addSubview:pieChart];

}

@end
