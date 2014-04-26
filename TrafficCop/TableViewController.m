//
//  TableViewController.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 22/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "TableViewController.h"

#define kDefaultHeight      44.0f
#define kDefaultMargin      5.0f

#define kTagRotatedView     101
#define kTagLabelView       102

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation TableViewController

- (id)init
{
    return [self initWithHeight:kDefaultHeight];
}

- (id)initWithHeight:(CGFloat)height
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, height)];
    if (self) {
        
        _MyCustomTableView	= [[UITableView alloc] initWithFrame:CGRectMake((self.bounds.size.width - self.bounds.size.height) / 2,
                                                                            (self.bounds.size.height - self.bounds.size.width) / 2,
                                                                            self.bounds.size.height, self.bounds.size.width)];
        
        // init the bar the hidden state
        self.hidden = YES;
        
        _MyCustomTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _MyCustomTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        
        _MyCustomTableView.showsVerticalScrollIndicator = NO;
        _MyCustomTableView.showsHorizontalScrollIndicator = NO;
        _MyCustomTableView.backgroundColor = [UIColor grayColor];
        _MyCustomTableView.layer.opacity = 0.9;
        
        _MyCustomTableView.dataSource = self;
        _MyCustomTableView.delegate = self;
        
        // clean the rest of separators
        _MyCustomTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f)];
        
        // add the table as subview
        [self addSubview:_MyCustomTableView];
        
    }
    return self;
}



#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.TableviewDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    return cell;
}


@end
