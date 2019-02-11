//
//  TDFChangableProtocol.h
//  Pods
//
//  Created by tripleCC on 10/28/16.
//
//

@protocol TDFChangableProtocol <NSObject>
@required
- (BOOL)changed;
- (void)setChanged:(BOOL)changed;

/** 直接拷到匿名分类 */
//@property (assign, nonatomic) BOOL changed;
@end
