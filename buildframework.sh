#!/bin/sh

config_current_path=`pwd`  #当前模块跟文件夹
config_root=$config_current_path/../..;  #总工程文件夹
config_podspec_name="CoCoRx"  #模块名称
config_framework_url=https://github.com/CoCoKit/CoCoRx-framework.git


#=====================================================

sh $config_root/Scripts/lib_core.sh $config_root $config_current_path $config_podspec_name $config_framework_url