# build environment
FROM node:12.2.0-alpine as build
RUN npm config set unsafe-perm true
WORKDIR /workspace
ENV PATH /workspace/node_modules/.bin:$PATH
COPY package.json /workspace/package.json
RUN npm ci
COPY . /workspace
RUN npm run build


# production environment
FROM nginx:latest
RUN mkdir /home/dev
RUN mkdir /home/dev/logs
COPY --from=build /workspace/dist/apps/dashboard /usr/share/nginx/html
# COPY ./dist/static /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/default.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
