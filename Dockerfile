#Build phase
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN yarn install

COPY . .
RUN yarn build

#Run phase
FROM nginx
#PORT MAP for aws
EXPOSE 80
#Copy build folder from Build phase (builder)
COPY --from=builder /app/build /usr/share/nginx/html

#docker build . 
#80 is the default port of nginx
#docker run -p 8080:80 <container_id> 