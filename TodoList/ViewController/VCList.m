//
//  VCList.m
//  TodoList
//
//  Created by Francisco on 11/5/14.
//  Copyright (c) 2014 GoGu Corp. All rights reserved.
//

#import "VCList.h"
#include "AppDelegate.h"

@interface VCList ()

@end

@implementation VCList

@synthesize buttonAdd, segmentendList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.intKindItem = 0;
    
    [self openPlist];
    [self addScrollViewListTodo];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self getItems];
    
    if (appDelegate.intKindItem == 0)
        [self addScrollViewListTodo];
    else
        [self addScrollViewOpenTodo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Todo List Methods
- (IBAction)addActivity:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.intRow = -1;
    
    [self moveNextWindow];
}

- (IBAction)selectKindActivity:(id)sender
{
    if (segmentendList.selectedSegmentIndex == 0)
    {
        [self addScrollViewListTodo];
    }
    else
    {
        [self addScrollViewOpenTodo];
    }
}

- (void)getDetails:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.intRow = [sender tag];
    
    [self moveNextWindow];
}

#pragma mark - ViewController Methdos

- (void)getItems
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"todo.plist"];
    
    arrayDicts = [[NSMutableArray alloc] initWithContentsOfFile:path];
    intRows = [arrayDicts count];
}

- (void)openPlist
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"todo.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"todo" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath:path error:&error];
    }
    else
    {
        //[[CommonFunctions getCommonFunctions] showAlert:@"PLIST" WithMessage:@"HAY ARCHIVO" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    
    arrayDicts = [[NSMutableArray alloc] initWithContentsOfFile:path];
    intRows = [arrayDicts count];
}

#pragma mark - Display Todo List Methods

- (void)addScrollViewListTodo
{
    UIButton *buttonTemp;
    NSString *stringTemp;
    UIImage *imageTemp;
    UILabel *labelTemp;
    BOOL isPair = FALSE;
    UIScrollView *scrollViewTemp;
    CGSize sizeTemp;
    
    CGFloat floatTemp;
    
    [self removeScrollViewListTodo];
    
    scrollViewListTodo = [[UIScrollView alloc] init];
    scrollViewListTodo.frame = CGRectMake(0.0f, 100.0f, 320.0f, 419.0f);
    scrollViewListTodo.backgroundColor = UIColorFromRGB(0x808080);
    scrollViewListTodo.contentSize = CGSizeMake(320.0f, 1000.0f);
    scrollViewListTodo.showsVerticalScrollIndicator = TRUE;
    scrollViewListTodo.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:scrollViewListTodo];
    
    if (intRows == 0)
    {
        labelTemp = [[UILabel alloc] init];
        labelTemp.frame = CGRectMake(20.0f, 20.0f, 260.0f, 30.0f);
        labelTemp.textAlignment = UIControlContentHorizontalAlignmentLeft;
        labelTemp.numberOfLines = 2;
        labelTemp.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        labelTemp.text = @"NO TODOS";
        labelTemp.textColor = [UIColor whiteColor];
        labelTemp.backgroundColor = [UIColor clearColor];
        scrollViewListTodo.contentSize = CGSizeMake(320.0f, 419.0f);
        [scrollViewListTodo addSubview:labelTemp];
    }
    else
    {
        floatTemp = 0.0f;
        for (int i = 0; i < [arrayDicts count]; i++)
        {
            tempDicts = [[NSMutableDictionary alloc] init];
            tempDicts = [arrayDicts objectAtIndex:i];
            
            stringTemp = [tempDicts objectForKey:@"imageTodo"];
            imageTemp = [UIImage imageWithContentsOfFile:stringTemp];
            
            scrollViewTemp = [[UIScrollView alloc] init];
            scrollViewTemp.frame = CGRectMake(0.0f, floatTemp, 320.0f, 100.0f);
            if (isPair)
            {
                scrollViewTemp.backgroundColor = UIColorFromRGB(0x353437);
                isPair = FALSE;
            }
            else
            {
                scrollViewTemp.backgroundColor = UIColorFromRGB(0x3E3E40);
                isPair = TRUE;
            }
            scrollViewTemp.contentSize = CGSizeMake(320.0f, 100.0f);
            [scrollViewListTodo addSubview:scrollViewTemp];
            
            sizeTemp = CGSizeMake(90, 90);
            
            UIGraphicsBeginImageContext(sizeTemp);
            [imageTemp drawInRect:CGRectMake(0.0f, 0.0f, 90.0f, 90.0f)];
            
            UIImage *imagePhoto = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            buttonTemp = [UIButton buttonWithType:UIButtonTypeCustom];
            [buttonTemp setImage:imagePhoto forState:UIControlStateNormal];
            buttonTemp.frame = CGRectMake(5.0f, 5.0f, 90.0f, 90.0f);
            buttonTemp.layer.cornerRadius = 8;
            buttonTemp.clipsToBounds = YES;
            [buttonTemp setTag:i];
            [buttonTemp addTarget:self action:@selector(getDetails:) forControlEvents:UIControlEventTouchUpInside];
            [scrollViewTemp addSubview:buttonTemp];
            
            labelTemp = [[UILabel alloc] init];
            labelTemp.frame = CGRectMake(100.0, 10.0f, 200.0f, 25.0f);
            labelTemp.text = [tempDicts objectForKey:@"nameTodo"];            
            if ([[tempDicts objectForKey:@"isCompleted"] isEqualToString:@"NO"])
                labelTemp.textColor = [UIColor redColor];
            else
                labelTemp.textColor = [UIColor greenColor];
            labelTemp.backgroundColor = [UIColor clearColor];
            labelTemp.numberOfLines = 1;
            labelTemp.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            [scrollViewTemp addSubview:labelTemp];
            
            labelTemp = [[UILabel alloc] init];
            labelTemp.frame = CGRectMake(100.0, 40.0f, 200.0f, 25.0f);
            labelTemp.text = [tempDicts objectForKey:@"dateTodo"];
            labelTemp.textColor = [UIColor whiteColor];
            labelTemp.backgroundColor = [UIColor clearColor];
            labelTemp.numberOfLines = 1;
            labelTemp.font = [UIFont fontWithName:@"Helvetica-Oblique" size:11];
            [scrollViewTemp addSubview:labelTemp];
            
            floatTemp = floatTemp + 100.0f;
        }
        
        scrollViewListTodo.contentSize = CGSizeMake(320.0f, floatTemp + 10.0f);
    }
}

