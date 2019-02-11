//
//  TDFIdEquitableProtocol.h
//  Pods
//
//  Created by tripleCC on 10/25/16.
//
//
#import <CoreFoundation/CoreFoundation.h>

/** 银弹Id［匹配所有条件］ */
CF_EXPORT const NSString *TDFSilverBulletId;

@protocol TDFIdEquitableProtocol <NSObject>
@required
- (BOOL)isEqualWithId:(NSString *)id;
@optional
/** 银弹Id［匹配所有条件］ */
- (const NSString *)silverBulletId;
@end

