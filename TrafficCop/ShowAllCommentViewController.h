//
//  ShowAllCommentViewController.h
//  TrafficCop
//
//  Created by macbook_ms on 28/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowAllCommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *AllCommentArray;


@property (strong, nonatomic) IBOutlet UITableView *detatabl;
@property (strong, nonatomic) NSString *theUserString;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (assign) BOOL isBackEnabled;
@end
