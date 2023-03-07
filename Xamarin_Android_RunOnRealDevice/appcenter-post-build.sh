#!/usr/bin/env bash

echo "RunOnRealDevice Starting"

if [ -z "$AppCenterTokenForTest" ]
then 
    echo "This script only runs within the context of App Center builds"
    exit
fi

echo "List Varibles"
echo "APPPATH " $APPPATH
echo "BUILDDIR " $BUILDDIR
echo "TESTSERIES " $TESTSERIES
echo "DEVICESET " $DEVICESET
echo "App Center App Name " $APP
echo "TestParamater " $TestParamater
echo "GITCLONEURLUITEST " $GITCLONEURLUITEST
echo "UITestDirectory " $UITestDirectory
echo "UITESTBranch " $UITESTBranch

echo "CURRENT FOLDER"
pwd

echo "clone " $GITCLONEURLUITEST
git clone $GITCLONEURLUITEST

echo "Checout " $UITESTBranch
git branch --all
git checkout $UITESTBranch

echo "ls " $UITestDirectory
pwd
ls $UITestDirectory

echo "AppCenter Login"
appcenter login --token $AppCenterTokenForTest

echo "appcenter test run uitest"
appcenter test run uitest --app-path $APPPATH --app $APP --devices $DEVICESET --test-series $TESTSERIES --locale en_US -p $TestParamater --build-dir $UITestDirectory --uitest-tools-dir $UITestDirectory --debug --quiet --token $AppCenterTokenForTest

echo "RunOnRealDevice Complete"