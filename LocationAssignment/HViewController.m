//
//  HViewController.m
//  LocationAssignment
//
//  Created by Harihar Subramanyam on 3/22/14.
//  Copyright (c) 2014 Harihar Subramanyam. All rights reserved.
//

#import "HViewController.h"


@interface HViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switchUseGPS;
@property (weak, nonatomic) IBOutlet UIButton *btnTrackLocation;
@property (weak, nonatomic) IBOutlet UITextView *lblOutput;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailSelf;

@end

@implementation HViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
