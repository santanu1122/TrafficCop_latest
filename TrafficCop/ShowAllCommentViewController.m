//
//  ShowAllCommentViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 28/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//

#import "ShowAllCommentViewController.h"
#import "HelperClass.h"
#import "UserDetailesViewController.h"
#import "MFSideMenu.h"
#import "AppDelegate.h"
#import "ZSImageView.h"


@interface ShowAllCommentViewController ()
{
    HelperClass *ShowAllClassHelper;
    UITextView *commTxt;
    NSDictionary *mainDictionary;
    NSMutableArray *commentDataArray;
    NSOperationQueue *CommentOperfation;
}

@end

@implementation ShowAllCommentViewController
@synthesize AllCommentArray;
@synthesize theUserString;
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
    self.detatabl.delegate=self;
    self.detatabl.dataSource=self;
    [self.navigationController setNavigationBarHidden:YES];
    commentDataArray =[[NSMutableArray alloc]init];
    CommentOperfation=[[NSOperationQueue alloc]init];
    [ShowAllClassHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
  
    ShowAllClassHelper=[[HelperClass alloc]init];
    
    [ShowAllClassHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    [ShowAllClassHelper SetupHeaderView:self.view viewController:self];
    
    NSInvocationOperation *commentLoad=[[ NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadAllommentContain) object:nil];
    [CommentOperfation addOperation:commentLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableViewDetaSource

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *MainHeaderView;
    
    MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];
    
    
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 7, 320, 35)];
    
    [MainHeaderView addSubview:Titlelabel];
    if (section==0)
        Titlelabel.text=@"Reports of this user";
    else
        Titlelabel.text=@"Comments of this user";
    
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 320/3,1)];
    
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    
    [MainHeaderView addSubview:greenLabel];
    
    
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 49, 320/3,1)];
    
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    
    [MainHeaderView addSubview:yellowlabel];
    
    
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 49, 320/3+5,1)];
    
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    
    [MainHeaderView addSubview:redlabel];
    
    
    
    return MainHeaderView;
    
}

/*-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 {
 //    UIView *footerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
 //    [footerview setBackgroundColor:[UIColor whiteColor]];
 //    UIView *textviewBack=[[UIView alloc]initWithFrame:CGRectMake(40, 10, 240, 40)];
 //    textviewBack.layer.cornerRadius=240;
 //    textviewBack.layer.borderColor=UIColorFromRGB(0xf5f5f5).CGColor;
 //    textviewBack.layer.borderWidth=1.00f;
 //    textviewBack.layer.masksToBounds=YES;
 //     [footerview addSubview:textviewBack];
 //     commTxt=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 240, 40)];
 //      commTxt.font=[UIFont fontWithName:@"Arial" size:14];
 //      commTxt.textColor=[UIColor blackColor];
 //     [commTxt setBackgroundColor:[UIColor clearColor]];
 //     [textviewBack addSubview:commTxt];
 //      UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(240, 55, 40, 20)];
 //    [footerview addSubview:textviewBack];
 //    [button setBackgroundColor:UIColorFromRGB(0x17b04a)];
 //    [button setTitle:@"Post" forState:UIControlStateNormal];
 //    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 //
 //    [footerview addSubview:button];
 //    return footerview;
 // return self.footerView;
 
 }*/
-(void)loadAllommentContain
{
    
    @try {
        NSString *urlString=[NSString stringWithFormat:@"%@useractivity.php?userid=%@&mode=comment",Domenurl3,theUserString];
        
        NSURL *url=[NSURL URLWithString:urlString];
        NSData *data=[NSData dataWithContentsOfURL:url];
        mainDictionary=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        
        
        for(NSDictionary *HigstRatedReport in [mainDictionary objectForKey:@"comment_of_this_user"])
        {
            
            
            
            NSString *report_image = [HigstRatedReport objectForKey:@"userimage"];
            
            NSString *report_title = [HigstRatedReport objectForKey:@"reporttitle"];
            
            NSString *rating = [HigstRatedReport objectForKey:@"rating"];
            
            NSString *reportID = [HigstRatedReport objectForKey:@"reportid"];
            
            NSString *guistId = [HigstRatedReport objectForKey:@"getuserid"];
            
            NSString *review=[HigstRatedReport objectForKey:@"review"];
            
            
            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithCapacity:6];
            
            [tempDict setObject: report_image forKey:@"userimage"];
            
            [tempDict setObject: report_title forKey:@"reporttitle"];
            
            [tempDict setObject: rating forKey:@"rating"];
            
            [tempDict setObject: reportID forKey:@"reportid"];
            
            [tempDict setObject: guistId forKey:@"getuserid"];
            [tempDict setObject: review forKey:@"review"];
            [commentDataArray addObject:tempDict];
        }
        [self performSelectorOnMainThread:@selector(DetaTableReload) withObject:nil waitUntilDone:YES];
        
    }
    @catch (NSException *exception) {
        NSLog(@"the Exseption:%@",exception);
    }
    
}

