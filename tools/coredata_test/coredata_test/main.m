//
//  main.m
//  coredata_test
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//
#import "stdlib.h"
static NSManagedObjectModel *managedObjectModel()
{
    static NSManagedObjectModel *model = nil;
    if (model != nil) {
        return model;
    }
    
    NSString *path = @"coredata_test";
    path = [path stringByDeletingPathExtension];
    NSURL *modelURL = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"momd"]];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return model;
}

static NSManagedObjectContext *managedObjectContext()
{
    static NSManagedObjectContext *context = nil;
    if (context != nil) {
        return context;
    }

    @autoreleasepool {
        context = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel()];
        [context setPersistentStoreCoordinator:coordinator];
        
        NSString *STORE_TYPE = NSSQLiteStoreType;
        
        NSString *path = [[NSProcessInfo processInfo] arguments][0];
        path = [path stringByDeletingPathExtension];
        NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"sqlite"]];
        
        NSError *error;
        NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:nil error:&error];
        
        if (newStore == nil) {
            NSLog(@"Store Configuration Failure %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        }
    }
    return context;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        // Create the managed object context
        NSManagedObjectContext *context = managedObjectContext();
        
        // Custom code here...
        // Save the managed object context
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error while saving %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
            exit(1);
        }
        NSError* err = nil;
        NSString* dataPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"1.json"];
        NSLog(@"Path: %@", dataPath);
        
        NSArray* cards = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
        NSLog(@"Imported Banks: %@", cards);
        

        //import data
        [cards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSManagedObject *new_card = [NSEntityDescription
                                              insertNewObjectForEntityForName:@"Card"
                                              inManagedObjectContext:context];
            [new_card setValue: [obj objectForKey:@"name"] forKey:@"name"];
            [new_card setValue: [obj objectForKey:@"id"] forKey:@"id"];
            [new_card setValue: [obj objectForKey:@"rarity"] forKey:@"rarity"];
            [new_card setValue: [obj objectForKey:@"type"] forKey:@"type"];
            [new_card setValue: [obj objectForKey:@"cost"] forKey:@"cost"];
            if ([obj objectForKey:@"playerClass"]!=nil){
                [new_card setValue: [obj objectForKey:@"playerClass"] forKey:@"playerClass"];
            }
            NSError *error;
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }];
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Card"
                                                  inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        NSLog(@"Count: %lu",(unsigned long)[fetchedObjects count]);
        

    }
    return 0;
}

