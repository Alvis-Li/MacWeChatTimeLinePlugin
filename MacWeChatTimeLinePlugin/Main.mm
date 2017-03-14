//
//  Main.c
//  MacWeChatTimeLinePlugin
//
//  Created by test on 2017/3/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import "Main.h"
#import "MMCGIConfig.h"
#import "SnsTimeLineResponse.h"
#import "SnsTimeLineRequest.h"
#import "MMCGIRequestUtil.h"
#import "MMCGIService.h"
#import "MMCGIWrap.h"
#import "MMServiceCenter.h"
#import "SnsObject.h"
#import "SKBuiltinBuffer_t.h"

typedef struct MMCGIItem
{
    int _field1;
    int _field2;
    int _field3;
    const char *_field4;
    Class _field5;    
    int _field6;
    int _field7;
    int _field8;
} MMCGIItem;

@interface MMTimeLineMgr:NSObject <MMCGIDelegate, MMService>
@end

@implementation MMTimeLineMgr

- (void)updateTimeLineHead {
    SnsTimeLineRequest *request = [[CBGetClass(SnsTimeLineRequest) alloc] init];
    request.baseRequest = [CBGetClass(MMCGIRequestUtil) InitBaseRequestWithScene:0];
    request.clientLatestId = 0;
    request.firstPageMd5 = @"";
    request.lastRequestTime = 0;
    request.maxId = 0;
    request.minFilterId = 0;
    
    MMCGIWrap *cgiWrap = [[CBGetClass(MMCGIWrap) alloc] init];
    cgiWrap.m_requestPb = request;
    cgiWrap.m_functionId = 211;
    
    MMCGIService *cgiService = [[CBGetClass(MMServiceCenter) defaultCenter] getService:CBGetClass(MMCGIService)];
    NSUInteger sessionId = [cgiService RequestCGI:cgiWrap delegate:self];
    NSLog(@"sessionId:%lu", (unsigned long)sessionId);
    // 重试
    if (sessionId <= 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"request for timeline");
            [self updateTimeLineHead];
        });
    }
}
- (void)OnResponseCGI:(BOOL)arg1 sessionId:(unsigned int)arg2 cgiWrap:(id)arg3 {
    NSLog(@"OnResponseCGI %d %d %@", arg1, arg2, arg3);
    if ([arg3 isKindOfClass:CBGetClass(MMCGIWrap)]) {
        MMCGIWrap *wrap = (MMCGIWrap *)arg3;
        if ([wrap.m_responsePb isKindOfClass:CBGetClass(SnsTimeLineResponse)]) {
            SnsTimeLineResponse *response = (SnsTimeLineResponse *)wrap.m_responsePb;
            NSLog(@"list:%@",@(response.mutableObjectListList.count));
        NSLog(@"\n###################################################################################\n###################################################################################\n");
            for (SnsObject *aSnsObj in response.mutableObjectListList) {
                NSLog(@"nickname:%@",aSnsObj.nickname);
                NSLog(@"username:%@",aSnsObj.username);
                NSString *objectDesc = [[NSString alloc] initWithData:aSnsObj.objectDesc.buffer encoding:NSUTF8StringEncoding];
                NSLog(@"objectDesc:\n%@",objectDesc);
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.locale = [NSLocale currentLocale];
                dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *dateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:aSnsObj.createTime]];
                NSLog(@"createtime:%@",dateString);
            NSLog(@"\n###################################################################################\n###################################################################################\n");
            }
        }
    }    
}
@end

@implementation NSObject (MacWeChatTimeLinePlugin)
#pragma mark - MMCGIConfig
- (MMCGIItem *)cb_findItemWithFuncInternal:(int)arg1 {
    struct MMCGIItem *res = [self cb_findItemWithFuncInternal:arg1];
    if (arg1 == 211) {
        res = (MMCGIItem *)malloc(sizeof(struct MMCGIItem));
        res->_field1 = 211;
        res->_field2 = 0;
        res->_field3 = 0;
        res->_field4 = "mmsnstimeline";
        res->_field5 = CBGetClass(SnsTimeLineResponse);
        res->_field6 = 1;
        res->_field7 = 2;
        res->_field8 = 0;
    }
    return res;
}
@end
static void __attribute__((constructor)) initialize(void) {
    NSLog(@"++++++++ MacWeChatTimeLinePlugin loaded ++++++++");
    CBHookInstanceMethod(MMCGIConfig, @selector(findItemWithFuncInternal:), @selector(cb_findItemWithFuncInternal:));
    // 10秒内登录
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"request for timeline");
        MMTimeLineMgr *mgr = [MMTimeLineMgr new];
        [mgr updateTimeLineHead];
    });
}
