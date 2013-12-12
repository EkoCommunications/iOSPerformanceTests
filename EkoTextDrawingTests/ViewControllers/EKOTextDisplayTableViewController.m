//
//  EKOViewController.m
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/11/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "EKOTextDisplayTableViewController.h"
#import "EKOTextDisplayCell.h"
#import "EKOTextSelectionTableViewController.h"
#import "EKOAttributedTextHeightOperation.h"
#import "EKOAttributedLabelCell.h"
#import "TTTAttributedLabel.h"
#import "EKOCacheManager.h"
#import "EKOAttributedLabel.h"


NSString *const  kEKOTextDisplayTableCellIdentifier =@"textDisplayCell";


NS_ENUM(NSInteger,EKOTextDisplayTableViewControllerTextSource){
    
    EKOTextDisplayTableViewControllerTextSourcePlain,
    EKOTextDisplayTableViewControllerTextSourceAttributed,
    
};

@interface EKOTextDisplayTableViewController ()


@end

@implementation EKOTextDisplayTableViewController{
    
    CGFloat _calcualatedTextHeight;
    NSOperationQueue *operationQueue;
    
    NSMutableDictionary *cachedHeights;
 
    NSMutableArray *attributedStrings;
    NSMutableArray *plainTextString;
    
    enum EKOTextDisplayTableViewControllerTextSource textSource;
    
    UIFont *font;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    font = [UIFont fontWithName:@"Helvetica" size:18];

    
    plainTextString = [[NSMutableArray alloc]init];
    attributedStrings = [[NSMutableArray alloc]init];
    
    textSource = EKOTextDisplayTableViewControllerTextSourceAttributed;
    
    
    NSArray *filePaths = [[NSBundle mainBundle]pathsForResourcesOfType:@"txt" inDirectory:nil];

    int numberOfCopies = 1;
    
    for(NSString *path in filePaths){
        
        NSString *plainText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSAttributedString *attribuedText = [[NSAttributedString alloc]initWithString:plainText];
    
        for(int i=0;i<numberOfCopies;i++){
            [plainTextString addObject:plainText];
            [attributedStrings addObject:attribuedText];
        }
        
    }
    
    
    cachedHeights = [[NSMutableDictionary alloc]init];
    
    operationQueue = [[NSOperationQueue alloc]init];
    operationQueue.maxConcurrentOperationCount =1;
    self.tableView.allowsSelection = NO;
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Height Caching

-(void)cacheAttributedStringHeights{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0),^{
        
        int i =0;
        
        for(NSAttributedString *attString in attributedStrings){
            
            
            CGSize size = CGSizeMake(200,CGFLOAT_MAX);
            
            NSTextContainer * textContainer = [[NSTextContainer alloc]initWithSize:size];
            
            NSTextStorage *textStorage =[[NSTextStorage alloc]initWithAttributedString:attString];
            NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
            [textStorage addLayoutManager:layoutManager];
            
            [layoutManager addTextContainer:textContainer];
            
            NSRange range  = NSMakeRange(0,[attString.string length]);
            [layoutManager ensureLayoutForCharacterRange:range];
            
            
            CGRect rect = [layoutManager boundingRectForGlyphRange:range inTextContainer:textContainer];
            
            CGFloat height = CGRectIntegral(rect).size.height;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [cachedHeights setObject:[NSNumber numberWithFloat:height] forKey:indexPath];
                
            });
            
            i++;
        }
        
    });
    
}

#pragma mark - Actions

-(IBAction)changeStyleButtonAction:(id)sender{
    
    if(textSource==EKOTextDisplayTableViewControllerTextSourcePlain){
        textSource = EKOTextDisplayTableViewControllerTextSourceAttributed;
    }
    else{
        textSource = EKOTextDisplayTableViewControllerTextSourcePlain;
    }
    
    [self.tableView reloadData];
}

#pragma mark - Height Calculation

+(CGFloat)calculateHeightForText:(id)text withFont:(UIFont *)font andMaxHeight:(CGFloat)maxHeight {
    
    
    CGSize size = CGSizeMake(200,maxHeight);
   
    CGFloat height = 0;
    
    if([text isKindOfClass:[NSAttributedString class]]){
    

        height = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        
    }
    else if([text isKindOfClass:[NSString class]]){
        
        height =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSFontAttributeName:font} context:nil].size.height;
    }
    return height;
        
}

#pragma mark - Table View Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [plainTextString count];
    
}

#pragma mark - TableViewDatasource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if([cachedHeights objectForKey:indexPath]) {
        return  [(NSNumber*)[cachedHeights objectForKey:indexPath]floatValue];
    }
    else{

        CGFloat height = 0;
        
        if(textSource == EKOTextDisplayTableViewControllerTextSourcePlain){
            NSString *string = [plainTextString objectAtIndex:indexPath.row];
            height = [[self class]calculateHeightForText:string withFont:font andMaxHeight:100000];
        }
        else{
            NSAttributedString  *string = (NSAttributedString*)[attributedStrings objectAtIndex:indexPath.row];
            height = [[self class]calculateHeightForText:string withFont:font andMaxHeight:100000];
        }
        
        [cachedHeights setObject:[NSNumber numberWithFloat:height] forKey:indexPath];
        return height;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    EKOAttributedLabelCell *cachedCell = [[EKOCacheManager sharedManager].viewsCache objectForKey:indexPath];
    if(cachedCell){
        return cachedCell;
    }

    
    EKOAttributedLabelCell* cell=[[EKOAttributedLabelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"attributedLabelCell"];

    [[EKOCacheManager sharedManager].viewsCache setObject:cell forKey:indexPath];

    
    if(textSource == EKOTextDisplayTableViewControllerTextSourcePlain){
     
        NSString *string = [plainTextString objectAtIndex:indexPath.row];
        cell.displayLabel.text =string;
    }
    else {
        
        NSAttributedString *string = [attributedStrings objectAtIndex:indexPath.row];
        cell.displayLabel.attributedText = string;
    }
    
    return cell;
}






@end
