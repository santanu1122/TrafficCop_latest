//
//  EvedenceLockerView.m
//  TrafficCop
//
//  Created by macbook_ms on 11/02/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "EvedenceLockerView.h"
#import "CellForevidenceLockerCell.h"
#import "AppDelegate.h"
#import "MFSideMenu.h"
#import "reportDetaiswithlicenceplate.h"

@interface EvedenceLockerView ()<UIAlertViewDelegate>
{
    NSMutableArray *StoreLicenceplate;
    NSOperationQueue *opration;
    NSString *userID;
    NSString *licenceplate;
    NSInteger deletItemidex;
}
@property (strong, nonatomic) IBOutlet UIView *headerViewController;
@property (strong, nonatomic) IBOutlet UITableView *EvedenceLockertable;
@property (strong, nonatomic) IBOutlet UIView *noResultFound;
@property (weak, nonatomic) IBOutlet UILabel *EvidenceLockerLbl;

@end

@implementation EvedenceLockerView
@synthesize headerViewController=_headerViewController;
@synthesize EvedenceLockertable =_EvedenceLockertable;

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
    
//    self.navigationController.navigationBar.hidden=YES;
//    self.noResultFound.hidden=YES;
//    _EvedenceLockertable.hidden=YES;
//    NSUserDefaults *userdetas=[NSUserDefaults standardUserDefaults];
//    userID=[userdetas valueForKey:@"userid"];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationController.navigationBar.hidden=YES;
    self.noResultFound.hidden=YES;
    _EvedenceLockertable.hidden=YES;
    NSUserDefaults *userdetas=[NSUserDefaults standardUserDefaults];
    userID=[userdetas valueForKey:@"userid"];
    
    _EvidenceLockerLbl.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0f];
    _EvidenceLockerLbl.textColor = UIColorFromRGB(0x211e1f);
    
    helperAvidence=[[HelperClass alloc]init];
    [helperAvidence SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
      [helperAvidence SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    [helperAvidence SetupHeaderView:self.view viewController:self];
    StoreLicenceplate =[[NSMutableArray alloc]init];
    opration=[[NSOperationQueue alloc]init];
    _EvedenceLockertable.delegate=self;
    _EvedenceLockertable.dataSource=self;
    NSInvocationOperation *operatinForShowplate=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(Showalllicenceplate) object:nil];
    [opration addOperation:operatinForShowplate];
}

-(void)Showalllicenceplate
{
    NSUserDefaults *userDetais=[NSUserDefaults standardUserDefaults];
    NSString *userId=[userDetais valueForKey:@"userid"];
    NSString *licenceurlString=[NSString stringWithFormat:@"%@appweb.php?mode=%@&userid=%@",DomainURL,EVEDENCELOCKERMODE,userId];
    NSLog(@"The licence plate details strring:%@",licenceurlString);
    NSURL *LicencePlareUrl=[NSURL URLWithString:licenceurlString];
    NSData *dataEvedence=[NSData dataWithContentsOfURL:LicencePlareUrl];
    NSDictionary *mainLicenceDic=[NSJSONSerialization JSONObjectWithData:dataEvedence options:kNilOptions error:nil];
    NSArray *ExtraparamArray=[mainLicenceDic objectForKey:@"extraparam"];
    NSDictionary *RespponceDic=[ExtraparamArray objectAtIndex:0];
    NSString *responce=[RespponceDic valueForKey:@"response"];
    
    if ([responce isEqualToString:@"success"])
    {
        NSArray *EvedenceDetaisArry=[mainLicenceDic valueForKey:@"evidancelockerdetails"];
        for (NSDictionary *dic in EvedenceDetaisArry)
        {
            NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]initWithCapacity:3];
            [mutDic setObject:[dic valueForKey:@"licence"] forKey:@"licence"];
            [mutDic setObject:[dic valueForKey:@"totalreport"] forKey:@"totalreport"];
            [mutDic setObject:[dic valueForKey:@"evidance_id"] forKey:@"evidance_id"];
            [StoreLicenceplate addObject:mutDic];
            
            
        }
        
          [self performSelectorOnMainThread:@selector(WhenDataPresent) withObject:Nil waitUntilDone:YES];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(isNodataPresent) withObject:Nil waitUntilDone:YES];
        
    }
    
    
    
}


