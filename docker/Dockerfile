# Builder stage 
FROM golang:1.25 AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        ca-certificates \
        nodejs \
        npm && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN git clone --depth 1 https://github.com/usememos/memos.git .

# Build frontend 
WORKDIR /src/web

RUN npm install && npm run build

# move built frontend into the path the backend actually embeds
WORKDIR /src
RUN rm -rf server/router/frontend/dist && \
    mv web/dist server/router/frontend/dist

# Build backend
RUN go mod download

# Build a static Linux binary for Alpine runtime
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go build -o memos ./cmd/memos

# Runtime stage
FROM alpine:3.19 AS runtime

# Create non-root user
RUN addgroup -S memos && adduser -S memos -G memos

WORKDIR /var/opt/memos
RUN chown -R memos:memos /var/opt/memos

COPY --from=builder /src/memos /usr/local/bin/memos

USER memos

EXPOSE 5230

CMD ["memos", "--mode", "prod", "--port", "5230", "--data", "/var/opt/memos"]
