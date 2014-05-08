//
//  pushNotificationViewController.m
//  TrafficCop
//
//  Created by macbook_ms on 25/11/13.
//  Copyright (c) 2013 Esolz. All rights reserved.
//http://esolzdemos.com/lab3/trafficcop/IOS/notifications.php

#import "pushNotificationViewController.h"
#import "HelperClass.h"
#import "MFSideMenu.h"




@interface pushNotificationViewController ()
{
    HelperClass *pushnotiFicationHelper;
    NSMutableArray *ContainArry;
    NSOperationQueue *TheOperation;
    
}

@end

@implementation pushNotificationViewController
@synthesize pushContainScroll;

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
    pushnotiFicationHelper = [[HelperClass alloc] init];
    [pushnotiFicationHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
      pushContainScroll.backgroundColor=[UIColor whiteColor];
      TheOperation=[[NSOperationQueue alloc]init];
    
       [self.navigationController setNavigationBarHidden:YES];
    
       ContainArry=[[NSMutableArray alloc]init];
    
       [pushnotiFicationHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    
       [pushnotiFicationHelper SetupHeaderView:self.view viewController:self];
    
    NSInvocationOperation *ShowAllOperation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(ShowAllTipes) object:nil];
    [TheOperation addOperation:ShowAllOperation];

      


    
 
}
-(void)ShowAllTipes
{
    NSString *URLString=[NSString stringWithFormat:@"%@notifications.php",DomainURL];

    NSLog(@"tips urlll iss--- %@", URLString);
    NSURL *URL=[NSURL URLWithString:URLString];
    NSData *Data=[NSData dataWithContentsOfURL:URL];
    NSDictionary *MainDictionary=[NSJSONSerialization JSONObjectWithData:Data options:kNilOptions error:Nil];
   
    
    for (NSDictionary *SubDictionary in MainDictionary )
    {
        NSMutableDictionary *ContainDic=[[NSMutableDictionary alloc]initWithCapacity:3];
        NSString *Titel=[SubDictionary objectForKey:@"title"];
        
        NSString *Tips=[SubDictionary objectForKey:@"tips"];
        NSString *PostDate=[SubDictionary objectForKey:@"added_date"];
        [ContainDic setValue:Titel forKey:@"title"];
        [ContainDic setValue:Tips forKey:@"tips"];
        [ContainDic setValue:PostDate forKey:@"added_date"];
        
        [ContainArry addObject:ContainDic];
        
        }
   
    [self performSelectorOnMainThread:@selector(ContainOfScroll) withObject:nil waitUntilDone:YES];
    
}

