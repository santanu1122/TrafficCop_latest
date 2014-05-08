

//
//  MainClass.h
//  TrafficCop
//
//  Created by Santanu Das Adhikary on 05/11/13.
//  Copyright (c) 2013 Esolz Tech. All rights reserved.
//

@class HelperClass;
//#import <CoreMotion/CoreMotion.h>
@protocol MyObjDelegate <NSObject>

@optional

-(void)HelperClassProtocolOptionalMethod:(HelperClass *)HelperClassObj;

@required

-(void)HelperClassProtocolRequiredMethod:(HelperClass *)HelperClassObj ObjCarier:(NSDictionary *)ObjCarier;

@end


@interface HelperClass : NSObject <UITextFieldDelegate> {
    UIView *LayoutVew;
    __weak id <MyObjDelegate> _delegate;
}

@property (nonatomic,retain) NSString *UserDeviceToken;
//@property (nonatomic, retain) CMMotionManager *motionmanager;

@property (nonatomic, retain) NSString *Id;
@property (nonatomic, retain) NSString *VehicleMake;
@property (nonatomic, retain) NSString *VehicleModel;
@property (nonatomic, retain) NSString *VihicleYear;
@property (nonatomic, retain) NSString *VehicleUnique;
@property (nonatomic, retain) NSString *ReportTitle;
@property (nonatomic, retain) NSString *ReportDesc;
@property (nonatomic, retain) NSString *ReportPlate;
@property (nonatomic, retain) NSString *ReposrLocation;
@property (nonatomic, retain) NSMutableArray *ReportImage;
@property (nonatomic, retain) NSMutableDictionary *ReportImageOne;

@property (nonatomic,weak) id<MyObjDelegate> delegate;

@property (nonatomic,assign) BOOL isReportTitleComplete;
@property (nonatomic,assign) BOOL isReportDescComplete;
@property (nonatomic,assign) BOOL isLicencePlateComplete;
@property (nonatomic,assign) BOOL isVehiclelocComplete;
@property (nonatomic,assign) BOOL isVehicleImageComplete;
@property (nonatomic,assign) BOOL isVehicleDescComplete;

@property (nonatomic,assign) int ReportTotalUploadedimage;

-(void)HidePopupView;
-(void)GoToThepageWithoutParameter;
- (NSString *) stripTags:(NSString *)str;
-(void)SetViewBackgroundColor:(UIView *)MainView color:(UIColor *)ColorName;

+(HelperClass *)SaveVehicleDescDataForReport;
+(void)initWithUserDeviceToken:(NSString *)UserDeviceToken;

- (void)getValueFromURL:(NSString *)url;

-(id)initWithSaveVehicleDescDataForReport:(NSString *)VehicleMakeVal VehicleModel:(NSString *)VehicleModelVal VihicleYear:(NSString *)VihicleYearVal VehicleUnique:(NSString *)VehicleUniqueVal;

-(void)SetViewBackgroundImage:(UIView *)MainView imageName:(NSString *)Imagename;

