//
//  TDFItemModel.h
//  TDFBatchOperationKit
//
//  Created by tripleCC on 12/24/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDFIdEquitableProtocol.h"
#import "TDFSelectableProtocol.h"
#import "TDFChangableProtocol.h"
#import "TDFIdentifiableProtocol.h"
#import "TDFNamableProtocol.h"

@interface TDFItemModel : NSObject <TDFIdEquitableProtocol, TDFSelectableProtocol, TDFChangableProtocol, TDFIdentifiableProtocol, TDFNamableProtocol>
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
- (void)customMethod;
@end