//-(void)ContainOfScroll
//{
//  
//@try
//{
//    
//    int i=0;
//    UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
//    [HeaderView setBackgroundColor:[UIColor whiteColor]];
////    [pushnotiFicationHelper CreatelabelWithValue:0 ycord:0 width:320 height:22 backgroundColor:[UIColor clearColor] textcolor:[UIColor blackColor] labeltext:@"Tips of the day" fontName:@"Arial"  fontSize:15.0f addView:pushContainScroll];
//    UILabel *Lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 22)];
//    Lable.text=@"Tips of the day";
//    Lable.textAlignment=NSTextAlignmentCenter;
//    Lable.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:20.0f];
//    Lable.textColor = UIColorFromRGB(0x211e1f);
//    
//    [pushContainScroll addSubview:Lable];
//    
//    
//    for (NSMutableDictionary *MutDic in ContainArry)
//    {
//        
//        UIView *cellBackView=[[UIView alloc]init];
//        [cellBackView setBackgroundColor:[UIColor whiteColor]];
//       
//       CGSize textViewSize = [[MutDic objectForKey:@"tips"] sizeWithFont:[UIFont fontWithName:GLOBALTEXTFONT size:13]
//                               constrainedToSize:CGSizeMake(282, FLT_MAX)
//                                lineBreakMode:NSLineBreakByWordWrapping];
//        
//        
//        UITextView *commentText=[[UITextView alloc]initWithFrame:CGRectMake(25, 10, 282, textViewSize.height+20)];
//        NSLog(@"The text field.hight:%f",textViewSize.height);
//         commentText.font=[UIFont fontWithName:GLOBALTEXTFONT size:14.0f];
////         commentText.textColor=[UIColor darkGrayColor];
//        Lable.textColor = UIColorFromRGB(0x000000);
//        NSArray *arr = [[MutDic objectForKey:@"tips"] componentsSeparatedByString:@"<p>"];
//        NSArray *arr1 = [[arr objectAtIndex:1] componentsSeparatedByString:@"</p>"];
//         commentText.text=[arr1 objectAtIndex:0];
//         commentText.scrollEnabled=NO;
//         commentText.editable=NO;
//         commentText.showsHorizontalScrollIndicator=NO;
//         commentText.showsVerticalScrollIndicator=NO;
//        [commentText setBackgroundColor:[UIColor redColor]];
//       
//        [cellBackView addSubview:commentText];
//       
//        
//        UILabel *addDateLable=[[UILabel alloc]initWithFrame:CGRectMake(210,commentText.frame.size.height+commentText.frame.origin.y-5, 105, 13)];
//        [addDateLable setTextColor:[UIColor blackColor]];
//         addDateLable.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:10.0f];
//         addDateLable.text=[MutDic objectForKey:@"added_date"];
//       
//        UIView *separetor=[[UIView alloc]initWithFrame:CGRectMake(20, commentText.frame.size.height+commentText.frame.origin.y+25, 280, 1)];
//        [separetor setBackgroundColor:[UIColor lightGrayColor]];
//        //[cellBackView addSubview:separetor];
//       
////        [cellBackView setFrame:CGRectMake(0, 22+commentText.frame.size.height+commentText.frame.origin.y+26, 320, separetor.frame.origin.y+1)];
//       
//      //  [cellBackView setFrame:CGRectMake(0, 22+((separetor.frame.origin.y+1)*i)+2, 320, separetor.frame.origin.y+1)];
//        
//         [cellBackView setFrame:CGRectMake(0, 22+((separetor.frame.origin.y+1)*i)+2, 320, separetor.frame.origin.y+1)];
//        
//        cellBackView.backgroundColor = [UIColor lightGrayColor];
//       // [cellBackView setFrame:CGRectMake(0, commentText.frame.size.height+commentText.frame.origin.y+addDateLable.frame.size.height, 320, separetor.frame.origin.y+1)];
//        
//        [cellBackView addSubview:separetor];
//        [cellBackView addSubview:addDateLable];
//     
//        [pushContainScroll addSubview:cellBackView];
//         pushContainScroll.contentSize=CGSizeMake(320, 22+cellBackView.frame.size.height+(cellBackView.frame.size.height*i));
//        i++;
//        
//    }
//    
//    [pushnotiFicationHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
// 
//    
//    
//
//}
//    @catch (NSException *juju)
//    
//    {
//        
//        
//        
//        NSLog(@"Reporting JUJU From DownloadImage:: %@", juju);
//        
//    }
//    
//    
//
//}



-(void)ContainOfScroll

