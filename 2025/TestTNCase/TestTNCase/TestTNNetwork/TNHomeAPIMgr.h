//
//  TNHomeAPIMgr.h
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/15.
//

#import "TNAPIBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TNHomeAPIMgr : TNAPIBaseManager<TNAPIManager,TNAPIManagerParamSource, TNAPIManagerDataReformer, TNAPIManagerCallBackDelegate, TNAPIManagerValidator>



@end

NS_ASSUME_NONNULL_END