- (void)addScrollViewOpenTodo
{
    UIButton *buttonTemp;
    NSString *stringTemp;
    UIImage *imageTemp;
    UILabel *labelTemp;
    BOOL isPair = FALSE;
    UIScrollView *scrollViewTemp;
    CGSize sizeTemp;
    
    CGFloat floatTemp;
    
    [self removeScrollViewListTodo];
    
    scrollViewListTodo = [[UIScrollView alloc] init];
    scrollViewListTodo.frame = CGRectMake(0.0f, 100.0f, 320.0f, 419.0f);
    scrollViewListTodo.backgroundColor = UIColorFromRGB(0x808080);
    scrollViewListTodo.contentSize = CGSizeMake(320.0f, 1000.0f);
    scrollViewListTodo.showsVerticalScrollIndicator = TRUE;
    scrollViewListTodo.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:scrollViewListTodo];
    
    if (intRows == 0)
    {
        labelTemp = [[UILabel alloc] init];
        labelTemp.frame = CGRectMake(20.0f, 20.0f, 260.0f, 30.0f);
        labelTemp.textAlignment = UIControlContentHorizontalAlignmentLeft;
        labelTemp.numberOfLines = 2;
        labelTemp.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        labelTemp.text = @"NO TODOS";
        labelTemp.textColor = [UIColor whiteColor];
        labelTemp.backgroundColor = [UIColor clearColor];
        scrollViewListTodo.contentSize = CGSizeMake(320.0f, 419.0f);
        [scrollViewListTodo addSubview:labelTemp];
    }
    else
    {
        floatTemp = 0.0f;
        for (int i = 0; i < [arrayDicts count]; i++)
        {
            tempDicts = [[NSMutableDictionary alloc] init];
            tempDicts = [arrayDicts objectAtIndex:i];
            

            if ([[tempDicts objectForKey:@"isCompleted"] isEqualToString:@"NO"])
            {
                stringTemp = [tempDicts objectForKey:@"imageTodo"];
                imageTemp = [UIImage imageWithContentsOfFile:stringTemp];
            
                scrollViewTemp = [[UIScrollView alloc] init];
                scrollViewTemp.frame = CGRectMake(0.0f, floatTemp, 320.0f, 100.0f);
                if (isPair)
                {
                    scrollViewTemp.backgroundColor = UIColorFromRGB(0x353437);
                    isPair = FALSE;
                }
                else
                {
                    scrollViewTemp.backgroundColor = UIColorFromRGB(0x3E3E40);
                    isPair = TRUE;
                }
                scrollViewTemp.contentSize = CGSizeMake(320.0f, 100.0f);
                [scrollViewListTodo addSubview:scrollViewTemp];
            
                sizeTemp = CGSizeMake(90, 90);
            
                UIGraphicsBeginImageContext(sizeTemp);
                [imageTemp drawInRect:CGRectMake(0.0f, 0.0f, 90.0f, 90.0f)];
            
                UIImage *imagePhoto = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            
                buttonTemp = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTemp setImage:imagePhoto forState:UIControlStateNormal];
                buttonTemp.frame = CGRectMake(5.0f, 5.0f, 90.0f, 90.0f);
                buttonTemp.layer.cornerRadius = 8;
                buttonTemp.clipsToBounds = YES;
                [buttonTemp setTag:i];
                [buttonTemp addTarget:self action:@selector(getDetails:) forControlEvents:UIControlEventTouchUpInside];
                [scrollViewTemp addSubview:buttonTemp];
            
                labelTemp = [[UILabel alloc] init];
                labelTemp.frame = CGRectMake(100.0, 10.0f, 200.0f, 25.0f);
                labelTemp.text = [tempDicts objectForKey:@"nameTodo"];
                labelTemp.textColor = [UIColor redColor];
                labelTemp.backgroundColor = [UIColor clearColor];
                labelTemp.numberOfLines = 1;
                labelTemp.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
                [scrollViewTemp addSubview:labelTemp];
            
                labelTemp = [[UILabel alloc] init];
                labelTemp.frame = CGRectMake(100.0, 40.0f, 200.0f, 25.0f);
                labelTemp.text = [tempDicts objectForKey:@"dateTodo"];
                labelTemp.textColor = [UIColor whiteColor];
                labelTemp.backgroundColor = [UIColor clearColor];
                labelTemp.numberOfLines = 1;
                labelTemp.font = [UIFont fontWithName:@"Helvetica-Oblique" size:11];
                [scrollViewTemp addSubview:labelTemp];
            
                floatTemp = floatTemp + 100.0f;
            }
        }
        
        scrollViewListTodo.contentSize = CGSizeMake(320.0f, floatTemp + 10.0f);
    }
}

- (void)removeScrollViewListTodo
{
    [scrollViewListTodo removeFromSuperview];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)moveNextWindow
{
    [self performSegueWithIdentifier:@"pushItem" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Keyboard Methods


@end
