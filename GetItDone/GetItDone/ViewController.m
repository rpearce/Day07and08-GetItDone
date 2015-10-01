//
//  ViewController.m
//  GetItDone
//
//  Created by Robert Pearce on 9/29/15.
//  Copyright © 2015 Robert Pearce. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Todos.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong) AppDelegate            *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray                *todosArray;
@property (nonatomic, weak)   IBOutlet UITableView   *todosTableView;

@end

@implementation ViewController

#pragma mark - Core Data Methods

- (IBAction)addRecord:(id)sender {
    Todos *newTodo = (Todos *)[NSEntityDescription insertNewObjectForEntityForName:@"Todos" inManagedObjectContext:_managedObjectContext];
    newTodo.todoTitle = @"";
    newTodo.dateEntered = [NSDate date];
    newTodo.userID = @"System";
}

- (NSArray *)fetchTodos {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todos" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchResults;
}

#pragma mark - Interactivity Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"segueEditTodo"]) {
        NSIndexPath *indexPath = [_todosTableView indexPathForSelectedRow];
        Todos *currentTodo = _todosArray[indexPath.row];
        destController.currentTodo = currentTodo;
    } else if ([[segue identifier] isEqualToString:@"segueAddTodo"]) {
        destController.currentTodo = nil;
    }
}

//- (IBAction)deleteTodo:(id)sender {
//    Todos *todoToDelete =
//}

- (IBAction)saveButtonPressed:(id)sender {
    [_appDelegate saveContext];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _todosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell"];
    Todos *currentTodo = _todosArray[indexPath.row];
    cell.textLabel.text = currentTodo.todoTitle;
    return cell;
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _todosArray = [[NSArray alloc] init];
    _todosArray = [self fetchTodos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _todosArray = [self fetchTodos];
    [_todosTableView reloadData];
//    NSLog(@"%li", _todosArray.count);
//    for (Todos *todo in _todosArray) {
//        NSLog(@"%@", todo.todoTitle);
//        NSLog(@"%@", todo);
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
