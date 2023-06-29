#!/bin/bash

FRONTEND_REPO_URL="https://github.com/szymonbartanowicz/jakwywioze-frontend.git"
BACKEND_REPO_URL="https://github.com/happy531/jakwywioze-backend.git"
WEB_CRAWLER_REPO_URL="https://github.com/inoasasyn/Jakwywioze_web_crawler.git"

git clone $FRONTEND_REPO_URL frontend
git clone $BACKEND_REPO_URL backend
git clone $WEB_CRAWLER_REPO_URL web-crawlers

cd frontend || exit
npm install

cd ../backend || exit
mvn clean install

