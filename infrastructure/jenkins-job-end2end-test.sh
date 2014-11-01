#!/bin/sh

TEST_SERVER=$1
echo "Running End2End Test $TEST_SERVER"

npm install
export CHROME_BIN=/usr/bin/chromium-browser

echo "Kill Selenium Process"
PID=`ps aux | grep node | grep webdriver | awk '{print $2}'`
sudo kill -9 $PID 

echo "Install npm packages and reporters"
npm install jasmine-reporters

echo "Start WebDriver Manager"
webdriver-manager start &

echo "Update IP"
find e2e/conf.js -type f -print0 | xargs -0 sed -i "s/localhost:9000/$TEST_SERVER:9000/g"

echo "Start E2E test"
protractor e2e/conf.js

echo "Kill Selenium Process"
PID=`ps aux | grep node | grep webdriver | awk '{print $2}'`
sudo kill -9 $PID
