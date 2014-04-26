//
//  ShowallCommentreportpostbyme.m
//  TrafficCop
//
//  Created by macbook_ms on 16/12/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "ShowallCommentreportpostbyme.h"

@interface ShowallCommentreportpostbyme ()

@end

@implementation ShowallCommentreportpostbyme

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    return cell;
}

//-(NSInteger)table
@end
