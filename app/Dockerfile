# Build stage
FROM node:18-alpine@sha256:8d6421d663b4c28fd3ebc498332f249011d118945588d0a35cb9bc4b8ca09d9e AS build

WORKDIR /app

COPY package*.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

# Prod stage
FROM nginx:alpine@sha256:8491795299c8e739b7fcc6285d531d9812ce2666e07bd3dd8db00020ad132295

# OCI labels
LABEL org.opencontainers.image.title="ECS Threat Composer"
LABEL org.opencontainers.image.description="Threat modeling application for AWS"
LABEL org.opencontainers.image.source="https://github.com/AhmedMHCodeLab/ECS-Project-V1"
LABEL org.opencontainers.image.licenses="MIT"

COPY --from=build /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

#I use 30-second intervals because it balances failure detection speed with overhead - 
#checking every 10 seconds adds unnecessary CPU/network load for a static site. The 
#3-second timeout is aggressive enough for nginx which should respond instantly. 
#The 5-second start period gives nginx time to initialize, though it starts in under 
#a second usually. Three retries prevent false positives from transient network issues 
#while still failing within 90 seconds total.

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]