//
//  RPMasterViewController.h
//  Knowledge
//
//  Created by Rob Pearlman on 23/08/2014.
//  Copyright (c) 2014 Rob Pearlman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPDetailViewController;

@interface RPMasterViewController : UITableViewController

@property (strong, nonatomic) RPDetailViewController *detailViewController;

@end
