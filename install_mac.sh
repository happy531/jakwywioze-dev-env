#!/bin/bash

FRONTEND_REPO_URL="https://github.com/szymonbartanowicz/jakwywioze-frontend.git"
BACKEND_REPO_URL="https://github.com/happy531/jakwywioze-backend.git"
WEB_CRAWLER_REPO_URL="https://github.com/inoasasyn/Jakwywioze_web_crawler.git"

git clone $FRONTEND_REPO_URL ~/IdeaProjects/jakwywioze-frontend
git clone $BACKEND_REPO_URL ~/IdeaProjects/jakwywioze-backend
git clone $WEB_CRAWLER_REPO_URL ~/IdeaProjects/jakwywioze-web-crawler

npm --prefix ../jakwywioze-frontend install
mvn -f ../jakwywioze-backend/pom.xml clean install