//
//  MainClass.m
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 05/11/13.
//  Copyright (c) 2013 Esolz Tech. All rights reserved.
//

/*
 
 Caution
 
 Change in this class may harm your entire project. So be carefull before take any kind of action. Thankyou
 
 */

#import "HelperClass.h"
#import "MTActivityIndicatorView.h"
#import <QuartzCore/CoreAnimation.h>
#import "RecordAudioViewController.h"
#import "AppDelegate.h"




@implementation HelperClass
{
    MTActivityIndicatorView *aiv;
    NSTimer *timer;
    NSTimeInterval updatedtimeintervali;
}

@synthesize VehicleMake             = VehicleMake;
@synthesize VehicleModel            = VehicleModel;
@synthesize VehicleUnique           = VehicleUnique;
@synthesize VihicleYear             = VihicleYear;
@synthesize isVehicleDescComplete   = isVehicleDescComplete;
@synthesize isLicencePlateComplete  = isLicencePlateComplete;
@synthesize isReportDescComplete    = isReportDescComplete;
@synthesize isReportTitleComplete   = isReportTitleComplete;
@synthesize isVehicleImageComplete  = isVehicleImageComplete;
@synthesize isVehiclelocComplete    = isVehiclelocComplete;
@synthesize ReportTitle             = ReportTitle;
@synthesize ReportDesc              = ReportDesc;
@synthesize ReportImage             = ReportImage;
@synthesize ReportPlate             = ReportPlate;
@synthesize ReposrLocation          = ReposrLocation;
@synthesize ReportTotalUploadedimage= ReportTotalUploadedimage;
@synthesize ReportImageOne          = ReportImageOne;
@synthesize delegate                = _delegate;
@synthesize UserDeviceToken         = UserDeviceToken;

static HelperClass *instance =nil;

-(id)initWithSaveVehicleDescDataForReport:(NSString *)VehicleMakeVal VehicleModel:(NSString *)VehicleModelVal VihicleYear:(NSString *)VihicleYearVal VehicleUnique:(NSString *)VehicleUniqueVal
{
    self=[super init];
    if(self) {
        
        [self setVehicleMake:VehicleMakeVal];
        [self setVehicleModel:VehicleModelVal];
        [self setVehicleUnique:VehicleUniqueVal];
        [self setVihicleYear:VihicleYearVal];
        
    }
    return self;
}

#pragma mark - Url Link Delegate

