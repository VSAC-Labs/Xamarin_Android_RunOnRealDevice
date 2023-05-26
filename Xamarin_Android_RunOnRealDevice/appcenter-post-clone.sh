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
echo "CURRENT FOLDER" pwd

echo "appcenter -v"
appcenter -v

echo "npm update appcenter-cli --latest"
npm update appcenter-cli --latest

echo "npm list appcenter-cli"
npm list appcenter-cli

echo "npm update appcenter --latest"
npm update appcenter --latest

echo "appcenter -v"
appcenter -v

echo "appcenter test generate uitest --platform android --output-path /Users/runner/work/1/a/GeneratedTest"
appcenter test generate uitest --platform android --output-path /Users/runner/work/1/a/GeneratedTest

echo "nuget restore -NonInteractive /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android.sln"
nuget restore -NonInteractive /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android.sln

echo "xbuild /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android.sln /p:Configuration=Release"
xbuild /Users/runner/work/1/a/GeneratedTest/AppCenter.UITest.Android.sln /p:Configuration=Release

