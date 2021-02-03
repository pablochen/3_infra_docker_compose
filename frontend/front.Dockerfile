FROM node as build-stage
MAINTAINER bogenarc@gmail.com
WORKDIR /app
ADD . .
RUN yarn install
RUN yarn run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY  ./nginx/conf.d/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]