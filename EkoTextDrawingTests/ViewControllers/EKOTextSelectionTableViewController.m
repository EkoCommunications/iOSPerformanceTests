//
//  EKOTextSelectionTableViewController.m
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/11/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "EKOTextSelectionTableViewController.h"



@interface EKOTextSelectionTableViewController ()

@end

@implementation EKOTextSelectionTableViewController{
    

    NSArray *filePaths;
    
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    filePaths = [[NSBundle mainBundle]pathsForResourcesOfType:@"txt" inDirectory:nil];
    
    //NSLog(@"%@",filePaths);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(NSString *)plainTextAtIndexPath:(NSIndexPath*)indexPath {
    
    NSString *path=  [filePaths objectAtIndex:indexPath.row];
    
    NSError *err = nil;
    
    NSString *plainText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    
    if(err){
        NSLog(@"%@",err.userInfo);
        return nil;
    }
    
    return plainText;
    
    
}

-(NSAttributedString *)attributedTextAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * text = [self plainTextAtIndexPath:indexPath];
    NSMutableAttributedString *mAtt  =[[NSMutableAttributedString alloc]initWithString:text];
    
    [mAtt addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.google.com"] range:NSMakeRange(10,5)];
    
    return mAtt;

}

#pragma mark - TabelViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section ==0)
        return @"Plain Text";
    
    
    return @"Attributed Text";
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [filePaths count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[filePaths objectAtIndex:indexPath.row]lastPathComponent];
    return cell;
}

#pragma mark - TableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    switch (indexPath.section) {
        case 0:{ // section 1 plain text
        
            NSString *text  = [self plainTextAtIndexPath:indexPath];
            [self.delegate textSelectionViewController:self didSelectText:text];
            break;
        }
        case 1: { // section 2 plain text
            NSAttributedString *attText = [self attributedTextAtIndexPath:indexPath];
            [self.delegate textSelectionViewController:self didSelectAttributedText:attText];
        }
            
        default:
            break;
    }
    
}




@end
