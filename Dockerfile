# Processum Server — Runtime Container Image
FROM debian:bookworm-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

ARG TARGETARCH=amd64
COPY bin/processum-server-linux-${TARGETARCH} /app/processum-server
RUN chmod +x /app/processum-server

EXPOSE 3000

ENV PORT=3000
ENV HOST=0.0.0.0
ENV NODE_ENV=production

ENTRYPOINT ["/app/processum-server"]
