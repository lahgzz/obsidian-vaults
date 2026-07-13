FROM node:24-slim

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /quartz

RUN git clone --branch v5 --depth 1 https://github.com/jackyzha0/quartz.git . && \
    npm ci && \
    npx quartz plugin install --from-config

RUN rm -rf content/*

COPY content content
COPY .quartz/quartz.config.yaml quartz.config.yaml

EXPOSE 8080
CMD ["npx", "quartz", "build", "--serve", "--port", "8080"]