- (void)getValueFromURL:(NSString *)url {
   // NSLog(@"I have being called");
    dispatch_queue_t fetchQ = dispatch_queue_create("Pulling", NULL);
    dispatch_async(fetchQ, ^{
        
        NSError *error;
        NSData *dataURL     =  [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
        NSDictionary* json  = [NSJSONSerialization JSONObjectWithData:dataURL options:kNilOptions error:&error];
        
        [self jobCompleted:(NSDictionary *)json];
        
    });
}

- (void)jobCompleted:(NSDictionary *)json {
    [_delegate HelperClassProtocolRequiredMethod:self ObjCarier:(NSDictionary *)json];
}

#pragma mark - Text Field Delegate

+(void)initWithUserDeviceToken:(NSString *)UserDeviceToken {
    
   // NSLog(@"UserDeviceToken ----in helper object- %@",UserDeviceToken);
    id obj = [[self alloc] init];
    if(obj) {
        [obj setUserDeviceToken:UserDeviceToken];
    }
}
-(void)RegisterDeviceForRemoteNotifiction :(int)BadgeNumber cancelLocalNotification:(BOOL)cancelLocalNotification {
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = BadgeNumber;
    
    if(cancelLocalNotification)
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}
+(void)SaveVehicleDescDataForReport:(NSString *)VehicleMakeVal VehicleModel:(NSString *)VehicleModelVal VihicleYear:(NSString *)VihicleYearVal VehicleUnique:(NSString *)VehicleUniqueVal {
    
    id obj = [[self alloc] init];
    if (obj) {
        [obj setVehicleMake:VehicleMakeVal];
        [obj setVehicleModel:VehicleModelVal];
        [obj setVehicleUnique:VehicleUniqueVal];
        [obj setVihicleYear:VihicleYearVal];
    }
}

+(HelperClass *)SaveVehicleDescDataForReport {
    @synchronized(self) {
        if(instance==nil) {
            instance= [HelperClass new];
        }
    }
    return instance;
}

//+(id)SaveVehicleDescDataForReport:(NSString *)VehicleMakeVal VehicleModel:(NSString *)VehicleModelVal VihicleYear:(NSString *)VihicleYearVal VehicleUnique:(NSString *)VehicleUniqueVal
//{
//    id obj = [[self alloc] init];
//    if (obj) {
//        
//        [obj setVehicleMake:VehicleMakeVal];
//        [obj setVehicleModel:VehicleModelVal];
//        [obj setVehicleUnique:VehicleUniqueVal];
//        [obj setVihicleYear:VihicleYearVal];
//
//    }
//    return obj;
//}

/* Go To the page without Parameter */

-(void)GoToThepageWithoutParameter
{
    
}

/* Create background With Color */

-(void)SetViewBackgroundColor:(UIView *)MainView color:(UIColor *)ColorName
{
    [MainView setBackgroundColor:ColorName];
}

/* Create Label With Value */




-(void)CreatelabelWithValue: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color textcolor:(UIColor *)Textcolor labeltext:(NSString *)LabelText fontName:(NSString *)FontName fontSize:(Size)FontSize addView:(UIView *)AddToView
{
    UILabel *Iam = [[UILabel alloc] initWithFrame:CGRectMake(Xcord, Ycord, Width, Height)];
    Iam.text = LabelText;
    Iam.backgroundColor = Color;
    Iam.font = [UIFont fontWithName:FontName size:FontSize];
    Iam.textColor = Textcolor;
    Iam.numberOfLines = 0;
    //Iam.lineBreakMode = NSLineBreakByWordWrapping;
    Iam.textAlignment = NSTextAlignmentCenter;
    [AddToView addSubview:Iam];
}

/* Create Label With Value */

-(void)CreatelabelWithValueCenter: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color textcolor:(UIColor *)Textcolor labeltext:(NSString *)LabelText fontName:(NSString *)FontName fontSize:(Size)FontSize addView:(UIView *)AddToView
{
    UILabel *Iam = [[UILabel alloc] initWithFrame:CGRectMake(Xcord, Ycord, Width, Height)];
    Iam.text = LabelText;
    Iam.backgroundColor = Color;
    Iam.font = [UIFont fontWithName:FontName size:FontSize];
    Iam.textColor = Textcolor;
    Iam.numberOfLines = 0;
    Iam.lineBreakMode = NSLineBreakByWordWrapping;
    Iam.textAlignment = NSTextAlignmentLeft;
    [AddToView addSubview:Iam];
}

/* Create Button With image ... Action */

-(void)CreateButtonWithValue: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color textcolor:(UIColor *)Textcolor labeltext:(NSString *)LabelText fontName:(NSString *)FontName fontSize:(Size)FontSize imageNameForUIControlStateNormal:(NSString *)ImageForUIControlStateNormal imageNameForUIControlStateSelected:(NSString *)ImageForUIControlStateSelected imageNameForUIControlStateHighlighted:(NSString *)ImageForUIControlStateHighlighted imageNameForselectedHighlighted:(NSString *)ImageForselectedHighlighted selectMethod:(SEL)SelectMethod selectEvent:(UIControlEvents)SelectEvent addView:(UIView *)AddToView viewController:(UIViewController *)ViewController
{
    
    UIButton *Recutng = [UIButton buttonWithType:UIButtonTypeCustom];
    Recutng.frame = CGRectMake(Xcord, Ycord, Width, Height);
    [Recutng setBackgroundImage:[UIImage imageNamed:ImageForUIControlStateNormal] forState:UIControlStateNormal];
    [Recutng setBackgroundImage:[UIImage imageNamed:ImageForUIControlStateSelected] forState:UIControlStateSelected];
    [Recutng setBackgroundImage:[UIImage imageNamed:ImageForselectedHighlighted] forState:UIControlStateHighlighted];
    [Recutng setBackgroundImage:[UIImage imageNamed:ImageForUIControlStateHighlighted] forState:UIControlStateSelected | UIControlStateHighlighted];
    [Recutng addTarget:ViewController action:SelectMethod forControlEvents:SelectEvent];
    [AddToView addSubview:Recutng];
    
}

/* Create Button With text ... Action */

-(void)CreateButtonWithText: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color textcolor:(UIColor *)Textcolor labeltext:(NSString *)LabelText fontName:(NSString *)FontName fontSize:(Size)FontSize textNameForUIControlStateNormal:(NSString *)TextForUIControlStateNormal textNameForUIControlStateSelected:(NSString *)TextForUIControlStateSelected textNameForUIControlStateHighlighted:(NSString *)TextForUIControlStateHighlighted textNameForselectedHighlighted:(NSString *)TextForselectedHighlighted selectMethod:(SEL)SelectMethod selectEvent:(UIControlEvents)SelectEvent addView:(UIView *)AddToView viewController:(UIViewController *)ViewController
{
    UIButton *SignUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SignUp.frame = CGRectMake(Xcord, Ycord, Width, Height);
    [SignUp setBackgroundColor:Color];
    [SignUp setTitle:TextForUIControlStateNormal forState:UIControlStateNormal];
    [SignUp setTitle:TextForUIControlStateSelected forState:UIControlStateSelected];
    [SignUp setTitle:TextForselectedHighlighted forState:UIControlStateHighlighted];
    [SignUp setTitleColor:Textcolor forState:UIControlStateNormal];
    [SignUp setTitleColor:Textcolor forState:UIControlStateSelected];
    [SignUp setTitleColor:Textcolor forState:UIControlStateHighlighted];
    SignUp.layer.borderColor = UIColorFromRGB(0xc5c5c5).CGColor;
    [SignUp addTarget:ViewController action:SelectMethod forControlEvents:SelectEvent];
    [AddToView addSubview:SignUp];
}

- (UITextField *)CrateTextField: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color backGroundImage:(NSString *)BackGroundImageName textcolor:(UIColor *)Textcolor palceholdertext:(NSString *)PlaceholderText fontName:(NSString *)FontName fontSize:(Size)FontSize Secure:(BOOL)Sucure addView:(UIView *)AddToView viewController:(UIViewController *)ViewController delegate:(id<UITextFieldDelegate>)Delegate textfieldName:(UITextField *)TextFieldName
{
    UIView *lftVwenew5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 32.5f)];
    lftVwenew5.backgroundColor = [UIColor clearColor];
    
    TextFieldName = [[UITextField alloc] initWithFrame:CGRectMake(Xcord, Ycord, Width, Height)];
    [TextFieldName setBackground:[UIImage imageNamed:BackGroundImageName]];
    TextFieldName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    TextFieldName.font = [UIFont systemFontOfSize:FontSize];
    TextFieldName.placeholder = PlaceholderText;
    TextFieldName.delegate = Delegate;
    if(Sucure)
        [TextFieldName setSecureTextEntry:YES];
    [TextFieldName setValue:Textcolor forKeyPath:@"_placeholderLabel.textColor"];
    [TextFieldName setValue:[UIFont fontWithName:FontName size:FontSize] forKeyPath:@"_placeholderLabel.font"];
    [TextFieldName setDelegate:Delegate];
    TextFieldName.leftView = lftVwenew5;
    TextFieldName.leftViewMode = UITextFieldViewModeAlways;
    [AddToView addSubview:TextFieldName];
    return TextFieldName;
}

