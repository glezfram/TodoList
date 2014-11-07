//
//  FirstViewController.m
//  TodoList
//
//  Created by Francisco on 11/5/14.
//  Copyright (c) 2014 GoGu Corp. All rights reserved.
//

#import "VCNewItem.h"

@interface VCNewItem ()

@end

@implementation VCNewItem

@synthesize textFieldTodo, imageViewPhoto;
@synthesize labelCompleted, switchCompleted, buttonDelete;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navigationBar = [self.navigationController navigationBar];
    navigationBar.hidden = TRUE;
    
    dataImage = [[NSData alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.intRow > -1)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"todo.plist"];
        
        arrayDicts = [[NSMutableArray alloc] initWithContentsOfFile:path];
        tempDicts = [[NSMutableDictionary alloc] init];
        tempDicts = [arrayDicts objectAtIndex:appDelegate.intRow];
        
        textFieldTodo.text = [tempDicts objectForKey:@"nameTodo"];
        if ([[tempDicts objectForKey:@"isCompleted"] isEqualToString:@"YES"])
            [switchCompleted setOn:YES];
        else
            [switchCompleted setOn:NO];
        
        stringPathImage = [tempDicts objectForKey:@"imageTodo"];
        UIImage *imageTemp = [UIImage imageWithContentsOfFile:stringPathImage];
        dataImage = UIImageJPEGRepresentation(imageTemp, 1.0);
        imageViewPhoto.image = imageTemp;
    }
    else
    {
        buttonDelete.hidden = YES;
        labelCompleted.hidden = YES;
        switchCompleted.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UI Methods

- (void)backWindow
{
    textFieldTodo.text = @"";
    imageViewPhoto.backgroundColor = UIColorFromRGB(0x808080);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addItemPlist
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"todo.plist"];
    arrayDicts = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    NSMutableDictionary *dictTemp = [[NSMutableDictionary alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, YYYY"];
    NSString *stringTemp = [formatter stringFromDate:[NSDate date]];
    
    [dictTemp setValue:stringTemp forKey:@"dateTodo"];
    [dictTemp setValue:textFieldTodo.text forKey:@"nameTodo"];
    if (appDelegate.intRow > -1)
    {
        if (switchCompleted.isOn)
            [dictTemp setValue:@"YES" forKey:@"isCompleted"];
        else
            [dictTemp setValue:@"NO" forKey:@"isCompleted"];
    }
    else
        [dictTemp setValue:@"NO" forKey:@"isCompleted"];
    
    if (dataImage.length > 0)
    {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYYMMddhhmmss"];
        stringTemp = [NSString stringWithFormat:@"%@.jpg", [formatter stringFromDate:[NSDate date]]];
        stringTemp = [documentsDirectory stringByAppendingPathComponent:stringTemp];
        [dataImage writeToFile:stringTemp atomically:YES];
    }
    else
    {
        stringTemp = @"-";
    }
    [dictTemp setValue:stringTemp forKey:@"imageTodo"];
    
    if (appDelegate.intRow > -1)
    {
        //[dictTemp setValue:stringPathImage forKey:@"imageTodo"];
        [arrayDicts removeObjectAtIndex:appDelegate.intRow];
    }
    //else
        //[dictTemp setValue:stringTemp forKey:@"imageTodo"];
    

    [arrayDicts addObject:dictTemp];
    
    NSArray *arrayTemp = [[NSMutableArray alloc] initWithArray:arrayDicts];
    [arrayTemp writeToFile:path atomically:YES];
    
}

#pragma mark - Buttons Methods

- (IBAction)cancelItem:(id)sender
{
    [self backWindow];
}

- (void)deleteFile:(NSString *)stringPathLocal
{
    NSError *errorTemp = NULL;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:stringPathLocal error:&errorTemp];
}

- (void)deleteItem:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"todo.plist"];
    
    arrayDicts = [[NSMutableArray alloc] initWithContentsOfFile:path];
    tempDicts = [[NSMutableDictionary alloc] init];
    tempDicts = [arrayDicts objectAtIndex:appDelegate.intRow];
    
    [self deleteFile:[tempDicts objectForKey:@"imageTodo"]];
    [arrayDicts removeObjectAtIndex:appDelegate.intRow];
    
    NSArray *arrayTemp = [[NSMutableArray alloc] initWithArray:arrayDicts];
    [arrayTemp writeToFile:path atomically:YES];
    
    [self backWindow];
}

- (IBAction)hasBeenCompleted:(id)sender
{
    
}

- (void)saveItem:(id)sender
{
    if (textFieldTodo.text.length > 0)
    {
        [self addItemPlist];
        [self backWindow];
    }
    else
    {
        [[CommonFunctions getCommonFunctions] showAlert:@"TITLE TODO" WithMessage:@"TITLE IS EMPTY" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
}

- (IBAction)selectImage:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (IBAction)takePhoto:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}


#pragma mark - UIImagePicker Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imageTemp = info[UIImagePickerControllerEditedImage];
    imageViewPhoto.image = imageTemp;
    dataImage = UIImageJPEGRepresentation(imageTemp, 1.0);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITextField Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
