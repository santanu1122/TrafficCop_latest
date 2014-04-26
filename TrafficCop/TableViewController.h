//
//  TableViewController.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 22/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol TableviewDelegate <UITableViewDelegate>

@end

@protocol TableviewDatasource <UITableViewDataSource>

@end

@interface TableViewController : UIView

@property (nonatomic,assign) id<TableviewDelegate> delegate;
@property (nonatomic,assign) id<TableviewDatasource> datasource;
@property (nonatomic,retain) UITableView *MyCustomTableView;
@property (nonatomic,retain) NSArray *TableviewDataArray;
@end