/* Create Imageview With Image */

-(void)CreateImageviewWithImage:(UIView *)MainView xcord:(float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color imageName:(NSString *)ImageName
{
    UIImageView *KingQuen = [[UIImageView alloc] initWithFrame:CGRectMake(Xcord, Ycord, Width, Height)];
    KingQuen.image = [UIImage imageNamed:ImageName];
    KingQuen.backgroundColor = Color;
    [MainView addSubview:KingQuen];
}

/* Create background With Image */

-(void)SetViewBackgroundImage:(UIView *)MainView imageName:(NSString *)Imagename
{
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:Imagename]]];
}

-(void)CreateUiview:(UIView *)MainView xcord:(float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color imageName:(NSString *)ImageName viewcolor:(UIColor *)ViewColor
{
    UIView *navBarView = [[UIView alloc] initWithFrame:CGRectMake(Xcord, Ycord, Width, Height)];
    [navBarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:ImageName]]];
    MainView.backgroundColor = Color;
    [MainView addSubview:navBarView];
}

//-(void)ApplicatinRegisterForRemotenotification
//{
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//}

-(NSString *)CleanTextField:(NSString *)TextfieldName
{
    NSString *Cleanvalue = [TextfieldName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return Cleanvalue;
}

-(BOOL)ValidateEmail:(NSString *)EmailValue
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    NSString* CleanEmailValue = [self CleanTextField:EmailValue];

    if([emailTest evaluateWithObject:CleanEmailValue] == NO)
        return YES;
    else
        return NO;
}

