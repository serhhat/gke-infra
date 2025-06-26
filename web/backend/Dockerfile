# Stage 1: Build
FROM golang:1.24-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o api ./...

# Stage 2: Distroless runtime
FROM gcr.io/distroless/static-debian12

WORKDIR /app

COPY --from=builder /app/api .

EXPOSE 3000

ENTRYPOINT ["/app/api"]
