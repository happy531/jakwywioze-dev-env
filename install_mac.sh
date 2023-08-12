#!/bin/bash

FRONTEND_REPO_URL="https://github.com/szymonbartanowicz/jakwywioze-frontend.git"
BACKEND_REPO_URL="https://github.com/happy531/jakwywioze-backend.git"
WEB_CRAWLER_REPO_URL="https://github.com/inoasasyn/Jakwywioze_web_crawler.git"

git clone $FRONTEND_REPO_URL ../jakwywioze-frontend
git clone $BACKEND_REPO_URL ../jakwywioze-backend
git clone $WEB_CRAWLER_REPO_URL ../jakwywioze-web-crawler

npm --prefix ../jakwywioze-frontend install
mvn -f ../jakwywioze-backend/pom.xml clean install

/Applications/IntelliJ IDEA.app/Contents/MacOS/idea --add-module ../jakwywioze-frontend
/Applications/IntelliJ IDEA.app/Contents/MacOS/idea --add-module ../jakwywioze-backend
/Applications/IntelliJ IDEA.app/Contents/MacOS/idea --add-module ../jakwywioze-web-crawler