-(BOOL)ValidateSpecialCharacter:(NSString *)DataValue
{
    NSCharacterSet *ALLOWEDCHARATERSET =[[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSString *Cleanvalue = [self CleanTextField:DataValue];
    if ([Cleanvalue rangeOfCharacterFromSet:ALLOWEDCHARATERSET].location != NSNotFound)
        return NO;
    else
        return YES;
}

-(BOOL)validatePhone:(NSString*)phone {
    if ([phone length] < 10) {
        return NO;
    }
    NSString *phoneRegex = @"^[0-9]{3}-[0-9]{3}-[0-9]{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return ![test evaluateWithObject:phone];
}

-(void)SetupHeaderViewWithCustomButton:(UIView *)AddToView viewController:(UIViewController *)ViewController hideLeftButton:(BOOL)hideLeftButton hiderightButton:(BOOL)hiderightButton leftButtonCustom:(BOOL)leftButtonCustom rightButtonCustom:(BOOL)rightButtonCustom leftButtonText:(NSString *)leftButtonText rightButtonText:(NSString *)rightButtonText LeftButtonImgae:(NSString *)LeftButtonImgae RightButtonImgae:(NSString *)RightButtonImgae LeftButtonMethod:(SEL)LeftButtonMethod RightButtonMethod:(SEL)RightButtonMethod {
    
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    HeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320/3,5)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [HeaderView addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 0, 320/3,5)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [HeaderView addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 0, 320/3+5,5)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [HeaderView addSubview:redlabel];
    
    [self CreateButtonWithValue:10 ycord:25 width:24 height:24 backgroundColor:[UIColor clearColor] textcolor:[UIColor clearColor] labeltext:Nil fontName:Nil fontSize:0 imageNameForUIControlStateNormal:@"colps_pic@2x" imageNameForUIControlStateSelected:@"colps_pic@2x" imageNameForUIControlStateHighlighted:@"colps_pic@2x" imageNameForselectedHighlighted:@"colps_pic@2x" selectMethod:@selector(leftSideMenuButtonPressed:) selectEvent:UIControlEventTouchUpInside addView:HeaderView viewController:ViewController];
    
    [self CreateButtonWithValue:285 ycord:25 width:24 height:24 backgroundColor:[UIColor clearColor] textcolor:[UIColor clearColor] labeltext:Nil fontName:Nil fontSize:0 imageNameForUIControlStateNormal:@"DELETE" imageNameForUIControlStateSelected:@"DELETE" imageNameForUIControlStateHighlighted:@"DELETE" imageNameForselectedHighlighted:@"DELETE" selectMethod:RightButtonMethod selectEvent:UIControlEventTouchUpInside addView:HeaderView viewController:ViewController];
    
    [self CreateImageviewWithImage:HeaderView xcord:100 ycord:25 width:100 height:25 backgroundColor:[UIColor clearColor] imageName:GLOBALLOGOIMAGE];
    
    //HeaderView.layer.zPosition = 999999999;
    HeaderView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    HeaderView.layer.shadowOpacity = 0.9;
    
    [AddToView addSubview:HeaderView];
}

-(void)SetupHeaderViewForReport:(UIView *)AddToView viewController:(UIViewController *)ViewController {
    
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    HeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320/3,5)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [HeaderView addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 0, 320/3,5)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [HeaderView addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 0, 320/3+5,5)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [HeaderView addSubview:redlabel];
    
    [self CreateButtonWithValue:10 ycord:25 width:24 height:24 backgroundColor:[UIColor clearColor] textcolor:[UIColor clearColor] labeltext:Nil fontName:Nil fontSize:0 imageNameForUIControlStateNormal:@"menu.png" imageNameForUIControlStateSelected:@"colps_pic@2x" imageNameForUIControlStateHighlighted:@"menu.png" imageNameForselectedHighlighted:@"menu.png" selectMethod:@selector(leftSideMenuButtonPressed:) selectEvent:UIControlEventTouchUpInside addView:HeaderView viewController:ViewController];
    
    [self CreateButtonWithValue:285 ycord:25 width:24 height:24 backgroundColor:[UIColor clearColor] textcolor:[UIColor clearColor] labeltext:Nil fontName:Nil fontSize:0 imageNameForUIControlStateNormal:@"CNCLDATA" imageNameForUIControlStateSelected:@"CNCLDATA" imageNameForUIControlStateHighlighted:@"CNCLDATA" imageNameForselectedHighlighted:@"CNCLDATA" selectMethod:@selector(FinalCancel:) selectEvent:UIControlEventTouchUpInside addView:HeaderView viewController:ViewController];
    
    [self CreateImageviewWithImage:HeaderView xcord:100 ycord:25 width:100 height:25 backgroundColor:[UIColor clearColor] imageName:GLOBALLOGOIMAGE];
    
    HeaderView.layer.zPosition = 999999999;
    HeaderView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    HeaderView.layer.shadowOpacity = 0.9;
    
    [AddToView addSubview:HeaderView];
}