-(void)isNodataPresent
{
    [helperAvidence SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    [_EvedenceLockertable reloadData];
    self.noResultFound.hidden=NO;
   
}
-(void)WhenDataPresent
{
    self.noResultFound.hidden=YES;
    [helperAvidence SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    _EvedenceLockertable.hidden=NO;
    [_EvedenceLockertable reloadData];
    
}



// UITABLEVIEWDELEGATE IMPLEMANTATION


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [StoreLicenceplate count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //return _headerViewController;
    
    UIView *MainHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 54)];
    MainHeaderView.backgroundColor = [UIColor whiteColor];
    [MainHeaderView addSubview:_headerViewController];
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 52, 320/3,1)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [MainHeaderView addSubview:greenLabel];
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 52, 320/3,1)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [MainHeaderView addSubview:yellowlabel];
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 52, 320/3+5,1)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [MainHeaderView addSubview:redlabel];
    return MainHeaderView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Uitable view cell:%d",indexPath.row);
    static NSString *ReusecellID=@"CellForevidenceLockerCell";
 
    NSMutableDictionary *mutdiction=[StoreLicenceplate objectAtIndex:indexPath.row];
    NSLog(@"The mut dic:%@",mutdiction);
   CellForevidenceLockerCell *cell=(CellForevidenceLockerCell *)[tableView dequeueReusableCellWithIdentifier:ReusecellID];
    if (cell==nil)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:ReusecellID owner:self options:nil];
        cell = (CellForevidenceLockerCell *)[nibArray objectAtIndex:0];
    }
    
     UILabel *Serialno=(UILabel *)[cell.contentView viewWithTag:990];
     Serialno.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
     UILabel *licencePlate=(UILabel *)[cell.contentView viewWithTag:991];
     licencePlate.text=[[mutdiction valueForKey:@"licence"] uppercaseString];
     licencePlate.font = [UIFont fontWithName:GLOBALTEXTFONT_Title size:15.0f];
     licencePlate.textColor = UIColorFromRGB(0x211e1f);
    
    
     UILabel *numborOFreport=(UILabel *)[cell.contentView viewWithTag:992];
     numborOFreport.text=[NSString stringWithFormat:@"%@",[mutdiction valueForKey:@"totalreport"]];
     UIButton *DeleatButton=(UIButton *)[cell.contentView viewWithTag:994];
     [DeleatButton addTarget:self action:@selector(DeleteLicence:) forControlEvents:UIControlEventTouchUpInside];
     DeleatButton.backgroundColor=[UIColor clearColor];
     DeleatButton.tag=indexPath.row;
     UIButton *viewDetaisbutton=(UIButton *)[cell.contentView viewWithTag:993];
    
     [viewDetaisbutton addTarget:self action:@selector(ShowDetails:) forControlEvents:UIControlEventTouchUpInside];
     [viewDetaisbutton setTag:indexPath.row+500];
     UILabel *separetor=[[UILabel alloc]initWithFrame:CGRectMake(0, 59, 320, 0.5f)];
     [separetor setBackgroundColor:[UIColor blackColor]];
     separetor.layer.opacity=.2f;
     [cell.contentView addSubview:separetor];
     return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
}






-(IBAction)DeleteLicence:(UIButton *)sender
{
//   [helperAvidence SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    NSMutableDictionary *mutDic=[StoreLicenceplate objectAtIndex:sender.tag];
    licenceplate=[mutDic valueForKey:@"licence"];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Remove this from Evidence Locker?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [alert show];
    deletItemidex=sender.tag;
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
       
        [helperAvidence SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
        [StoreLicenceplate removeObjectAtIndex:deletItemidex];
        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:deletItemidex inSection:0];
        [_EvedenceLockertable beginUpdates];
        [_EvedenceLockertable deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexpath, nil] withRowAnimation:UITableViewRowAnimationLeft];
        [_EvedenceLockertable endUpdates];
        NSInvocationOperation *operationTodeet=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(addtoevidence) object:nil];
        [opration addOperation:operationTodeet];
    }
}
-(void)addtoevidence
{
    NSString *strAdd;
     strAdd=[NSString stringWithFormat:@"%@appweb.php?mode=delete_evidance_locker&getuser=%@&licence=%@",DomainURL,userID,licenceplate];
    NSLog(@"delete license is %@", strAdd);
    NSURL *Url=[NSURL URLWithString:strAdd];
    NSData *datta=[NSData dataWithContentsOfURL:Url];
    NSDictionary *dicTion=[NSJSONSerialization JSONObjectWithData:datta options:kNilOptions error:nil];
    NSString *message=[dicTion valueForKey:@"message"];
    NSString *responce=[dicTion valueForKey:@"response"];
    
      dispatch_async(dispatch_get_main_queue(), ^{
    
    [helperAvidence SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:responce message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
      });

}

-(IBAction)ShowDetails:(UIButton *)sender
{
    NSMutableDictionary *mutDic=[StoreLicenceplate objectAtIndex:sender.tag-500];
    NSLog(@"sender.tag:%d",sender.tag);
    
//    AppDelegate *mainDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
//    reportDetaiswithlicenceplate *report=[[reportDetaiswithlicenceplate alloc]init];
//    NSLog(@"The value of licence plate:%@",[mutDic valueForKey:@"licence"]);
//    report.Licenceplate=[mutDic valueForKey:@"licence"];
//    [mainDelegate SetUpTabbarControllerwithcenterView:report];
    
    
    reportDetaiswithlicenceplate *report=[[reportDetaiswithlicenceplate alloc]initWithNibName:@"reportDetaiswithlicenceplate" bundle:nil];
    NSLog(@"The value of licence plate:%@",[mutDic valueForKey:@"licence"]);
    report.Licenceplate=[mutDic valueForKey:@"licence"];
    report.backBtnEnableForEvidenceDetails = YES;
    [self.navigationController pushViewController:report animated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)HideNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    opration=nil;
}

@end
