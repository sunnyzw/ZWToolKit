//
//  ZWNetwork.m
//  ZWToolKit
//
//  Created by 5i5j on 2023/2/2.
//

#import "ZWNetwork.h"

static ZWNetwork *afnManager;

@implementation ZWNetwork

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* baseUrl = [LocalFileSystem sharedManager].baseURL;
        afnManager = [self requestWithBaseUrl:baseUrl];
    });
    [afNetworkManager addDeviceHeader];
    return afnManager;
}

+ (instancetype)requestWithBaseUrl:(NSString*)baseUrl {
    ZWNetwork *manager = [[[self class] alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    manager.operationQueue.maxConcurrentOperationCount=4;
    AFHTTPRequestSerializer *requestSerializer = manager.requestSerializer;
    [requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [requestSerializer setTimeoutInterval:30];
    [requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [requestSerializer setStringEncoding:NSUTF8StringEncoding];
    [requestSerializer setHTTPShouldHandleCookies:YES];
//    requestSerializer = requestSerializer;
    //--
    // 设备UDID
    [requestSerializer setValue:[DeviceInfo getDeviceId] forHTTPHeaderField:@"deviceId"];
    NSString *iosVersion = [[UIDevice currentDevice] systemVersion];
    // 系统版本号
    [requestSerializer setValue:iosVersion forHTTPHeaderField:@"osVersion"];
    NSString *deviceType = [DeviceInfo getDeviceType];
    // 手机设备型号
    [requestSerializer setValue:deviceType forHTTPHeaderField:@"deviceType"];
    // 代表是安卓还是ios的标识
    [requestSerializer setValue:@"ios" forHTTPHeaderField:@"deviceSource"];
    // 版本控制 兼容老版本使用
    [requestSerializer setValue:KAPIVERSION forHTTPHeaderField:@"apiversion"];
//    [requestSerializer setValue:@"20190129" forHTTPHeaderField:@"User-Agent"];
    NSString* appId = kAppBundleId;
    [requestSerializer setValue:appId forHTTPHeaderField:@"appId"];
    //程序版本号
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [requestSerializer setValue:appVersion forHTTPHeaderField:@"appVersion"];
//    [requestSerializer setValue:@"4.5.0" forHTTPHeaderField:@"appVersion"];
    //数美deviceid
    NSString *smdeviceId = [[SmAntiFraud shareInstance] getDeviceId];
    if (smdeviceId.length > 0 && ![smdeviceId containsString:@"null"]) {
        [requestSerializer setValue:smdeviceId forHTTPHeaderField:@"smdeviceId"];
    }
    //顶象deviceid
    NSString *dxDevieceID = [UserData sharedUserData].dxDeviceID;
    if (dxDevieceID.length > 0) {
        [requestSerializer setValue:dxDevieceID forHTTPHeaderField:@"dxdeviceId"];
    }
    //顶象硬件指纹
    NSString *dxfingerprint = [UserData sharedUserData].dxfingerprint;
    if (dxfingerprint.length > 0) {
        [requestSerializer setValue:dxfingerprint forHTTPHeaderField:@"dxfingerprint"];
    }

    
    AFJSONResponseSerializer *res = [AFJSONResponseSerializer serializer];
    res.acceptableContentTypes = [afRequestManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    res.removesKeysWithNullValues = YES;// 网络请求空字符 NULL 过滤
    afRequestManager.responseSerializer = res;
    return afRequestManager;
}

@end