-(void)SetupHeaderView:(UIView *)AddToView viewController:(UIViewController *)ViewController {
    
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    HeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320/3,1.5)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [HeaderView addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 0, 320/3,1.5)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [HeaderView addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 0, 320/3+5,1.5)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [HeaderView addSubview:redlabel];
    
    [self CreateButtonWithValue:10 ycord:18 width:30 height:30 backgroundColor:[UIColor clearColor] textcolor:[UIColor clearColor] labeltext:Nil fontName:Nil fontSize:0 imageNameForUIControlStateNormal:@"menu.png" imageNameForUIControlStateSelected:@"menu.png" imageNameForUIControlStateHighlighted:@"menu.png" imageNameForselectedHighlighted:@"menu.png" selectMethod:@selector(leftSideMenuButtonPressed:) selectEvent:UIControlEventTouchUpInside addView:HeaderView viewController:ViewController];
    
    [self CreateButtonWithValue:285 ycord:15 width:30 height:30 backgroundColor:[UIColor clearColor] textcolor:[UIColor clearColor] labeltext:Nil fontName:Nil fontSize:0 imageNameForUIControlStateNormal:@"settings 2.png" imageNameForUIControlStateSelected:@"settings 2.png" imageNameForUIControlStateHighlighted:@"settings 2.png" imageNameForselectedHighlighted:@"settings 2.png" selectMethod:@selector(rightSideMenuButtonPressed:) selectEvent:UIControlEventTouchUpInside addView:HeaderView viewController:ViewController];
    
    [self CreateImageviewWithImage:HeaderView xcord:100 ycord:18 width:100 height:25 backgroundColor:[UIColor clearColor] imageName:GLOBALLOGOIMAGE];
    
    HeaderView.layer.zPosition = 999999999;
    HeaderView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    HeaderView.layer.shadowOpacity = 0.9;
    
    [AddToView addSubview:HeaderView];
}

-(NSDictionary *)executeFetch:(NSString *)query
{
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    return results;
}

