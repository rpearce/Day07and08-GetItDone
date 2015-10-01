//
//  DetailViewController.h
//  GetItDone
//
//  Created by Robert Pearce on 9/30/15.
//  Copyright © 2015 Robert Pearce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todos.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Todos *currentTodo;

@end
