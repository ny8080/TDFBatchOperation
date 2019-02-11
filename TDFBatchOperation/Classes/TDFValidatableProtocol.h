//
//  TDFValidatableProtocol.h
//  Pods
//
//  Created by tripleCC on 12/21/16.
//
//

#ifndef TDFValidatableProtocol_h
#define TDFValidatableProtocol_h


/**
 校验block

 @param value 校验对象
 @return 成功 YES  失败NO
 */
typedef BOOL (^TDFFormatValidBlock)(id value);

@protocol TDFValidatableProtocol <NSObject>
@required

- (BOOL)valid;

/** 校验标题 */
- (NSString *)validatedTitle;

@end

@protocol TDFFormatValidatableProtocol <TDFValidatableProtocol>
@required

/** 校验对象 */
- (id)validatedObject;

/** 校验block */
- (void)setFormatValidBlock:(TDFFormatValidBlock)formatValidBlock;
- (TDFFormatValidBlock)formatValidBlock;

//@property (copy, nonatomic) TDFFormatValidBlock formatValidBlock;
@optional
/**
 校验信息（优先级比validatedTitle高）
 校验出错时显示
 */
- (NSString *)validatedMessage;
- (void)setValidatedMessage:(NSString *)validatedMessage;
@end

#endif /* TDFValidatableProtocol_h */
