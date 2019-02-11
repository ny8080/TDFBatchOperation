//
//  TDFSelectableProtocol.h
//  Pods
//
//  Created by tripleCC on 10/21/16.
//
//

#ifndef TDFSelectableProtocol_h
#define TDFSelectableProtocol_h

@protocol TDFSelectableProtocol <NSObject>
@required
- (BOOL)selected;
- (void)setSelected:(BOOL)selected;

/** 直接拷到匿名分类 */
//@property (assign, nonatomic) BOOL selected;
@end

#endif /* TDFSelectableProtocol_h */
