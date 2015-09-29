//
//  Todos+CoreDataProperties.h
//  GetItDone
//
//  Created by Robert Pearce on 9/29/15.
//  Copyright © 2015 Robert Pearce. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Todos.h"

NS_ASSUME_NONNULL_BEGIN

@interface Todos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *todoTitle;
@property (nullable, nonatomic, retain) NSDate *dateEntered;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSDate *dateUpdated;
@property (nullable, nonatomic, retain) NSNumber *todoCompleted;

@end

NS_ASSUME_NONNULL_END
