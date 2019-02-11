//
//  NSArray+AllType.m
//  Pods
//
//  Created by tripleCC on 11/11/16.
//
//
#import <objc/runtime.h>
#import <TDFCoreProtocol/TDFCoreProtocol.h>
#import "NSArray+AllType.h"
#import "TDFIdEquitableProtocol.h"

NSString *const TDFDefaultAllTypeName = @"全部分类";

@implementation NSArray (AllType)
- (NSArray *)tdf_prefixAllType {
    return [self tdf_prefixAllTypeWithName:nil];
}

- (NSArray *)tdf_prefixAllTypeWithName:(const NSString *)name {
    if (!self.count) return self;
    
    NSAssert([self.firstObject conformsToProtocol:@protocol(ITreeNode)] ||
             [self.firstObject conformsToProtocol:@protocol(TDFIdentifiableProtocol)] ||
             [self.firstObject isKindOfClass:[NSString class]],
             @"items should confirm ITreeNode or TDFIdentifiableProtocol or is kind of NSString");
    
    NSString *id = nil;
    
    if ([self.firstObject conformsToProtocol:@protocol(ITreeNode)]) {
        id = [self.firstObject obtainItemId];
    } else if ([self.firstObject conformsToProtocol:@protocol(TDFIdentifiableProtocol)]) {
        id = [self.firstObject id];
    } else if (![self.firstObject isKindOfClass:[NSString class]])  {
        return self;
    }
    
    NSMutableArray *result = self.mutableCopy;
    if (![id isEqualToString:(NSString *)TDFSilverBulletId]) {
        TDFTreeNodeAllType *all = [TDFTreeNodeAllType node];
        all.targetClass = [self.firstObject class];
        all.name = (NSString *)name;
        [result insertObject:all atIndex:0];
    }
    return result;
}
@end

@implementation NSObject (AllType)
- (BOOL)tdf_isAllType {
    NSAssert([self conformsToProtocol:@protocol(ITreeNode)] ||
             [self conformsToProtocol:@protocol(TDFIdentifiableProtocol)] ||
             [self isKindOfClass:[NSString class]],
             @"items should confirm ITreeNode or TDFIdentifiableProtocol or is kind of NSString");
    
    if ([self conformsToProtocol:@protocol(ITreeNode)]) {
        return [[(id <ITreeNode>)self obtainItemId] isEqualToString:(NSString *)TDFSilverBulletId];
    } else if ([self conformsToProtocol:@protocol(TDFIdentifiableProtocol)]) {
        return [[(id <TDFIdentifiableProtocol>)self id] isEqualToString:(NSString *)TDFSilverBulletId];
    } else {
        return [self isKindOfClass:[TDFTreeNodeAllType class]];
    }
}
@end

@interface TDFTreeNodeAllType()
@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *id;
@end

@implementation TDFTreeNodeAllType
+ (instancetype)node {
     TDFTreeNodeAllType *node = [[TDFTreeNodeAllType alloc] init];
    node._id = (NSString *)TDFSilverBulletId;
    node.id = (NSString *)TDFSilverBulletId;
    return node;
}

#pragma mark - equal
- (NSUInteger)hash {
    return [super hash];
}

- (BOOL)isEqual:(id)object {
    if ([object conformsToProtocol:@protocol(ITreeNode)]) {
        return [[(id <ITreeNode>)self obtainItemId] isEqualToString:[object obtainItemId]];
    } else if ([object conformsToProtocol:@protocol(TDFIdentifiableProtocol)]) {
        return [[(id <TDFIdentifiableProtocol>)self id] isEqualToString:[object id]];
    } else if ([object isKindOfClass:[NSString class]]) {
        return [[self name] isEqualToString:object];
    }
    return NO;
}

- (BOOL)isEqualToString:(NSString *)aString {
    return [[self name] isEqualToString:aString];
}

#pragma mark - crash defend
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (![self respondsToSelector:aSelector]) {
        NSAssert(self.targetClass, @"target class should't be nil in order to avoiding forwarding invocation");
        return [[self.targetClass alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - TDFIdentifiableProtocol
- (NSString *)obtainItemId {
    return self.id;
}

- (NSString *)obtainItemName {
    return self.name;
}

- (NSString *)obtainParentId {
    return nil;
}

- (id)copy {
    return self;
}

- (void)mId:(NSString*)itemId {
}

- (void)mName:(NSString*)itemName {
}

- (void)mParentId:(NSString*)parentId {
}

#pragma mark - getter
- (NSString *)name {
    if (!_name) {
        return TDFDefaultAllTypeName;
    }
    return _name;
}
@end

