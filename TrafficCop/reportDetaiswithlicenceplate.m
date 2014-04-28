//
//  reportDetaiswithlicenceplate.m
//  TrafficCop
//
//  Created by macbook_ms on 13/02/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "reportDetaiswithlicenceplate.h"
#import "CellForevidenceLockerCell.h"
#import "ZSImageView.h"
#import "MFSideMenu.h"
#import "AppDelegate.h"
#import "ReportDetailsViewController.h"
#import "HelperClass.h"

@interface reportDetaiswithlicenceplate ()
{
    NSMutableArray *Roportofthelicence;
    NSOperationQueue *operation;
    NSString *userId;
    HelperClass *helprforlicencedetails;
    
}
@property (strong, nonatomic) IBOutlet UITableView *licenceplatDetaisTbl;
@property (weak, nonatomic) IBOutlet UILabel *NoReportExist;

@end

@implementation reportDetaiswithlicenceplate
@synthesize licenceplatDetaisTbl;
@synthesize Licenceplate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    helprforlicencedetails=[[HelperClass alloc]init];
    self.navigationController.navigationBar.hidden=YES;
    [helprforlicencedetails SetupHeaderView:self.view viewController:self];
    [helprforlicencedetails SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    Roportofthelicence=[[NSMutableArray alloc]init];
    operation=[[NSOperationQueue alloc]init];
    NSUserDefaults *userdefals=[NSUserDefaults standardUserDefaults];
    userId=  [userdefals valueForKey:@"userid"];
    [helprforlicencedetails SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    NSInvocationOperation *operationTODone=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(LoadAllreportForthisLicence) object:nil];
    [operation addOperation:operationTODone];
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _NoReportExist.hidden = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)LoadAllreportForthisLicence
{
    NSString *strinmg=[NSString stringWithFormat:@"%@report_details.php?licence_plate=%@&loginuser=%@",DomainURL,Licenceplate,userId];
    
    NSLog(@"url as str iss -- %@", strinmg);
    NSLog(@"the licence plate:%@",Licenceplate);
    NSURL *url=[NSURL URLWithString:strinmg];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSDictionary *mainDic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *ResultArray=[mainDic valueForKey:@"reportdetails"];
    NSLog(@"reportdetails array iss %@", ResultArray);
    
    //if ([ResultArray objectAtIndex:0] == [NSNull null])
    //if ([ResultArray isKindOfClass:NULL] || [ResultArray objectAtIndex:0] == [NSNull null])
    if(ResultArray == nil || [ResultArray count]<1)
    {
        NSLog(@"no report");
        [self performSelectorOnMainThread:@selector(isNodataPresent) withObject:nil waitUntilDone:YES];
    }
    
    else
    {
        NSLog(@"reportt existtttt");
    for (NSDictionary *Dic in ResultArray)
    {
        NSMutableDictionary *mutdic=[[NSMutableDictionary alloc]initWithCapacity:7];
        [mutdic setObject:[Dic valueForKey:@"report_id"] forKey:@"report_id"];
        [mutdic setObject:[Dic valueForKey:@"report_title"] forKey:@"report_title"];
        [mutdic setObject:[Dic valueForKey:@"report_desc"] forKey:@"report_desc"];
        [mutdic setObject:[Dic valueForKey:@"report_avg_rating"] forKey:@"report_avg_rating"];
        [mutdic setObject:[Dic valueForKey:@"report_comment_text"] forKey:@"report_comment_text"];
        [mutdic setObject:[Dic valueForKey:@"posted_by"] forKey:@"posted_by"];
        [mutdic setObject:[Dic valueForKey:@"get_image"] forKey:@"get_image"];
        [Roportofthelicence addObject:mutdic];
    }
    
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
    }
}
-(void)reloadTable
{
    
    [helprforlicencedetails SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    [licenceplatDetaisTbl reloadData];

}

-(void)isNodataPresent
{
    [helprforlicencedetails SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
     _NoReportExist.hidden=NO;
    
}


//pragma tableviewdelegate imolemantation

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    [MainHeaderView setBackgroundColor:[UIColor whiteColor]];

    UILabel *Titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 35)];
    Titlelabel.text=[[NSString stringWithFormat:@"%@ %@",@"License plates",Licenceplate] uppercaseString];
    Titlelabel.textAlignment=NSTextAlignmentCenter;
    Titlelabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0f];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Roportofthelicence count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    cell=[[UITableViewCell alloc]init];
    NSMutableDictionary *item=[[NSMutableDictionary alloc]init];
    item=[Roportofthelicence objectAtIndex:indexPath.row];
   
    
    UIView  *MainCellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 109)];
    
    MainCellView.backgroundColor = [UIColor clearColor];
    
    [cell.contentView addSubview:MainCellView];
    
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 65, 65)];
    ImageView.backgroundColor = [UIColor clearColor];
    [MainCellView addSubview:ImageView];
    
    ZSImageView *imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    
    imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle.png"];
    
    imageView.imageUrl = [item objectForKey:@"get_image"];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    imageView.corners = ZSRoundCornerAll;
    imageView.cornerRadius = 25;
    [ImageView addSubview:imageView];
   
    UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
    [ImageView addSubview:ImageOverlay];
    
    
    
    UILabel *LablePostby=[[UILabel alloc] initWithFrame:CGRectMake(90, 10, 250, 25)];
    LablePostby.backgroundColor = [UIColor clearColor];
    
    LablePostby.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0];
    
    LablePostby.textColor = UIColorFromRGB(0x211e1f);
    
    LablePostby.text = [helprforlicencedetails stripTags:[item objectForKey:@"posted_by"]];
    
    [MainCellView addSubview:LablePostby];
    
    
    UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 35, 250, 25)];
    
    TitleLabel.backgroundColor = [UIColor clearColor];
    
    TitleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0];
    
    TitleLabel.textColor = UIColorFromRGB(0x211e1f);
    
    TitleLabel.text = [helprforlicencedetails stripTags:[item objectForKey:@"report_title"]];
    
    [MainCellView addSubview:TitleLabel];
    
    
    
    int TOTAL = 5;
    
    int YELLOW = [[item objectForKey:@"report_avg_rating"] intValue];
    
    int GRAY = TOTAL - YELLOW;
    
    float SIZEX = 5;
    
    
    
    for(int i=0; i < YELLOW; i++) {
        
        if(i==0)
            
            //SIZEX = 60+5;
            SIZEX = 90;
        
        UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 63, 20, 20)];
        
        ImageViewone.backgroundColor = [UIColor clearColor];
        
        ImageViewone.image = [UIImage imageNamed:@"starNEW"];
        
        [MainCellView addSubview:ImageViewone];
        
        //SIZEX = SIZEX + 16;
        SIZEX = SIZEX + 22;
    }
    
    for(int j=0; j < GRAY; j++)
    {
        
        if(GRAY==5 && j==0)
            
            //SIZEX = 60+5;
              SIZEX = 90;
        UIImageView *ImageViewone = [[UIImageView alloc] initWithFrame:CGRectMake(SIZEX, 63, 20, 20)];
        
        ImageViewone.backgroundColor = [UIColor clearColor];
        
        ImageViewone.image = [UIImage imageNamed:@"star1NEW"];
        
        [MainCellView addSubview:ImageViewone];
        
        //SIZEX = SIZEX + 16;
        SIZEX = SIZEX + 22;
        
    }
   
    cell.textLabel.text=[item objectForKey:@"report_id"];
    cell.textLabel.hidden=YES;
    
    UILabel *Detailslabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 85, 230, 50)];
    Detailslabel.backgroundColor = [UIColor clearColor];
    Detailslabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:12.0];
    Detailslabel.textColor = UIColorFromRGB(0x575757);
    Detailslabel.text = [helprforlicencedetails stripTags:[item objectForKey:@"report_desc"]];
    Detailslabel.numberOfLines = 0;
    Detailslabel.textAlignment = NSTextAlignmentLeft;
    [MainCellView addSubview:Detailslabel];
    
    UILabel *SeparatorLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 134, 320, .5)];
    [SeparatorLable setBackgroundColor:[UIColor lightGrayColor]];
    //[SeparatorLable.layer setOpacity:.2];
    [cell.contentView addSubview:SeparatorLable];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    AppDelegate *maindelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
       cell.selectionStyle=UITableViewCellSelectionStyleNone;
    ReportDetailsViewController *reportdetais=[[ReportDetailsViewController alloc]init];
    reportdetais.reportId=cell.textLabel.text;
    [maindelegate SetUpTabbarControllerwithcenterView:reportdetais];
 
    
}
#pragma manuBar

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
}


@end
