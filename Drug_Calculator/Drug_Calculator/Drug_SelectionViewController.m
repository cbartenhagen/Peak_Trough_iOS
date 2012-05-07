//
//  Drug_SelectionViewController.m
//  Drug_Calculator
//
//  Created by Clarence Bartenhagen on 5/6/12.
//  Copyright (c) 2012 The University of Iowa. All rights reserved.
//

#import "Drug_SelectionViewController.h"
#import "Drug_CalculatorViewController.h"

@implementation Drug_SelectionViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSLog(@"prepareForSegue");
	if ([segue.identifier isEqualToString:@"Calculator_Vancomycin"]) {
		Drug_CalculatorViewController *navigationController =   segue.destinationViewController;
        
        navigationController.drug = @"Vancomycin";
	}
    if ([segue.identifier isEqualToString:@"Calculator_Gentamycin"]) {
        Drug_CalculatorViewController *navigationController =   segue.destinationViewController;
        
        navigationController.drug = @"Gentamycin";
    }
    
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
