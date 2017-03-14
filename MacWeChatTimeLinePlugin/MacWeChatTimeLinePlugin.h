//
//  MacWeChatTimeLinePlugin.h
//  MacWeChatTimeLinePlugin
//
//  Created by test on 2017/3/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JRSwizzle.h"

//! Project version number for MacWeChatTimeLinePlugin.
FOUNDATION_EXPORT double MacWeChatTimeLinePluginVersionNumber;

//! Project version string for MacWeChatTimeLinePlugin.
FOUNDATION_EXPORT const unsigned char MacWeChatTimeLinePluginVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MacWeChatTimeLinePlugin/PublicHeader.h>


#define CBGetClass(classname) objc_getClass(#classname)
#define CBRegisterClass(superclassname, subclassname) { Class class = objc_allocateClassPair(CBGetClass(superclassname), #subclassname, 0);objc_registerClassPair(class); }
#define CBHookInstanceMethod(classname, ori_sel, new_sel) { NSError *error; [CBGetClass(classname) jr_swizzleMethod:ori_sel withMethod:new_sel error:&error]; if(error) NSLog(@"%@", error); }
#define CBHookClassMethod(classname, ori_sel, new_sel) { NSError *error; [CBGetClass(classname) jr_swizzleClassMethod:ori_sel withClassMethod:new_sel error:&error]; if(error) NSLog(@"%@", error); }
#define CBGetInstanceValue(obj, valuename) object_getIvar(obj, class_getInstanceVariable([obj class], #valuename))
#define CBSetInstanceValue(obj, valuename, value) object_setIvar(obj, class_getInstanceVariable([obj class], #valuename), value)

