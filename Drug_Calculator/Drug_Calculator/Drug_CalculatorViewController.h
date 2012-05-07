//
//  Drug_CalculatorViewController.h
//  Drug_Calculator
//
//  Created by CS Uiowa on 4/2/12.
//  Copyright (c) 2012 The University of Iowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerInputView.h"


@interface Drug_CalculatorViewController : UIViewController 
@property (strong, nonatomic) IBOutlet UILabel *troughValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *peakValueLabel;
@property  (strong, nonatomic) NSString *drug;


-(IBAction)calculatePressed:(UIButton *)sender; 
-(IBAction)savePressed:(UIButton *)sender;

@end
