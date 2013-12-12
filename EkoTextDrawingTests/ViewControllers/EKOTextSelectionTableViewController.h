//
//  EKOTextSelectionTableViewController.h
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/11/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKOTextSelectionTableViewControllerDelegate;




@interface EKOTextSelectionTableViewController : UITableViewController

@property(assign,nonatomic)id<EKOTextSelectionTableViewControllerDelegate>delegate;

-(IBAction)cancelButtonAction:(id)sender;


@end


@protocol EKOTextSelectionTableViewControllerDelegate <NSObject>

-(void)textSelectionViewController:(EKOTextSelectionTableViewController *)controller didSelectText:(NSString *)text;


-(void)textSelectionViewController:(EKOTextSelectionTableViewController *)controller didSelectAttributedText:(NSAttributedString *)text;


                                    
@end

