

#import <UIKit/UIKit.h>

@class ACEAutocompleteInputView;

@protocol ACEAutocompleteItem <NSObject>

// used to display text on the autocomplete bar
- (NSString *)autocompleteString;

@end

#pragma mark -

@protocol ACEAutocompleteDelegate <UITextFieldDelegate>

// called when the user tap on one of the suggestions
- (void)textField:(UITextField *)textField didSelectObject:(id)object inInputView:(ACEAutocompleteInputView *)inputView;

@end

#pragma mark -

@protocol ACEAutocompleteDataSource <NSObject>

// number of characters required to trigger the search on possible suggestions
- (NSUInteger)minimumCharactersToTrigger:(ACEAutocompleteInputView *)inputView;

// use the block to return the array of items asynchronously based on the query string 
- (void)inputView:(ACEAutocompleteInputView *)inputView itemsFor:(NSString *)query result:(void (^)(NSArray *items))resultBlock;

@optional

// calculate the width of the view for the object (NSString or ACEAutocompleteItem)
- (CGFloat)inputView:(ACEAutocompleteInputView *)inputView widthForObject:(id)object;

// called when after the cell is created, to add custom subviews
- (void)inputView:(ACEAutocompleteInputView *)inputView customizeView:(UIView *)view;

// called to set the object properties in the custom view
- (void)inputView:(ACEAutocompleteInputView *)inputView setObject:(id)object forView:(UIView *)view;

@end

#import "ACEAutocompleteInputView.h"
#import "UITextField+ACEAutocompleteBar.h"


