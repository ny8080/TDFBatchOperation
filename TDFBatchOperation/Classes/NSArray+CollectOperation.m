//
//  NSArray+CollectOperation.m
//  Pods
//
//  Created by tripleCC on 11/2/16.
//
//
#import "NSArray+SwiftOperation.h"
#import "NSArray+CollectOperation.h"

@implementation NSArray (CollectOperation)
- (NSArray <id <TDFIdEquitableProtocol>> *)tdf_collectItemsWithId:(NSString *)itemId {
    return [self tdf_filter:^BOOL(id <TDFIdEquitableProtocol> item) {
        return [item conformsToProtocol:@protocol(TDFIdEquitableProtocol)] &&
        (([item respondsToSelector:@selector(silverBulletId)] &&
          [[item silverBulletId] isEqual:itemId]) ||
         [item isEqualWithId:itemId]);
    }];
}

- (NSInteger)tdf_indexOfObjectUsingMatchingBlock:(BOOL (^)(id))matchingblock {
    NSParameterAssert(matchingblock);
    
    for (NSInteger index = 0; index < self.count; index++) {
        if (matchingblock(self[index])) {
            return index;
        }
    }
    
    return NSNotFound;
}

- (NSInteger)tdf_indexOfObject:(id<TDFIdentifiableProtocol>)object {
    if (!self.count) return NSNotFound;
    
    for (NSInteger idx = 0; idx < self.count; idx++) {
        id objc = self[idx];
        if ([objc conformsToProtocol:@protocol(TDFIdEquitableProtocol)] &&
             [[objc id] isEqualToString:object.id]) {
            return idx;
        }
    }
    return NSNotFound;
}

- (NSArray *)tdf_collectItemsWithIndexs:(NSArray <NSNumber *>*)indexs {
    return [[indexs
        tdf_filter:^BOOL(NSNumber *item) {
            return item.integerValue < self.count && item.integerValue >= 0;
        }]
        tdf_map:^id(NSNumber *item) {
            return self[item.integerValue];
        }];
}

- (NSArray <id <TDFSelectableProtocol>> *)tdf_selectedItems {
    return [self tdf_filter:^BOOL (id <TDFSelectableProtocol> item) {
        return [item conformsToProtocol:@protocol(TDFSelectableProtocol)] &&
        item.selected;
    }];
}

- (NSArray <id <TDFChangableProtocol>> *)tdf_changedItems {
    return [self tdf_filter:^BOOL (id <TDFChangableProtocol> item) {
        return [item conformsToProtocol:@protocol(TDFChangableProtocol)] &&
        item.changed;
    }];
}

- (BOOL)tdf_anyItemSelected {
    for (id <TDFSelectableProtocol>model in self) {
        if ([model conformsToProtocol:@protocol(TDFSelectableProtocol)] &&
            model.selected) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)tdf_anyItemChanged {
    for (id <TDFChangableProtocol>model in self) {
        if ([model conformsToProtocol:@protocol(TDFChangableProtocol)] &&
            model.changed) {
            return YES;
        }
    }
    return NO;
}
@end
