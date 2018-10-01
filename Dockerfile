# BUILD PHASE
FROM node:alpine as build
# CREATE/MOVE TO /app
WORKDIR '/app'
# PULL OVER DEPS
COPY package.json .
# INSTALL DEPS
RUN npm install
# NOW COPY APP OVER
COPY . .
# CREATE BUILD
RUN npm run build

## RUN PHASE
FROM nginx:1.14.0-alpine
##/app/build will have the guts of our app
COPY --from=build /app/build /usr/share/nginx/html
## NGINX AUTO STARTS!