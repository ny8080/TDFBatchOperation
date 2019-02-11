//
//  TDFEditableProtocol.h
//  TDFBatchOperation
//
//  Created by tripleCC on 1/18/17.
//  Copyright © 2017 tripleCC. All rights reserved.
//

#ifndef TDFEditableProtocol_h
#define TDFEditableProtocol_h

@protocol TDFModifiableProtocol <NSObject>
@required
- (BOOL)modifiable;
- (void)setModifiable:(BOOL)modifiable;

/** 直接拷到匿名分类 */
//@property (assign, nonatomic) BOOL modifiable;
@end


#endif /* TDFEditableProtocol_h */