-(void)DetaTableReload
{
    [self.detatabl reloadData];
    
    [ShowAllClassHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
    
}








-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [commentDataArray count];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    
    NSMutableDictionary *item;
    
    NSLog(@"The indexpath of sectiopn:%d",indexPath.section);
    [cell setFrame:CGRectMake(0, 0, 320, 105)];
    item = [[NSMutableDictionary alloc] initWithDictionary:[commentDataArray objectAtIndex:indexPath.row]];
    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 105)];
    
    MainCellView.backgroundColor = [UIColor clearColor];
    
    
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    
    ImageView.backgroundColor = [UIColor clearColor];
    
    [MainCellView addSubview:ImageView];
    
    
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
    
    imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
    
    imageView.imageUrl = [item objectForKey:@"report_image"];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    
    // imageView.corners = ZSRoundCornerAll;
    
    imageView.cornerRadius = 0;
    
    [ImageView addSubview:imageView];
    
    UILabel *ReportLable=[[UILabel alloc]initWithFrame:CGRectMake(45, 10, 30,22)];
    
    ReportLable.font=[UIFont fontWithName:@"Arial" size:8];
    ReportLable.text=@"Report: ";
    ReportLable.textColor=[UIColor darkGrayColor];
    [MainCellView addSubview:ReportLable];
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, 250, 22)];
    
    TitleLabel.backgroundColor = [UIColor clearColor];
    
    TitleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    TitleLabel.textColor = UIColorFromRGB(0xfcb714);
    
    TitleLabel.text = [ShowAllClassHelper stripTags:[item objectForKey:@"reporttitle"]];
    TitleLabel.numberOfLines = 2;
    
    TitleLabel.textAlignment = NSTextAlignmentLeft;
    
    [MainCellView addSubview:TitleLabel];
    
    UIImageView *reportimage=[[UIImageView alloc]initWithFrame:CGRectMake(75, 34, 100, 16)];
    [MainCellView addSubview:reportimage];
    ZSImageView *ReatingimageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0,100, 16)];
    
    //ReatingimageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
    
    ReatingimageView.imageUrl = [item objectForKey:@"rating"];
    
    ReatingimageView.contentMode = UIViewContentModeScaleAspectFill;
    
    ReatingimageView.clipsToBounds = YES;
    
    // imageView.corners = ZSRoundCornerAll;
    
    ReatingimageView.cornerRadius = 0;
    [reportimage addSubview:ReatingimageView];
    //[ImageView addSubview:ReatingimageView];
    
    
    UILabel *Detailslabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 310, 35)];
    
    Detailslabel.backgroundColor = [UIColor clearColor];
    
    Detailslabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    Detailslabel.textColor = UIColorFromRGB(0x1aad4b);
    
    Detailslabel.text = [ShowAllClassHelper stripTags:[item objectForKey:@"review"]];
    
    Detailslabel.numberOfLines = 0;
    
    Detailslabel.textAlignment = NSTextAlignmentLeft;
    
    
    
    [MainCellView addSubview:Detailslabel];
    [cell.contentView addSubview:MainCellView];
    
    
    
    
    
    
    return cell;
}

- (void)rightSideMenuButtonPressed:(id)sender {
    
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
    
}



- (IBAction)LoadMoreDeta:(id)sender
{
    
    
    
}
@end
