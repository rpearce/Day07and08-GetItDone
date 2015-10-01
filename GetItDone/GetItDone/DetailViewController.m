//
//  DetailViewController.m
//  GetItDone
//
//  Created by Robert Pearce on 9/30/15.
//  Copyright © 2015 Robert Pearce. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@property (nonatomic, strong) AppDelegate            *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak)   IBOutlet UITextField   *todoTitleTextField;

@end

@implementation DetailViewController

#pragma mark - Interactivity Methods

- (IBAction)saveButtonPressed:(id)sender {
    _currentTodo.todoTitle = _todoTitleTextField.text;
    _currentTodo.dateUpdated = [NSDate date];
    _currentTodo.userID = @"User";
    [self saveAndPopView];
}

- (IBAction)deleteRecord:(id)sender {
    [_managedObjectContext deleteObject:_currentTodo];
    [self saveAndPopView];
}

- (void)saveAndPopView {
    [_appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_currentTodo != nil) {
        _todoTitleTextField.text = _currentTodo.todoTitle;
        NSLog(@"%@", _todoTitleTextField.text);
    } else {
        Todos *newTodo = (Todos *)[NSEntityDescription insertNewObjectForEntityForName:@"Todos" inManagedObjectContext:_managedObjectContext];
        newTodo.dateEntered = [NSDate date];
        _currentTodo = newTodo;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
