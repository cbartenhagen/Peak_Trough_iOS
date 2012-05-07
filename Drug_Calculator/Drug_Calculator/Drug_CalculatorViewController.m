//
//  Drug_CalculatorViewController.m
//  Drug_Calculator
//
//  Created by CS Uiowa on 4/2/12.
//  Copyright (c) 2012 The University of Iowa. All rights reserved.
//

#import "Drug_CalculatorViewController.h"
#import "Drug_Calculator_Brain.h"

@interface Drug_CalculatorViewController() 

@property (nonatomic, strong) Drug_Calculator_Brain *brain;
@property (strong, nonatomic) IBOutlet UITextField *infusionLengthTextField;
@property (strong, nonatomic) IBOutlet UITextField *infusionStartTextField;
@property (strong, nonatomic) IBOutlet UITextField *dosingIntervalTextfield;
@property (strong, nonatomic) IBOutlet UILabel *dosingIntervalLabel;
@property (strong, nonatomic) IBOutlet UILabel *dosingIntervalTimeLabel;
@property (strong, nonatomic) IBOutlet UITextField *infusionDurationTextField;
@property (strong, nonatomic) IBOutlet UILabel *infusionDurationLabel;
@property (strong, nonatomic) IBOutlet UILabel *infustionDurationTimeLabel;
@property (strong, nonatomic) IBOutlet UITextField *firstLevelTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondLevelTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstLevelValueTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondLevelValueTextField;

@end





@implementation Drug_CalculatorViewController

@synthesize troughValueLabel = _troughValueLabel;
@synthesize peakValueLabel = _peakValueLabel;
@synthesize drug = _drug;
@synthesize brain = _brain;
//@synthesize actionSheet = _actionSheet;

@synthesize infusionStartTextField = _infusionStartTextField;
@synthesize infusionLengthTextField = _infusionLengthTextField;
@synthesize firstLevelTimeTextField = _firstLevelTimeTextField;
@synthesize secondLevelTimeTextField = _secondLevelTimeTextField;
@synthesize firstLevelValueTextField = _firstLevelValueTextField;
@synthesize secondLevelValueTextField = _secondLevelValueTextField;
@synthesize dosingIntervalTextfield = _dosingIntervalTextfield;
@synthesize dosingIntervalLabel = _dosingIntervalLabel;
@synthesize dosingIntervalTimeLabel = _dosingIntervalTimeLabel;
@synthesize infusionDurationTextField = _infusionDurationTextField;
@synthesize infusionDurationLabel = _infusionDurationLabel;
@synthesize infustionDurationTimeLabel = _infustionDurationTimeLabel;


- (Drug_Calculator_Brain *) brain
{
    if (!_brain)
        _brain = [[Drug_Calculator_Brain alloc] init];
    return _brain;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Drug pressed was %@", _drug);

    DatePickerInputView *dateEntryView = [[DatePickerInputView alloc] init];
    dateEntryView.datePicker.datePickerMode = UIDatePickerModeTime;
    self.infusionStartTextField.inputView = dateEntryView;
    self.firstLevelTimeTextField.inputView = dateEntryView;
    self.secondLevelTimeTextField.inputView = dateEntryView;
    
    DatePickerInputView *infusiontimeEntryView = [[DatePickerInputView alloc] init];
    infusiontimeEntryView.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init]; [myFormatter setDateFormat:@"HH:mm"];
    NSDate *initialDate = [myFormatter dateFromString:@"00:30"]; 
    [infusiontimeEntryView.datePicker setDate:initialDate animated:YES];  
    self.infusionLengthTextField.inputView = infusiontimeEntryView;
    self.infusionDurationTextField.inputView = infusiontimeEntryView;
    
    DatePickerInputView *dosingDurationEntryView = [[DatePickerInputView alloc] init];
    dosingDurationEntryView.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    
    initialDate = [myFormatter dateFromString:@"08:00"]; 
    [dosingDurationEntryView.datePicker setDate:initialDate animated:YES];  
    self.dosingIntervalTextfield.inputView = dosingDurationEntryView;

    
    
    
}

- (void)viewDidUnload
{
    [self setInfusionLengthTextField:nil];
    [self setInfusionStartTextField:nil];
    [self setDosingIntervalTextfield:nil];
    [self setDosingIntervalLabel:nil];
    [self setInfusionDurationTextField:nil];
    [self setInfusionDurationLabel:nil];
    [self setTroughValueLabel:nil];
    [self setPeakValueLabel:nil];
    [self setFirstLevelTimeTextField:nil];
    [self setSecondLevelTimeTextField:nil];
    [self setFirstLevelValueTextField:nil];
    [self setSecondLevelValueTextField:nil];
    [self setDosingIntervalTimeLabel:nil];
    [self setInfustionDurationTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (IBAction)alternateDosingSchedule:(UISwitch *)sender {
    
    if (sender.on){
        NSLog(@"Alt dose ON");
        self.dosingIntervalLabel.hidden = FALSE;
        self.dosingIntervalTextfield.hidden = FALSE;
        self.infusionDurationLabel.hidden = FALSE;
        self.infusionDurationTextField.hidden = FALSE;
        self.dosingIntervalTimeLabel.hidden = FALSE;
        self.infustionDurationTimeLabel.hidden = FALSE;
        
    }
    else {
        NSLog(@"Alt dose OFF");
        self.dosingIntervalLabel.hidden = TRUE;
        self.dosingIntervalTextfield.hidden = TRUE;
        self.infusionDurationLabel.hidden = TRUE;
        self.infusionDurationTextField.hidden = TRUE;
        self.dosingIntervalTimeLabel.hidden = TRUE;
        self.infustionDurationTimeLabel.hidden = TRUE;
    }
}


-(IBAction)calculatePressed:(UIButton *)sender{
    NSLog(@"calculate pressed ");
    NSDictionary *results = [[ NSDictionary alloc] init];
    
    results = [self.brain calculate:[self.infusionStartTextField text] :[self.infusionLengthTextField text] :[self.firstLevelTimeTextField text] :[self.firstLevelValueTextField text] :[self.secondLevelTimeTextField text] :[self.secondLevelValueTextField text]: [self.dosingIntervalTextfield text]: [self.infusionDurationTextField text]];
    
    
    NSNumberFormatter * NumFormatter = [[NSNumberFormatter alloc] init];
    [NumFormatter setLocale:[NSLocale currentLocale]]; 
    [NumFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [NumFormatter setNumberStyle:NSNumberFormatterDecimalStyle]; 
    
    
    
    self.peakValueLabel.text = [NumFormatter stringFromNumber:[results objectForKey:@"peak"]];
    self.troughValueLabel.text = [NumFormatter stringFromNumber:[results objectForKey:@"trough"]];
    
}
-(IBAction)savePressed:(UIButton *)sender {
     NSLog(@"save pressed ");
    
    [self performSegueWithIdentifier:@"SaveSegue" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SaveSegue"])
    {
        
    }
    
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
