FROM golang:alpine as builder
WORKDIR /go/src/pgbouncer_exporter
COPY . .
RUN apk --update --no-cache add git && \
        go get -d && \
        go build

FROM alpine:latest
COPY --from=builder /go/src/pgbouncer_exporter/pgbouncer_exporter  pgbouncer-exporter
EXPOSE 9127

ENTRYPOINT ["/pgbouncer-exporter"]
