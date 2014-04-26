


#import <UIKit/UIKit.h>

@interface ACEAutocompleteInputView : UIView<UITextFieldDelegate>

@property (nonatomic, assign) UITextField *textField;

// delegate
@property (nonatomic, assign) id<ACEAutocompleteDelegate> delegate;
@property (nonatomic, assign) id<ACEAutocompleteDataSource> dataSource;

// customization (ignored when the optional methods of the data source are implemeted)
@property (nonatomic, strong) UIFont * font;
@property (nonatomic, strong) UIColor * textColor;

- (id)initWithHeight:(CGFloat)height;

- (void)show:(BOOL)show withAnimation:(BOOL)animated;

@end
