FROM alpine/git AS clone
WORKDIR /src
RUN git clone --depth 1 https://github.com/fredsted/webhook.site.git /src

FROM node:8 AS build
WORKDIR /src
COPY --from=clone /src .
RUN npm install && npm run gulp

FROM nginx:stable-alpine
WORKDIR /var/www/html
COPY default.conf /etc/nginx/conf.d/
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY --from=build /src/public ./public
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]
