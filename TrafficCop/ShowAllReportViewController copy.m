//
//  ShowAllReportViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 28/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "ShowAllReportViewController.h"
#import "ZSImageView.h"
#import "MFSideMenu.h"
#import "HelperClass.h"

@interface ShowAllReportViewController ()
{
    HelperClass *reportLableHelper;
}

@end

@implementation ShowAllReportViewController
@synthesize ReportArray;
@synthesize TheuserId;


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
    reportLableHelper=[[HelperClass alloc]init];
    [reportLableHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [reportLableHelper SetupHeaderView:self.view viewController:self];
    
    [self.navigationController setNavigationBarHidden:YES];
    [reportLableHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
}
- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}
-(void)HideNavigationBar {
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableViewDetaSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ReportArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell=[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    
    NSLog(@"The indexpath of sectiopnm for report:%d",indexPath.section);
    [cell setFrame:CGRectMake(0, 0, 320, 70)];
    NSMutableDictionary *item1;
    NSLog(@"report tableview");
    item1 = [[NSMutableDictionary alloc] initWithDictionary:[ReportArray objectAtIndex:indexPath.row]];
    
    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    
    MainCellView.backgroundColor = [UIColor clearColor];
    [cell addSubview:MainCellView];
    
    
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    
    ImageView.backgroundColor = [UIColor clearColor];
    
    [MainCellView addSubview:ImageView];
    
    
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
    
    imageView.imageUrl = [item1 objectForKey:@"report_image"];
    
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    
    // imageView.corners = ZSRoundCornerAll;
    
    imageView.cornerRadius = 0;
    
    [ImageView addSubview:imageView];
    
    
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 260, 25)];
    
    TitleLabel.backgroundColor = [UIColor clearColor];
    
    TitleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    TitleLabel.textColor = UIColorFromRGB(0xfcb714);
    
    TitleLabel.text = [reportLableHelper stripTags:[item1 objectForKey:@"report_title"]];
    
    
    [MainCellView addSubview:TitleLabel];
    int TOTAL = 5;
    
    int YELLOW = [[item1 objectForKey:@"avg_rating"] intValue];
    
    int GRAY = TOTAL - YELLOW;
    
    float SIZEX = 5;
    
    
    
    for(int i=0; i < YELLOW; i++) {
        
        if(i==0)
            
            SIZEX = 60+5;
        
        UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 30, 16, 16)];
        
        ImageViewone.backgroundColor = [UIColor clearColor];
        
        ImageViewone.image = [UIImage imageNamed:@"YELLOWSTER"];
        
        [MainCellView addSubview:ImageViewone];
        
        SIZEX = SIZEX + 16;
        
    }
    
    for(int j=0; j < GRAY; j++) {
        
        if(GRAY==5 && j==0)
            
            SIZEX = 60+5;
        
        UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 30, 16, 16)];
        
        ImageViewone.backgroundColor = [UIColor clearColor];
        
        ImageViewone.image = [UIImage imageNamed:@"GRAYSTAR"];
        
        [MainCellView addSubview:ImageViewone];
        
        SIZEX = SIZEX + 16;
        
    }
    
    
    UILabel *Numborofcmtlabl=[[UILabel alloc]initWithFrame:CGRectMake(150, 30, 80, 16)];
    Numborofcmtlabl.textColor=[UIColor darkGrayColor];
    Numborofcmtlabl.font=[UIFont fontWithName:@"Arial" size:11];
    NSString *detaString=[NSString stringWithFormat:@"%@ %@",[item1 objectForKey:@"total_comment_this_report"],@"Comment"];
    Numborofcmtlabl.text=detaString;
    [MainCellView addSubview:Numborofcmtlabl];
    
    
    return cell;
    
}

@end
