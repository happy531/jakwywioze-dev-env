@echo off

rem Set the environment variables.
set FRONTEND_REPO_URL="https://github.com/szymonbartanowicz/jakwywioze-frontend.git"
set BACKEND_REPO_URL="https://github.com/happy531/jakwywioze-backend.git"
set WEB_CRAWLER_REPO_URL="https://github.com/inoasasyn/Jakwywioze_web_crawler.git"

rem Clone the repositories.
git clone %FRONTEND_REPO_URL% ../jakwywioze-frontend
git clone %BACKEND_REPO_URL% ../jakwywioze-backend
git clone %WEB_CRAWLER_REPO_URL% ../jakwywioze-web-crawler

rem Install the dependencies.
cd ../jakwywioze-frontend
npm install
cd ../jakwywioze-backend
mvn clean install

rem Open the projects in IntelliJ IDEA.
cd ..
start "" "/Applications/IntelliJ IDEA.app/Contents/MacOS/idea" --add-module jakwywioze-frontend
start "" "/Applications/IntelliJ IDEA.app/Contents/MacOS/idea" --add-module jakwywioze-backend
start "" "/Applications/IntelliJ IDEA.app/Contents/MacOS/idea" --add-module jakwywioze-web-crawler
