FROM alpine:edge AS builder
RUN apk add --no-cache build-base git go
WORKDIR /hello
ADD . .
RUN CGO_ENABLED=0 go build -o server -v .

FROM alpine:edge
RUN apk add --no-cache ca-certificates tzdata
EXPOSE 8080
COPY --from=builder /hello/server /
CMD /server
