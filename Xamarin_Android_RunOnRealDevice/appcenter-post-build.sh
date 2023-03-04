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
echo "BUILDSCRIPT " $BUILDSCRIPT
echo "MANIFEST " $MANIFEST
echo "TESTSERIES " $TESTSERIES
echo "DEVICESET " $DEVICESET
echo "APP " $APP
echo "TestParamater " $TestParamater
echo "UITestProject " $UITestProject
echo "UITestTools " $UITestTools
echo "UITESTBranch " $UITESTBranch
echo "GITCLONEURLUITEST " $GITCLONEURLUITEST

echo "CURRENT FOLDER"
pwd

echo "clone " $GITCLONEURLUITEST
git clone $GITCLONEURLUITEST

echo "switch to UITEST branch "$UITESTBranch
git branch --all
git checkout $UITESTBranch

echo "Nuget Restore"
cd AppCenter_Generated_UITest_Base
pwd
nuget restore

echo "AppCenter Login"
appcenter login --token $AppCenterTokenForTest

echo "Copy UITest files into the build directory "$BUILDDIR
cp -r /Users/runner/work/1/s/AppCenterXamrain_Test_Example/UITEST_Base $BUILDDIR

echo "appcenter test run uitest"
appcenter test run uitest --app-path $APPPATH --app $APP --devices $DEVICESET --test-series $TESTSERIES --locale en_US -p $TestParamater --build-dir $UITestProject --uitest-tools-dir $UITestTools --debug --quiet --token $AppCenterTokenForTest

echo "RunOnRealDevice Complete"