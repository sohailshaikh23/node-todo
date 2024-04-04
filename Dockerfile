FROM node:12.2.0-alpine
LABEL creator="the owner of the dockerfile"
MAINTAINER "dummymail@gmail.com"
WORKDIR /todo_app
COPY . .
RUN npm install
EXPOSE 8000
ENTRYPOINT ["node"]
CMD ["app.js"]
