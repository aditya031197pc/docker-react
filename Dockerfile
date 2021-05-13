FROM node:alpine as builder

USER node
 
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
 
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./   
RUN npm run build


FROM nginx
# we will now only copy the stuff that we really need
COPY --from=builder /home/node/app/build /usr/share/nginx/html
# default command of nginx starts the server up itself.