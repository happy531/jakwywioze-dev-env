@echo off

rem Set the environment variables.
set FRONTEND_REPO_URL="https://github.com/szymonbartanowicz/jakwywioze-frontend.git"
set BACKEND_REPO_URL="https://github.com/happy531/jakwywioze-backend.git"
set WEB_CRAWLER_REPO_URL="https://github.com/inoasasyn/Jakwywioze_web_crawler.git"

rem Clone the repositories.
git clone %FRONTEND_REPO_URL% ~/IdeaProjects/jakwywioze-frontend
git clone %BACKEND_REPO_URL% ~/IdeaProjects/jakwywioze-backend
git clone %WEB_CRAWLER_REPO_URL% ~/IdeaProjects/jakwywioze-web-crawler

rem Install the dependencies.
cd ../jakwywioze-frontend
npm install
cd ../jakwywioze-backend
mvn clean install