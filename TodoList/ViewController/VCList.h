//
//  VCList.h
//  TodoList
//
//  Created by Francisco on 11/5/14.
//  Copyright (c) 2014 GoGu Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFunctions.h"

@interface VCList : UIViewController
{
    IBOutlet UIButton *buttonAdd;
    IBOutlet UISegmentedControl *segmentendList;
    UIScrollView *scrollViewListTodo;
    
    NSMutableArray *arrayDicts;
    NSMutableDictionary *tempDicts;
    
    NSInteger intRows;
}

@property (nonatomic, retain) IBOutlet UIButton *buttonAdd;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentendList;

- (IBAction)addActivity:(id)sender;
- (IBAction)selectKindActivity:(id)sender;

- (void)addScrollViewListTodo;
- (void)addScrollViewOpenTodo;
- (void)getDetails:(id)sender;
- (void)getItems;
- (void)moveNextWindow;
- (void)openPlist;
- (void)removeScrollViewListTodo;

@end
