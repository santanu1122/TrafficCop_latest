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
@synthesize isBackEnabled;
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
    
    if(isBackEnabled==YES){
        [ShowAllClassHelper SetupHeaderViewWithBack:self.view viewController:self];
    }else{
        [ShowAllClassHelper SetupHeaderView:self.view viewController:self];
    }
    //[ShowAllClassHelper SetupHeaderView:self.view viewController:self];
    
    NSInvocationOperation *commentLoad=[[ NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadAllommentContain) object:nil];
    [CommentOperfation addOperation:commentLoad];
}

- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
 /*
    UIButton *BackBtnInHeader = [[UIButton alloc]initWithFrame:CGRectMake(9, 7, 39, 35)];
    BackBtnInHeader.backgroundColor = [UIColor clearColor];
    [BackBtnInHeader setImage:[UIImage imageNamed:@"arrow-left.png"] forState:UIControlStateNormal];
    [BackBtnInHeader addTarget:self action:@selector(BackBtnInHeaderPressed) forControlEvents:UIControlEventTouchUpInside];
    [MainHeaderView addSubview:BackBtnInHeader];
 */
    
    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(89, 7, 180, 35)];
    Titlelabel.text=@"Comments of this user";
    Titlelabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15];
    Titlelabel.textColor = UIColorFromRGB(0x211e1f);
    [MainHeaderView addSubview:Titlelabel];
    
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

//-(void)BackBtnInHeaderPressed

//- (IBAction)BackBtnInHeaderPressed
//{
//    NSLog(@"back btn pressed");
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (void)BackBtnInHeaderPressed
{
    NSLog(@"back btn pressed");
   // [self.navigationController popToViewController: animated:YES];
   // [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
    [cell setFrame:CGRectMake(0, 0, 320, 110)];
    item = [[NSMutableDictionary alloc] initWithDictionary:[commentDataArray objectAtIndex:indexPath.row]];
    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 110)];
    
    MainCellView.backgroundColor = [UIColor clearColor];
    
    
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 65, 65)];
    
    ImageView.backgroundColor = [UIColor clearColor];
    
    [MainCellView addSubview:ImageView];
    
    
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    
    imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
    
//    imageView.imageUrl = [item objectForKey:@"report_image"];
    
    imageView.imageUrl = [item objectForKey:@"userimage"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    
    imageView.corners = ZSRoundCornerAll;
    
    imageView.cornerRadius = 25;
    
    [ImageView addSubview:imageView];
    
    UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
    [ImageView addSubview:ImageOverlay];

    
    
    UILabel *ReportLable=[[UILabel alloc]initWithFrame:CGRectMake(90, 10, 50,25)];
    ReportLable.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:14];
    ReportLable.textColor = UIColorFromRGB(0x211e1f);
    ReportLable.text=@"Report: ";
    [MainCellView addSubview:ReportLable];
    
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 11, 200, 25)];
    
    TitleLabel.backgroundColor = [UIColor clearColor];
    
    TitleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:14];
    
//    TitleLabel.textColor = UIColorFromRGB(0x000000);
        TitleLabel.textColor = UIColorFromRGB(0x575757);
    
    TitleLabel.text = [ShowAllClassHelper stripTags:[item objectForKey:@"reporttitle"]];
    TitleLabel.numberOfLines = 2;
    
    TitleLabel.textAlignment = NSTextAlignmentLeft;
    
    [MainCellView addSubview:TitleLabel];
    
    UIImageView *reportimage=[[UIImageView alloc]initWithFrame:CGRectMake(90, 38, 100, 16)];
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
    
    UITextView *DetailsTextViewFortext=[[UITextView alloc]init];
    DetailsTextViewFortext.text = [ShowAllClassHelper stripTags:[item objectForKey:@"review"]];
    
    NSAttributedString *attributed=[[NSAttributedString alloc]initWithString:[ShowAllClassHelper stripTags:[item objectForKey:@"review"]]];
    [DetailsTextViewFortext setAttributedText:attributed];
    CGSize sizeForDetailslabel = [DetailsTextViewFortext sizeThatFits:CGSizeMake(225, FLT_MAX)];
    
    
    DetailsTextViewFortext.frame = CGRectMake(90, 60, 225, sizeForDetailslabel.height);
    [DetailsTextViewFortext setTextAlignment:NSTextAlignmentJustified];
    DetailsTextViewFortext.backgroundColor = [UIColor clearColor];
    
    DetailsTextViewFortext.font = [UIFont fontWithName:GLOBALTEXTFONT size:12];
//    Detailslabel.textColor = UIColorFromRGB(0x000000);
    DetailsTextViewFortext.textColor = UIColorFromRGB(0x575757);
    DetailsTextViewFortext.editable=NO;
    DetailsTextViewFortext.scrollEnabled=NO;
    
//    Detailslabel.textAlignment = NSTextAlignmentLeft;
    [MainCellView addSubview:DetailsTextViewFortext];
    
    MainCellView.frame=CGRectMake(0, 0, 320, DetailsTextViewFortext.frame.origin.y+DetailsTextViewFortext.frame.size.height+3);
    
    UILabel *Separetor=[[UILabel alloc]initWithFrame:CGRectMake(0, DetailsTextViewFortext.frame.origin.y+DetailsTextViewFortext.frame.size.height+2, 320, .5)];
    [Separetor setBackgroundColor:[UIColor blackColor]];
    Separetor.layer.opacity=0.5f;
    [MainCellView addSubview:Separetor];
    
    //cell.frame = CGRectMake(0, 0, 320, MainCellView.layer.frame.size.height);
    
    NSLog(@"main cel view h8 %f", MainCellView.layer.frame.size.height);
    
    [cell.contentView addSubview:MainCellView];
    
    
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *item;
    item = [[NSMutableDictionary alloc] initWithDictionary:[commentDataArray objectAtIndex:indexPath.row]];

 

    UITextView *thetexttest=[[UITextView alloc]init];
    
    thetexttest.text=[ShowAllClassHelper stripTags:[item objectForKey:@"review"]];
    //thetexttest.text=[item objectForKey:@"review"];
    
    NSAttributedString *attributed=[[NSAttributedString alloc]initWithString:[ShowAllClassHelper stripTags:[item objectForKey:@"review"]]];
    [thetexttest setAttributedText:attributed];
    
    [thetexttest setAttributedText:attributed];
    CGSize size = [thetexttest sizeThatFits:CGSizeMake(225, FLT_MAX)];
    thetexttest.hidden=YES;
    thetexttest=nil;
    
    NSLog(@"row hight is %f", size.height);
    //    return size.height+100;
    return size.height+65;
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}




- (IBAction)LoadMoreDeta:(id)sender
{
    
    
    
}
@end
