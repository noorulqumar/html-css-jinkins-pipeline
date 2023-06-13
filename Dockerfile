FROM nginx:alpine
ADD . /usr/share/nginx/html
EXPOSE 3000