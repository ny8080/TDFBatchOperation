//
//  NSArray+AllType.h
//  Pods
//
//  Created by tripleCC on 11/11/16.
//
//

#import <CoreFoundation/CoreFoundation.h>
#import "TDFIdentifiableProtocol.h"
#import "TDFNamableProtocol.h"


CF_EXPORT NSString *const TDFDefaultAllTypeName;

@interface NSArray (AllType)
/**
 添加全部分类
 
 一般情况下：
 obtainItemId   分类ID
 obtainItemName 分类名
 obtainParentId 父分类ID
 
 @return 添加全部分类之后的数组
 */
- (NSArray *)tdf_prefixAllType;
- (NSArray *)tdf_prefixAllTypeWithName:(const NSString *)name;
@end

@interface NSObject (AllType)
/** 是否是全部分类 */
- (BOOL)tdf_isAllType;
@end


/**
 所有类型的代理，继承Base/遵守ITreeNode只是为了兼容老代码，细分为TDFIdentifiableProtocol更加
 refactor: 去除继承Base
 */
@protocol ITreeNode;
@protocol TDFIdentifiableProtocol;
@protocol TDFNamableProtocol;

@interface TDFTreeNodeAllType : NSObject <ITreeNode, TDFIdentifiableProtocol, TDFNamableProtocol>

/** 当前类型对应的类，保证同样的操作不会崩溃 */
@property (assign, nonatomic) Class targetClass;

/** 类型名（默认‘全部分类’） */
@property (assign, nonatomic) NSString *name;

+ (instancetype)node;

/** 通过这个方法来比较是否是全部分类 */
- (BOOL)isEqual:(id)object;
@end

