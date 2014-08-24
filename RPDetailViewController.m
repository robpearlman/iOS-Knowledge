//
//  RPDetailViewController.m
//  Knowledge
//
//  Created by Rob Pearlman on 23/08/2014.
//  Copyright (c) 2014 Rob Pearlman. All rights reserved.
//

#import "RPDetailViewController.h"
#import "RPItemClass.h"
#import <RestKit/RestKit.h>

@interface RPDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@property (weak, nonatomic) IBOutlet UITextField *itemNameField;
@property (weak, nonatomic) IBOutlet UITextField *itemDetailField;
@property (weak, nonatomic) IBOutlet UIButton *postItemButton;


@end

@implementation RPDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem item_details];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitPost:(id)sender
{
    // *myClient = [RKClient sharedClient];
    NSMutableDictionary *itemData = [[NSMutableDictionary alloc] init ];
    
    //The server ask me for this format, so I set it here:
    [itemData setObject:self.itemNameField.text forKey:@"name"];
    [itemData setObject:self.itemDetailField forKey:@"item_details"];
    
    RPItemClass* newData = [[RPItemClass alloc] init];
    
    newData.name = self.itemNameField.text;
    newData.item_details = self.itemDetailField.text;
    
    
    
     [[RKObjectManager sharedManager] postObject:newData
                                            path:@"items/"
                                      parameters:nil
                                         success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                             NSLog(@"The mapping result is %@, %@, %@", mappingResult, newData.name, newData.item_details);
                                         }
                                         failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                             NSLog(@"\n\n\n == \nERROE = %@",error);
                                         }];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
