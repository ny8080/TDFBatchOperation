//
//  TDFItemModel.m
//  TDFBatchOperationKit
//
//  Created by tripleCC on 12/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import "TDFItemModel.h"

@interface TDFItemModel()
@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) BOOL changed;
@end

@implementation TDFItemModel
- (BOOL)isEqualWithId:(NSString *)id {
    return [self.id isEqualToString:id];
}

- (const NSString *)silverBulletId {
    return TDFSilverBulletId;
}

- (void)customMethod {
    
}
@end
