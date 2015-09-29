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

@interface ViewController ()

@property (nonatomic, strong) AppDelegate            *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak)   IBOutlet UITextField   *titleTextField;
@property (nonatomic, weak)   IBOutlet UITableView   *todosTableView;
@property (nonatomic, strong) NSArray                *todosArray;

@end

@implementation ViewController

#pragma mark - Core Data Methods

- (void)addTodo:(NSString *)todoTitle {
    Todos *newTodo = (Todos *)[NSEntityDescription insertNewObjectForEntityForName:@"Todos" inManagedObjectContext:_managedObjectContext];
    newTodo.todoTitle = todoTitle;
    newTodo.dateEntered = [NSDate date];
    newTodo.userID = @"Robert";
    [_appDelegate saveContext];
};

- (void)tempLogTodos {
    NSLog(@"%li", _todosArray.count);
    for (Todos *todo in _todosArray) {
        NSLog(@"%@", todo.todoTitle);
        NSLog(@"%@", todo);
    }
}

- (NSArray *)fetchTodos {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todos" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchResults;
}

#pragma mark - Interactivity Methods

- (IBAction)addTodoButtonPressed:(UIButton *)button {
    [self addTodo:_titleTextField.text];
    _todosArray = [self fetchTodos];
    _titleTextField.text = @"";
    [_todosTableView reloadData];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _todosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell"];
    Todos *todo = [_todosArray objectAtIndex:indexPath.row];
    cell.textLabel.text = todo.todoTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"%@li", indexPath);
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = _appDelegate.managedObjectContext;
    _todosArray = [self fetchTodos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
