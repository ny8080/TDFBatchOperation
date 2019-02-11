//
//  TDFChangeApplicableProtocol.h
//  Pods
//
//  Created by tripleCC on 10/28/16.
//
//

#import "TDFChangableProtocol.h"
@protocol TDFChangeApplicableProtocol <TDFChangableProtocol>
@required
- (void (^)(id source, id target))applyChangesBlock;
@end
