//
//  RPDetailViewController.h
//  Knowledge
//
//  Created by Rob Pearlman on 23/08/2014.
//  Copyright (c) 2014 Rob Pearlman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RPItemClass;


@interface RPDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) RPItemClass* detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
