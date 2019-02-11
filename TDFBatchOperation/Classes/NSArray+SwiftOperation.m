//
//  NSArray+SwiftOperation.m
//  Pods
//
//  Created by tripleCC on 11/2/16.
//
//

#import "NSArray+SwiftOperation.h"

@implementation NSArray (SwiftOperation)
- (NSArray *)tdf_map:(id(^)(id))block {
    NSCParameterAssert(block != NULL);
    NSMutableArray *temp = [NSMutableArray array];
    for (id element in self) {
        id result = block(element);
        NSAssert(result, @"map result can't be nil");
        if (result) {
            [temp addObject:result];
        }
    }
    return temp;
}

- (NSArray *)tdf_filter:(BOOL(^)(id))block {
    NSCParameterAssert(block != NULL);
    NSMutableArray *temp = [NSMutableArray array];
    for (id element in self) {
        if (block(element)) {
            [temp addObject:element];
        }
    }
    return temp;
}

- (void)tdf_forEach:(void (^)(id))block {
    NSCParameterAssert(block != NULL);
    for (id element in self) {
        block(element);
    }
}

- (id)tdf_foldLeftWithStart:(id)start reduce:(id (^)(id, id))reduce {
    NSCParameterAssert(reduce != NULL);
    for (id value in self) {
        start = reduce(start, value);
    }
    
    return start;
}

- (NSArray *)tdf_flatten {
    NSMutableArray *temp = [NSMutableArray array];
    for (id value in self) {
        if ([value isKindOfClass:[NSArray class]]) {
            [temp addObjectsFromArray:value];
        } else {
            [temp addObject:value];
        }
    }
    return temp;
}
@end
