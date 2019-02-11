//
//  NSArray+SwiftOperation.h
//  Pods
//
//  Created by tripleCC on 11/2/16.
//
//

#import <Foundation/Foundation.h>

@interface NSArray <T> (SwiftOperation)
/** -> swift map / instancetype will execute generic lint, so use NSArray instead */
- (NSArray *)tdf_map:(id (^)(T value))block;
/** -> swift filter */
- (instancetype)tdf_filter:(BOOL (^)(T value))block;
/** -> swift reduce */
- (id)tdf_foldLeftWithStart:(id)start reduce:(id (^)(id result, T next))reduce;
/** -> swift forEach */
- (void)tdf_forEach:(void (^)(T value))block;

- (NSArray *)tdf_flatten;
@end