-(void)CreateUiview:(UIView *)MainView xcord:(float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color imageName:(NSString *)ImageName viewcolor:(UIColor *)ViewColor;

-(void)CreatelabelWithValueCenter: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color textcolor:(UIColor *)Textcolor labeltext:(NSString *)LabelText fontName:(NSString *)FontName fontSize:(Size)FontSize addView:(UIView *)AddToView;

-(void)CreateImageviewWithImage:(UIView *)MainView xcord:(float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color imageName:(NSString *)ImageName;

-(void)CreatelabelWithValue: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color textcolor:(UIColor *)Textcolor labeltext:(NSString *)LabelText fontName:(NSString *)FontName fontSize:(Size)FontSize addView:(UIView *)AddToView;

-(void)SetupHeaderViewForReport:(UIView *)AddToView viewController:(UIViewController *)ViewController;

-(void)CreateButtonWithValue: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color textcolor:(UIColor *)Textcolor labeltext:(NSString *)LabelText fontName:(NSString *)FontName fontSize:(Size)FontSize imageNameForUIControlStateNormal:(NSString *)ImageForUIControlStateNormal imageNameForUIControlStateSelected:(NSString *)ImageForUIControlStateSelected imageNameForUIControlStateHighlighted:(NSString *)ImageForUIControlStateHighlighted imageNameForselectedHighlighted:(NSString *)ImageForselectedHighlighted selectMethod:(SEL)SelectMethod selectEvent:(UIControlEvents)SelectEvent addView:(UIView *)AddToView viewController:(UIViewController *)ViewController;

-(void)CreateButtonWithText: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color textcolor:(UIColor *)Textcolor labeltext:(NSString *)LabelText fontName:(NSString *)FontName fontSize:(Size)FontSize textNameForUIControlStateNormal:(NSString *)TextForUIControlStateNormal textNameForUIControlStateSelected:(NSString *)TextForUIControlStateSelected textNameForUIControlStateHighlighted:(NSString *)TextForUIControlStateHighlighted textNameForselectedHighlighted:(NSString *)TextForselectedHighlighted selectMethod:(SEL)SelectMethod selectEvent:(UIControlEvents)SelectEvent addView:(UIView *)AddToView viewController:(UIViewController *)ViewController;

-(UITextField *)CrateTextField: (float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color backGroundImage:(NSString *)BackGroundImageName textcolor:(UIColor *)Textcolor palceholdertext:(NSString *)PlaceholderText fontName:(NSString *)FontName fontSize:(Size)FontSize Secure:(BOOL)Sucure addView:(UIView *)AddToView viewController:(UIViewController *)ViewController delegate:(id<UITextFieldDelegate>)Delegate textfieldName:(UITextField *)TextFieldName;

-(void)AddBlackOverlay:(UIView *)MainView xcord:(float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color OpacitY:(float)OpacitY Text:(NSString *)Text TextColor:(UIColor *)TextColor FontName:(NSString *)FontName FontSize:(Size)FontSize IsTextEnabled:(BOOL)IsTextEnabled;

-(void)RegisterDeviceForRemoteNotifiction :(int)BadgeNumber cancelLocalNotification:(BOOL)cancelLocalNotification;

-(NSDictionary *)executeFetch:(NSString *)query;

-(CATransition *)AddAnimationOnView;

-(void)SetupHeaderView:(UIView *)AddToView viewController:(UIViewController *)ViewController;

-(NSString *)CleanTextField:(NSString *)TextfieldName;

-(BOOL)ValidateEmail:(NSString *)EmailValue;

-(BOOL)ValidateSpecialCharacter:(NSString *)DataValue;

-(BOOL)validatePhone:(NSString*)phone;

-(BOOL)validatePassword:(NSString*)password Minrange:(int)MINRANGE Maxrange:(int)MAXRANGE;

-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType;

-(void)SetLoader:(UIView *)mainview xcord:(float)Xcord ycord:(float)Ycord width:(float)Width height:(float)Height backgroundColor:(UIColor *)Color imageName:(NSString *)ImageName viewcolor:(UIColor *)ViewColor animationDuration:(float)AnimationDuration dotColor:(UIColor *)DotColor animationStatus:(BOOL)AnimationStatus;

-(void)SetupHeaderViewWithCustomButton:(UIView *)AddToView viewController:(UIViewController *)ViewController hideLeftButton:(BOOL)hideLeftButton hiderightButton:(BOOL)hiderightButton leftButtonCustom:(BOOL)leftButtonCustom rightButtonCustom:(BOOL)rightButtonCustom leftButtonText:(NSString *)leftButtonText rightButtonText:(NSString *)rightButtonText LeftButtonImgae:(NSString *)LeftButtonImgae RightButtonImgae:(NSString *)RightButtonImgae LeftButtonMethod:(SEL)LeftButtonMethod RightButtonMethod:(SEL)RightButtonMethod;

//-(void)calculateSpeedofmotorbyck;
//-(NSString *)CheckSpeedForeachmoment;

-(void)setTopView:(UIView *)view;
-(void)SetupHeaderViewWithBack:(UIView *)AddToView viewController:(UIViewController *)ViewController;
    

@end

