//
//  FirstViewController.h
//  TodoList
//
//  Created by Francisco on 11/5/14.
//  Copyright (c) 2014 GoGu Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFunctions.h"
#import "AppDelegate.h"

@interface VCNewItem : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *textFieldTodo;
    IBOutlet UIImageView *imageViewPhoto;
    IBOutlet UILabel *labelCompleted;
    IBOutlet UISwitch *switchCompleted;
    IBOutlet UIButton *buttonDelete;
    
    NSMutableArray *arrayDicts;
    NSMutableDictionary *tempDicts;
    
    NSString *stringPathImage;
    
    NSData *dataImage;
    NSString *stringImage;
}

@property (nonatomic, retain) IBOutlet UITextField *textFieldTodo;
@property (nonatomic, retain) IBOutlet UIImageView *imageViewPhoto;
@property (nonatomic, retain) IBOutlet UILabel *labelCompleted;
@property (nonatomic, retain) IBOutlet UISwitch *switchCompleted;
@property (nonatomic, retain) IBOutlet UIButton *buttonDelete;

- (void)addItemPlist;
- (void)backWindow;
- (void)deleteFile:(NSString *)stringPathLocal;

- (IBAction)cancelItem:(id)sender;
- (IBAction)deleteItem:(id)sender;
- (IBAction)hasBeenCompleted:(id)sender;
- (IBAction)saveItem:(id)sender;
- (IBAction)selectImage:(id)sender;
- (IBAction)takePhoto:(id)sender;

@end

