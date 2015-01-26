//
//  CXAVCloud.cpp
//  BeiBei2DXLua
//
//  Created by Bemoo on 1/23/15.
//
//

#include "CXAVCloud.h"
#include "CCLuaEngine.h"
#include "platform/android/jni/JniHelper.h"

#define JAVA_PKG "c/bb/dc/BBNDK"

using namespace cocos2d;

void CXAVCloud::callAVCloudFunction(const std::string& func, const std::string& parameters/*json*/, CXLUAFUNC callback) {
    m_callback = callback;
    
    retain();
    CCLOG("CXAVCloud::callAVCloudFunction 1");

    cocos2d::JniMethodInfo t;
    if (cocos2d::JniHelper::getStaticMethodInfo(t, JAVA_PKG, "callAVCloudFunc", "(Ljava/lang/String;Ljava/lang/String;J)V")) {
        jstring stringArg_func = t.env->NewStringUTF(func.c_str());
        jstring stringArg_parameters = t.env->NewStringUTF(parameters.c_str());

        long addr = (long)this;
        CCLOG("CXAVCloud::callAVCloudFunction 2, func:%s, addr:%ld, callback:%d", func.c_str(), addr, callback);
        CCLOG("CXAVCloud::callAVCloudFunction 2, parameters:%s", parameters.c_str());
        t.env->CallStaticVoidMethod(t.classID, t.methodID, stringArg_func, stringArg_parameters, (jlong)addr);
        CCLOG("CXAVCloud::callAVCloudFunction 3, func:%s", func.c_str());
        t.env->DeleteLocalRef(stringArg_func);
        t.env->DeleteLocalRef(stringArg_parameters);
        t.env->DeleteLocalRef(t.classID);
    }
}