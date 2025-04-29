FROM nginx:stable-alpine
COPY ./app /usr/share/nginx/html
COPY ./app/images /usr/share/nginx/html/images
EXPOSE 80