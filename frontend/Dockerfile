FROM node:14.17.0-alpine3.13
WORKDIR /app
COPY . /app
RUN npm install
EXPOSE 8080
ENV NODE_ENV=production
CMD ["npm", "run", "serve"]