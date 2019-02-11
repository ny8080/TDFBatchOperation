//
//  NSArray+CollectOperation.h
//  Pods
//
//  Created by tripleCC on 11/2/16.
//
//

#import <Foundation/Foundation.h>
#import "TDFIdEquitableProtocol.h"
#import "TDFSelectableProtocol.h"
#import "TDFChangableProtocol.h"
#import "TDFIdentifiableProtocol.h"

@interface NSArray (CollectOperation)
/**
 获取数组中Id一致的item
 
 @param id 对比的id
 
 @return id一致的item
 */
- (__kindof NSArray <id <TDFIdEquitableProtocol>> *)tdf_collectItemsWithId:(NSString *)id;


/**
 根据block获取数组元素索引

 @param matchingblock 匹配bloc
 @return 索引
 */
- (NSInteger)tdf_indexOfObjectUsingMatchingBlock:(BOOL(^)(id))matchingblock;

/**
 根据id来获取在数组中的索引

 @param object 对象
 @return 索引
 */
- (NSInteger)tdf_indexOfObject:(id <TDFIdentifiableProtocol>)object;


/**
 获取index数组中对应的所有索引上的item
 
 @param indexs 要获取的index数组
 
 @return index数组中对应的所有索引上的item
 */
- (NSArray *)tdf_collectItemsWithIndexs:(NSArray <NSNumber *>*)indexs;

/**
 获取选中的item

 @return 选中的item
 */
- (__kindof NSArray <id <TDFSelectableProtocol>> *)tdf_selectedItems;

/**
 获取已改变的item

 @return 已改变的item
 */
- (__kindof NSArray <id <TDFChangableProtocol>> *)tdf_changedItems;

/**
 获取是否有item被选中

 @return 是否有item被选中
 */
- (BOOL)tdf_anyItemSelected;

/**
 获取是否有item被改变

 @return 是否有item被改变
 */
- (BOOL)tdf_anyItemChanged;
@end
