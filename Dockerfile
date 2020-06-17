FROM node:lts-alpine

# Create destination directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Update and install dependencies
RUN apk update && apk upgrade
RUN apk add git

# Copy the app, except .dockerignore
COPY . /usr/src/app/
RUN npm install

#RUN /usr/local/bin/node /usr/src/app/node_modules/fibers/build

RUN npm run build

# Expose 3000 on container
EXPOSE 3000

# Set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0

# Set app port
ENV NUXT_PORT=3000

# Start the app
CMD ["npm", "run", "start"]
