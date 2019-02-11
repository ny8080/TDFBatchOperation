//
//  TDFBatchOperationKitTests.m
//  TDFBatchOperationKitTests
//
//  Created by tripleCC on 12/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

@import XCTest;
#import "TDFBatchOperation.h"
#import "TDFItemModel.h"
#import "TDFITreeItemModel.h"

static const NSInteger kTDFItemsCount = 10;

@interface TDFBatchOperationKitTests : XCTestCase
@property (strong, nonatomic) NSMutableArray <NSString *> *sItems;

@property (strong, nonatomic) NSMutableArray <TDFItemModel *> *items;

@property (strong, nonatomic) NSMutableArray <TDFITreeItemModel *> *iItems;
@end

@implementation TDFBatchOperationKitTests

- (void)setUp {
    [super setUp];
    
    self.items = [NSMutableArray array];
    self.iItems = [NSMutableArray array];
    self.sItems = [NSMutableArray array];
    for (NSInteger idx = 0; idx < kTDFItemsCount; idx++) {
        TDFItemModel *item = [[TDFItemModel alloc] init];
        item.id = @(idx).stringValue;
        item.name = @(idx).stringValue;
        item.changed = NO;
        item.selected = NO;
        [self.items addObject:item];
        
        TDFITreeItemModel *iItem = [[TDFITreeItemModel alloc] init];
        [self.iItems addObject:iItem];
        
        [self.sItems addObject:@(idx).stringValue];
    }
}

- (void)test_isAllType {
    NSString *name = TDFDefaultAllTypeName;
    NSArray *items = [self.sItems tdf_prefixAllTypeWithName:name];
    XCTAssert(items.count == kTDFItemsCount + 1);
    XCTAssertTrue([items.firstObject tdf_isAllType]);
    XCTAssertTrue([items.firstObject isEqual:name]);
}

- (void)test_allType {
    NSArray *items = [self.items tdf_prefixAllType];
    XCTAssert(items.count == kTDFItemsCount + 1);
    XCTAssertTrue([items.firstObject tdf_isAllType]);
    XCTAssertTrue([[(TDFItemModel *)items.firstObject name]
                   isEqualToString:TDFDefaultAllTypeName]);
    for (TDFItemModel *model in items) {
        XCTAssertNoThrow([model customMethod]);
    }
    
    items = [items tdf_prefixAllType];
    XCTAssert(items.count == kTDFItemsCount + 1);
    XCTAssertTrue([items.firstObject tdf_isAllType]);
    

    items = [self.iItems tdf_prefixAllType];
    XCTAssert(items.count == kTDFItemsCount + 1);
    XCTAssertTrue([items.firstObject tdf_isAllType]);
    XCTAssertTrue([[(TDFITreeItemModel *)items.firstObject obtainItemName]
                   isEqualToString:TDFDefaultAllTypeName]);
    for (TDFITreeItemModel *model in items) {
        XCTAssertNoThrow([model customMethod]);
    }
    
    items = [items tdf_prefixAllType];
    XCTAssert(items.count == kTDFItemsCount + 1);
    XCTAssertTrue([items.firstObject tdf_isAllType]);
    
    items = [self.sItems tdf_prefixAllType];
    XCTAssert(items.count == kTDFItemsCount + 1);
    XCTAssertTrue([items.firstObject tdf_isAllType]);
    XCTAssertTrue([items.firstObject isEqualToString:TDFDefaultAllTypeName]);
    for (NSString *model in items) {
        XCTAssertNoThrow([model length]);
    }
}

- (void)test_forEach {
    [self.items tdf_forEach:^(TDFItemModel *value) {
        value.id = nil;;
    }];
    
    for (TDFItemModel *item in self.items) {
        XCTAssertNil(item.id);
    }
}

- (void)test_reduce {
    NSString *result = [self.items tdf_foldLeftWithStart:@"" reduce:^id(id result, TDFItemModel *next) {
        return [result stringByAppendingString:next.id];
    }];
    XCTAssertEqualObjects(result, @"0123456789");
}

- (void)test_filter {
    NSArray <TDFItemModel *> *items = [self.items tdf_filter:^BOOL(TDFItemModel *value) {
        return [value.id isEqualToString:@"0"];
    }];
    
    XCTAssert(items.count == 1);
    XCTAssertEqualObjects(items.firstObject, self.items.firstObject);
}

- (void)test_map {
    NSArray *items = [self.items tdf_map:^id(TDFItemModel *value) {
        return value.id;
    }];
    
    XCTAssert(items.count == kTDFItemsCount);
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertEqualObjects(obj, self.items[idx].id);
    }];
    
}

- (void)test_collectItemsWithId {
    NSArray <TDFItemModel *> *items = [self.items tdf_collectItemsWithId:@"0"];
    XCTAssert(items.count == 1);
    XCTAssertEqualObjects(items.firstObject.id, @"0");
}

- (void)test_indexOfObject {
    TDFItemModel *item = [[TDFItemModel alloc] init];
    item.id = @"1";
    NSInteger index = [self.items tdf_indexOfObject:item];
    XCTAssert(index == 1);
}

- (void)test_indexOfObjecUsingMatchingBlock {
    NSInteger index = [self.items tdf_indexOfObjectUsingMatchingBlock:^BOOL(TDFItemModel *item) {
        return [item.id isEqual:@"1"];
    }];
    
    XCTAssert(index == 1);
}

- (void)test_collectItemsWithIndexs {
    NSArray <TDFItemModel *> *items = [self.items tdf_collectItemsWithIndexs:@[@0, @(kTDFItemsCount - 1)]];
    XCTAssert(items.count == 2);
    XCTAssert([items.firstObject isEqual:self.items.firstObject] &&
              [items.lastObject isEqual:self.items.lastObject]);
}

- (void)test_selectedItems {
    self.items[0].selected = YES;
    self.items[kTDFItemsCount - 1].selected = YES;
    NSArray <TDFItemModel *> *items = [self.items tdf_selectedItems];
    XCTAssert(items.count == 2);
    XCTAssert([items.firstObject isEqual:self.items.firstObject] &&
              [items.lastObject isEqual:self.items.lastObject]);
}

- (void)test_changedItems {
    self.items[0].changed = YES;
    self.items[kTDFItemsCount - 1].changed = YES;
    NSArray <TDFItemModel *> *items = [self.items tdf_changedItems];
    XCTAssert(items.count == 2);
    XCTAssert([items.firstObject isEqual:self.items.firstObject] &&
              [items.lastObject isEqual:self.items.lastObject]);
}

- (void)test_anyItemSelected {
    XCTAssertFalse([self.items tdf_anyItemSelected]);
    
    self.items[0].selected = YES;
    XCTAssertTrue([self.items tdf_anyItemSelected]);
}

- (void)test_anyItemChanged {
    XCTAssertFalse([self.items tdf_anyItemChanged]);
    
    self.items[0].changed = YES;
    XCTAssertTrue([self.items tdf_anyItemChanged]);
}



- (void)test_swiftOperation {
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
