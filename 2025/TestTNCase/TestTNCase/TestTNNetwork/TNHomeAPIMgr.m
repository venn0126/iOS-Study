//
//  TNHomeAPIMgr.m
//  TestHookEncryption
//
//  Created by Augus Venn on 2025/5/15.
//

#import "TNHomeAPIMgr.h"

@interface TNHomeAPIMgr ()

@end

@implementation TNHomeAPIMgr

- (instancetype)init {
    self = [super init];
    if(!self) return nil;
    self.paramSource = self;
    self.delegate = self;
    self.validator = self;
    
    // 配置网络环境
    [TNNetworkConfig sharedConfig].defaultEnvironment = TNServiceAPIEnvironmentDevelop;
    [TNNetworkConfig sharedConfig].enableDebugLog = YES;
    
    // 启动网络状态监听
    [[TNReachability sharedInstance] startMonitoring];
    
    return self;
}

#pragma mark - TNAPIManager
- (NSString *)methodName {
    return @"topo_news/recommend_news_card";
}

- (NSString *)serviceIdentifier {
    return @"TNHomeService";
}

- (TNAPIManagerRequestType)requestType {
    return TNAPIManagerRequestTypeGet;
}

#pragma mark - TNAPIManagerParamSource
- (NSDictionary *)paramsForApi:(TNAPIBaseManager *)manager {
    // 返回请求参数
    return @{
        @"user_id": @"12346",
    };
}


#pragma mark - TNAPIManagerDataReformer
- (id)manager:(TNAPIBaseManager *)manager reformData:(NSDictionary *)data {
        // 将原始数据转换为模型对象
    TLog(@"TNAPIManagerDataReformer reformData----%@",data);
    return data;
}

#pragma mark - TNAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(TNAPIBaseManager *)manager {
    
    
    // 使用reformer获取处理后的数据
    id data = [manager fetchDataWithReformer:self];
    TLog(@"homeAPIMgr managerCallAPIDidSuccess--%@",data);
    
}

- (void)managerCallAPIDidFailed:(TNAPIBaseManager *)manager {
    
    NSString *errorMessage = manager.errorMessage ?: @"未知错误";
    TLog(@"homeAPIMgr managerCallAPIDidFailed-%@",errorMessage);
}

#pragma mark - TNAPIManagerValidator
- (TNAPIManagerErrorType)manager:(TNAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *_Nullable)data {
    TLog(@"TNAPIManagerValidator isCorrectWithCallBackData--%@",data);
    return TNAPIManagerErrorTypeNoError;
}
- (TNAPIManagerErrorType)manager:(TNAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *_Nullable)data {
    
    TLog(@"TNAPIManagerValidator isCorrectWithCallBackData--%@",data);
    return TNAPIManagerErrorTypeNoError;
}


@end
