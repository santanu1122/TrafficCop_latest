#import "EditProfileViewController.h"
#import "MFSideMenu.h"
#import "MBHUDView.h"
#import "ZSImageView.h"
#import "AppDelegate.h"
@interface EditProfileViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSString *userID;
//    UIImageView *ProfilePIcImageView;
    NSOperationQueue *operationQ;
    NSString *MassAge;
    ZSImageView *imageView;
}
//@property (nonatomic, strong) UITextField *FistName;
//@property (nonatomic, strong) UITextField *LastName;
//@property (nonatomic, strong) UITextField *Email;
//@property (nonatomic, strong) UITextField *Username;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *EditprofileActivity;
@property (strong, nonatomic) IBOutlet UITextField *FistName;
@property (strong, nonatomic) IBOutlet UITextField *LastName;
@property (strong, nonatomic) IBOutlet UITextField *Email;
@property (strong, nonatomic) IBOutlet UITextField *Username;
@property (strong, nonatomic) IBOutlet UIImageView *ProfilePIcImageView;
@property (strong, nonatomic) IBOutlet UILabel *editProfile;
@property (strong, nonatomic) IBOutlet UIScrollView *EditProfileScroll;




@end

@implementation EditProfileViewController
@synthesize whiteBackView;
@synthesize EditProfileScroll = _EditProfileScroll;
@synthesize FistName;
@synthesize LastName;
@synthesize Email;
@synthesize Username;
@synthesize EditprofileActivity;
@synthesize ProfilePIcImageView;
@synthesize editProfile;
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
    
    [self HideNavigationBar];
    [EditprofileActivity setHidden:YES];
    
     EditProfHelper = [[HelperClass alloc] init];
     operationQ=[[NSOperationQueue alloc]init];
    
    imageView = [[ZSImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
	imageView.defaultImage = [UIImage imageNamed:@"FH-noimage-circle"];
	imageView.imageUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_image"];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self SetroundborderWithborderWidth:2.0f WithColour:UIColorFromRGB(0xc9c9c9) ForImageviewZS:imageView];
    [self.ProfilePIcImageView addSubview:imageView];
    
    [self.ProfilePIcImageView setImage:[UIImage imageNamed:@"FH-noimage-circle"]];

    
    
    
    [EditProfHelper SetViewBackgroundImage:self.view imageName:GLOBALBACKGROUND];
    NSUserDefaults *userDetail=[NSUserDefaults standardUserDefaults];
    userID=[userDetail valueForKey:@"userid"];
    
    // Assigning scrollview property
    
    _EditProfileScroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + self.view.frame.size.height/4);
    _EditProfileScroll.scrollEnabled = YES;
    _EditProfileScroll.delegate = self;
    _EditProfileScroll.backgroundColor = [UIColor clearColor];
    _EditProfileScroll.userInteractionEnabled = YES;
    
//    self.whiteBackView.layer.cornerRadius=10.0f;
//    self.whiteBackView.layer.borderWidth=1.0f;
//    self.whiteBackView.layer.borderColor=[UIColor whiteColor].CGColor;
//    self.whiteBackView.backgroundColor=UIColorFromRGB(0xffffff);
    [EditProfHelper SetupHeaderView:self.view viewController:self];
    
    editProfile.text=@"Edit Profile";
    
    editProfile.textColor=[UIColor blackColor];
    editProfile.font=[UIFont fontWithName:GLOBALTEXTFONT_Title size:18.0f];
    
    
    
    
 
    
    FistName.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    FistName.delegate=self;
    [FistName addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [FistName addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    
    
    
    LastName.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    LastName.delegate=self;
    [LastName addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [LastName addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    
    Email.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    Email.delegate=self;
    [Email addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [Email addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    Username.font=[UIFont fontWithName:GLOBALTEXTFONT size:12];
    Username.delegate=self;
    [Username addTarget:self action:@selector(textFieldDidBeginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [Username addTarget:self action:@selector(textFieldDidEndEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    
   
   
    
    
    [ProfilePIcImageView setBackgroundColor:[UIColor clearColor]];
    [self SetroundborderWithborderWidth:2.0f WithColour:UIColorFromRGB(0xc9c9c9) ForImageview:ProfilePIcImageView];
    
    
    [EditProfHelper CreateButtonWithText:110 ycord:445 width:100 height:21 backgroundColor:UIColorFromRGB(0x1aad4b) textcolor:[UIColor whiteColor] labeltext:@"Save" fontName:@"System" fontSize:11 textNameForUIControlStateNormal:@"Save" textNameForUIControlStateSelected:@"Save" textNameForUIControlStateHighlighted:@"Save" textNameForselectedHighlighted:@"Save" selectMethod:@selector(SaveupdatedInfo:) selectEvent:UIControlEventTouchUpInside addView:self.EditProfileScroll viewController:self];
    
    
    NSLog(@"User details is %@",userDetail);
    FistName.text=[userDetail valueForKey:@"first_name"];
    LastName.text=[userDetail valueForKey:@"last_name"];
    Email.text=[userDetail valueForKey:@"email"];
    Username.text=[userDetail valueForKey:@"username"];
    NSString *urlStr=[userDetail valueForKey:@"user_image"];
    NSLog(@"URL str is %@",urlStr);
   
    UIImageView *ImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(191, 344, 70, 70)];
    [ImageOverlay setImage:[UIImage imageNamed:@"out-line.png"]];
    [_EditProfileScroll addSubview:ImageOverlay];
    
}
-(IBAction)SaveupdatedInfo:(id)sender
{
    
    NSLog(@"The Change user Details:");
    [self ChangetheDetails];
}


-(void)ChangetheDetails
{
    
    BOOL ChekeEdit=YES;
    NSString *trimmedusremail = [[self.Email text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if(![trimmedusremail length]>0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter your email..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        ChekeEdit=NO;
        return;
    }
    
    if([trimmedusremail length]>0)
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:Email.text] == NO)
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Enter a valid Email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            ChekeEdit=NO;
            return;
        }
    }
    if ([EditProfHelper CleanTextField:Username.text].length<5) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"User name should have minimum 4 character" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if ([EditProfHelper CleanTextField:FistName.text].length<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"First name can't left blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if ([EditProfHelper CleanTextField:LastName.text].length<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Last name can't left blank" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        ChekeEdit=NO;
        return;
    }
    if (ChekeEdit==YES)
    {
        //[self performSelectorOnMainThread:@selector(theActivity) withObject:nil waitUntilDone:NO];
        [EditprofileActivity startAnimating];
        
        
        NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(UploadImageinthread) object:nil];
        [operationQ addOperation:operation];
        
        
        
        
        
        
    }
    
}

-(void)UploadImageinthread
{
    NSString *Stringurl=[NSString stringWithFormat:@"%@userid=%@&mode=edit_account&email=%@&username=%@&first_name=%@&last_name=%@",DemoProfile,userID,[[EditProfHelper CleanTextField:self.Email.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[EditProfHelper CleanTextField:self.Username.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[EditProfHelper CleanTextField:self.FistName.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[EditProfHelper CleanTextField:self.LastName.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"The change profile Details:%@",Stringurl);
    // exit(0);
    
    NSData *imageData = UIImageJPEGRepresentation(ProfilePIcImageView.image, 0.6);
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:Stringurl]];
    [request setHTTPMethod:@"POST"];
    
    if(imageData > 0) {
        
        
        NSLog(@"the data formetnotupdate Successfully");
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_image\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];	[request setHTTPBody:body];
        
    }
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *MainDic=[NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
    NSLog(@"main dic:%@",MainDic);
    MassAge=[MainDic valueForKey:@"message"];
    [self performSelectorOnMainThread:@selector(DoneUpload) withObject:nil waitUntilDone:YES];
    
}
-(void)DoneUpload
{
    [EditprofileActivity stopAnimating];
    [EditprofileActivity setHidden:YES];
    //    [EditProfHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:NO];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:MassAge delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)SetroundborderWithborderWidth:(CGFloat)BorderWidth WithColour:(UIColor *)RGB ForImageviewZS:(ZSImageView *)ImageView
{
    
    [[ImageView layer] setCornerRadius:[ImageView frame].size.width/2.0f];
    [[ImageView layer] setBorderColor:[RGB CGColor]];
    [[ImageView layer] setBorderWidth:BorderWidth];
    [[ImageView layer] setMasksToBounds:YES];
    
}
- (void)textFieldDidEndEditing {
    [UIView animateWithDuration:.25 animations:^{
        _EditProfileScroll.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)textFieldDidBeginEditing {
    [_EditProfileScroll setContentOffset:CGPointMake(0, 50) animated:YES];
}
- (void)textFieldDidBeginEditingone {
    [UIView animateWithDuration:.25 animations:^{
        _EditProfileScroll.contentOffset = CGPointMake(0, 120);
    }];
}
//-(IBAction)SaveupdatedInfo:(id)sender
//{
//    
//    NSLog(@"The Change user Details:");
////    [self ChangetheDetails];
//}


-(void)theActivity
{
    [EditProfHelper SetLoader:self.view xcord:80 ycord:self.view.frame.size.height/2+self.view.frame.size.height/4 width:globalLOGOWIDTH height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
}

#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:.25 animations:^{
        _EditProfileScroll.contentOffset = CGPointMake(0, 0);
    }];
    [textField resignFirstResponder];
    return YES;
}
-(void)choseaPhoto {
    MBAlertView *destruct = [MBAlertView alertWithBody:@"Select my picture from" cancelTitle:nil cancelBlock:nil];
    destruct.imageView.image = [UIImage imageNamed:@"image.png"];
    [destruct addButtonWithText:@"Album" type:MBAlertViewItemTypeDestructive block:^{
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        //[self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }];
    [destruct addButtonWithText:@"Camera" type:MBAlertViewItemTypeDestructive block:^{
#if TARGET_IPHONE_SIMULATOR
        {
            MBAlertView *aler = [MBAlertView alertWithBody:@"Device doesnot support camera,Select my picture from album?" cancelTitle:@"Cancel" cancelBlock:nil];
            [aler addButtonWithText:@"Yes" type:MBAlertViewItemTypeDestructive block:^{
                NSLog(@"Get Image From Album");
                UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self presentViewController:picker animated:YES completion:nil];
                //[self presentModalViewController:picker animated:YES];
            }];
            [aler addToDisplayQueue];
        }
#else
        {
            UIImagePickerController * pickerone = [[UIImagePickerController alloc] init];
            pickerone.delegate = self;
            pickerone.allowsEditing = YES;
            pickerone.sourceType = UIImagePickerControllerSourceTypeCamera;
            //self.saveButton.enabled = YES;
            [self presentModalViewController:pickerone animated:YES];
        }
#endif
    }];
    [destruct addToDisplayQueue];
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
//    UIImage* originalImage = nil;
//    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    if(originalImage==nil)
//    {
//        NSLog(@"image picker original");
//        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    } else {
//        
//        NSLog(@"image picker editedImage");
//    }
//    if(originalImage==nil)
//    {
//        NSLog(@"image picker croprect");
//        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
//    }
//    [ProfilePIcImageView setImage:originalImage];
//}
//
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - UIBarButtonItem Callbacks

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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)hideKeyboard:(id)sender {
    [(UITextField*)sender resignFirstResponder];
}
-(IBAction)movetozero:(id)sender {
    [(UITextField*)sender resignFirstResponder];
    [_EditProfileScroll setContentOffset:CGPointZero animated:YES];
}
-(IBAction)movetotop:(id)sender {
    [_EditProfileScroll setContentOffset:CGPointMake(0, 100) animated:YES];
}
-(IBAction)movetotopone:(id)sender {
    [_EditProfileScroll setContentOffset:CGPointMake(0, 150) animated:YES];
}
-(void)SetroundborderWithborderWidth:(CGFloat)BorderWidth WithColour:(UIColor *)RGB ForImageview:(UIImageView *)ImageView
{
    
    [[ImageView layer] setCornerRadius:[ImageView frame].size.width/2.0f];
    [[ImageView layer] setBorderColor:[RGB CGColor]];
    [[ImageView layer] setBorderWidth:BorderWidth];
    [[ImageView layer] setMasksToBounds:YES];
    
}
- (IBAction)changePhotoAction:(id)sender {
    [self openActionSheet];
}
-(void)openActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Choose your option"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Take a Snap", @"Choose From Library", nil];
    [actionSheet showInView:self.view];
}
-(void)takeSnap{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
-(void)chooseFromLibrary{
    UIImagePickerController  *eImagePickerController = [[UIImagePickerController alloc] init];
    [eImagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    eImagePickerController.delegate = self;
    [self presentViewController:eImagePickerController animated:YES completion:nil];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Button Index %d",buttonIndex);
    if(buttonIndex==0){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"This  is satisfied camera exist");
            [self takeSnap];
        }
        else{
            NSLog(@"This  is satisfied camera not exist");
            UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You don't have a camera for this device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           
            [noCameraAlert show];
            
        }
    }
    
    if(buttonIndex==1){
        NSLog(@"We are at here");
        
           [self chooseFromLibrary];
        }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    UIImage* originalImage = nil;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(originalImage==nil)
    {
        NSLog(@"image picker original");
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    } else {
        
        NSLog(@"image picker editedImage");
    }
    if(originalImage==nil)
    {
        NSLog(@"image picker croprect");
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    
    imageView.imageView.image=originalImage;
    self.ProfilePIcImageView.image=originalImage;
//    [self.EditProfileScroll bringSubviewToFront:ProfilePIcImageView];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
     NSLog(@"Image cancelled called");
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