{
    
    int i=0;
    
    UIView *HeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
//    [HeaderView setBackgroundColor:[UIColor whiteColor]];
    
    [HeaderView setBackgroundColor:[UIColor clearColor]];
    
    //    [pushnotiFicationHelper CreatelabelWithValue:0 ycord:0 width:320 height:22 backgroundColor:[UIColor clearColor] textcolor:[UIColor blackColor] labeltext:@"Tips of the day" fontName:@"Arial"  fontSize:15.0f addView:pushContainScroll];
    
    UILabel *Lable=[[UILabel alloc]initWithFrame:CGRectMake(0, -8, 320, 30)];
    
    Lable.text=@"Tips of the day";
    
    Lable.textAlignment=NSTextAlignmentCenter;
    
    Lable.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:20.0f];
    
    Lable.textColor = UIColorFromRGB(0x211e1f);
    
    [HeaderView addSubview:Lable];
    
    
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, 320/3,1)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [HeaderView addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 29, 320/3,1)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [HeaderView addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 29, 320/3+5,1)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [HeaderView addSubview:redlabel];
    
    
    [pushContainScroll addSubview:HeaderView];
    
    int ipos=31;
    
    for (NSMutableDictionary *MutDic in ContainArry)
        
    {
        
        UIView *cellBackView=[[UIView alloc]init];
        
        [cellBackView setBackgroundColor:[UIColor clearColor]];
        
        
        
        CGSize textViewSize = [[MutDic objectForKey:@"tips"] sizeWithFont:[UIFont fontWithName:GLOBALTEXTFONT size:14]
                               
                                                        constrainedToSize:CGSizeMake(282, FLT_MAX)
                               
                                                            lineBreakMode:NSLineBreakByWordWrapping];
        
        
        
        
        
        UITextView *commentText=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, 300, textViewSize.height+20)];
        
        NSLog(@"The text field.hight:%f",textViewSize.height);
        
        commentText.font=[UIFont fontWithName:GLOBALTEXTFONT size:14.0f];
        commentText.textColor = UIColorFromRGB(0x575757);
        
      //  Lable.textColor = UIColorFromRGB(0x575757);
        
        //        NSArray *arr = [[MutDic objectForKey:@"tips"] componentsSeparatedByString:@"<p>"];
        
        //        NSArray *arr1 = [[arr objectAtIndex:1] componentsSeparatedByString:@"</p>"];
        
        commentText.text=[MutDic objectForKey:@"tips"];
        
        commentText.scrollEnabled=NO;
        
        commentText.editable=NO;
        
        commentText.showsHorizontalScrollIndicator=NO;
        
        commentText.showsVerticalScrollIndicator=NO;
        
        [commentText setBackgroundColor:[UIColor clearColor]];
        
        
        
        [cellBackView addSubview:commentText];
        
        
//        UILabel *addDateLable=[[UILabel alloc]initWithFrame:CGRectMake(17,commentText.frame.size.height+commentText.frame.origin.y-5, 105, 13)];
        
        
        UILabel *addDateLable=[[UILabel alloc]initWithFrame:CGRectMake(17,commentText.frame.size.height+commentText.frame.origin.y, 105, 13)];
        
        //[addDateLable setTextColor:[UIColor blackColor]];
        
        addDateLable.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:10.0f];
        
//        addDateLable.textColor = UIColorFromRGB(0x211e1f);
        addDateLable.textAlignment =NSTextAlignmentLeft;
        addDateLable.textColor = [UIColor blackColor];
        addDateLable.text=[MutDic objectForKey:@"added_date"];
        
    
//        UIView *separetor=[[UIView alloc]initWithFrame:CGRectMake(20, commentText.frame.size.height+commentText.frame.origin.y+20, 280, 1)];
        
        UIView *separetor=[[UIView alloc]initWithFrame:CGRectMake(0, commentText.frame.size.height+commentText.frame.origin.y+20, 320, .5)];
        
        [separetor setBackgroundColor:[UIColor blackColor]];
        separetor.layer.opacity = 0.5f;
        
        [cellBackView addSubview:separetor];
        
        [cellBackView setFrame:CGRectMake(0, ipos, 320, separetor.frame.origin.y+1)];
        
        [cellBackView addSubview:separetor];
        
        [cellBackView addSubview:addDateLable];
        
        [pushContainScroll addSubview:cellBackView];
        
        pushContainScroll.contentSize=CGSizeMake(320, cellBackView.frame.size.height-10+(cellBackView.frame.size.height*i));
        
        i++;
        
        ipos+=cellBackView.frame.size.height;
        
    }
    
        [pushnotiFicationHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
