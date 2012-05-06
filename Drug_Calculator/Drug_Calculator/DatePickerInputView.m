//
//  DatePickerInputView.m
//  Drug_Calculator
//
//  Created by Clarence Bartenhagen on 4/26/12.
//  Copyright (c) 2012 The University of Iowa. All rights reserved.
//

#import "DatePickerInputView.h"

@implementation DatePickerInputView {

    UITextField *_inputField; // ivar to store the textfield currently being edited
}
@synthesize datePicker = _datePicker;
@synthesize done = _done;
// TARGET METHODS
-(void)pickerValueChanged:(UIDatePicker *)picker{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"]; //24hr time format
    NSString *dateString = [outputFormatter stringFromDate:self.datePicker.date];
    _inputField.text = dateString;
    
    
    //_inputField.text = self.datePicker.date.description; // set text to date description
}
-(void)viewDoubleTapped:(UITapGestureRecognizer *)tapGR{
    [_inputField resignFirstResponder]; // upon double-tap dismiss picker
}
-(void)textFieldBeganEditing:(NSNotification *)note{
    _inputField = note.object; // set ivar to current first responder

}
-(void)textFieldEndedEditing:(NSNotification *)note{
    _inputField = nil; // the first responder ended editing CRITICAL:avoids retain cycle
}
// INITI METHODS
-(void)initializationCodeMethod{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 0)];// All pickers have preset height
    self.bounds = _datePicker.bounds; // Make our view same size as picker
    [self addSubview:_datePicker];
    [_datePicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // register to be notified when the value changes
    // As an example we'll use a tap gesture recognizer to dismiss on a double-tap
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDoubleTapped:)];
    tapGR.numberOfTapsRequired = 2; // Limit to double-taps
    [self addGestureRecognizer:tapGR];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textFieldBeganEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil]; // Ask to be informed when any textfield begins editing
    [center addObserver:self selector:@selector(textFieldEndedEditing:) name:UITextFieldTextDidEndEditingNotification object:nil]; // Ask to be informed when any textfield ends editing
    
//   _done = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
//   [_done addTarget:self action:@selector(aMethod:)
//     forControlEvents:UIControlEventTouchDown];
//    [_done setTitle:@"Show View" forState:UIControlStateNormal];
//    //_done.frame = CGRectMake(80.0, 80.0, 80.0, 80.0);
//    self.bounds = _done.bounds;
//    [self addSubview:_done];
//    
    
    
}
-(id)init{
    if ((self = [super init])){
        [self initializationCodeMethod];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])){
        [self initializationCodeMethod];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        [self initializationCodeMethod];
    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
}
@end