-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType
{
    NSMutableString *URLstring = [[NSMutableString alloc]init];
    
    int i=0;
    for (id key in TotalData) {
        
        i++;
        id anObject = [TotalData objectForKey:key];
        if(i==TotalData.count)
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@",key,[[self CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        else
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@&",key,[[self CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    NSString *FinalString = [NSString stringWithFormat:@"%@%@?%@",DomainURL,UrlType,URLstring];
    return FinalString;
    
}

-(void)AddBlackOverlay:(UIView *)MainView xcord:(float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color OpacitY:(float)OpacitY Text:(NSString *)Text TextColor:(UIColor *)TextColor FontName:(NSString *)FontName FontSize:(Size)FontSize IsTextEnabled:(BOOL)IsTextEnabled
{
    LayoutVew =[[UIView alloc] initWithFrame:CGRectMake(Xcord, Ycord, Width, Height)];
    LayoutVew.backgroundColor = Color;
    LayoutVew.layer.opacity = OpacitY;
    [MainView addSubview:LayoutVew];
    
    UILabel *greenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320/3,5)];
    greenLabel.backgroundColor = UIColorFromRGB(0x1aad4b);
    [LayoutVew addSubview:greenLabel];
    
    UILabel *yellowlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3, 0, 320/3,5)];
    yellowlabel.backgroundColor = UIColorFromRGB(0xfcb714);
    [LayoutVew addSubview:yellowlabel];
    
    UILabel *redlabel = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, 0, 320/3+5,5)];
    redlabel.backgroundColor = UIColorFromRGB(0xde1d23);
    [LayoutVew addSubview:redlabel];
    
    UILabel *greenLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, Height-5, 320/3,5)];
    greenLabel1.backgroundColor = UIColorFromRGB(0x1aad4b);
    [LayoutVew addSubview:greenLabel1];
    
    UILabel *yellowlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(320/3, Height-5, 320/3,5)];
    yellowlabel1.backgroundColor = UIColorFromRGB(0xfcb714);
    [LayoutVew addSubview:yellowlabel1];
    
    UILabel *redlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(320/3*2, Height-5, 320/3+5,5)];
    redlabel1.backgroundColor = UIColorFromRGB(0xde1d23);
    [LayoutVew addSubview:redlabel1];
    
    if(IsTextEnabled) {
        UILabel *Iam = [[UILabel alloc] initWithFrame:CGRectMake(20, MainView.frame.size.height/2, 120, 20)];
        Iam.text = Text;
        Iam.backgroundColor = [UIColor clearColor];
        Iam.font = [UIFont fontWithName:FontName size:FontSize];
        Iam.textColor = TextColor;
        Iam.textAlignment = NSTextAlignmentLeft;
        [LayoutVew addSubview:Iam];
    }
    
    [self SetLoader:LayoutVew xcord:120 ycord:MainView.frame.size.height/2 + 7 width:globalLOGOWIDTH - 40 height:globalLOGOHEIGHT backgroundColor:[UIColor clearColor] imageName:nil viewcolor:[UIColor clearColor] animationDuration:1.0f dotColor:globalACTIVITYDOTCOLOR animationStatus:YES];
    
}

-(void)HidePopupView {
    [LayoutVew removeFromSuperview];
}
- (NSString *) stripTags:(NSString *)s
{
    NSRange r;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}
-(void)SetLoader:(UIView *)mainview xcord:(float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color imageName:(NSString *)ImageName viewcolor:(UIColor *)ViewColor animationDuration:(float)AnimationDuration dotColor:(UIColor *)DotColor animationStatus:(BOOL)AnimationStatus
{
    if(AnimationStatus == YES) {
        aiv = [[MTActivityIndicatorView alloc] initWithFrame:CGRectMake(Xcord, Ycord, Width, Height)];
        aiv.animationDuration = AnimationDuration;
        aiv.dotColor = UIColorFromRGB(0xde1d23);
        [aiv startAnimating];
        [mainview addSubview:aiv];
    } else {
        [aiv stopAnimating];
        [aiv removeFromSuperview];
    }
}

-(CATransition *)AddAnimationOnView
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    return transition;
}

-(BOOL)validatePassword:(NSString*)password Minrange:(int)MINRANGE Maxrange:(int)MAXRANGE {
  
    if ([password length] < MINRANGE || [password length] > MAXRANGE)
        return NO;
    else
        return YES;
}

@end
