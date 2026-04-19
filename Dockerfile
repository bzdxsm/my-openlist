FROM alpine:latest

RUN apk add --no-cache wget ca-certificates

WORKDIR /app

RUN wget https://github.com/c-wa/OpenList/releases/download/v1.4/openlist_linux_amd64.tar.gz && \
    tar -zxvf openlist_linux_amd64.tar.gz && \
    chmod +x openlist && \
    rm openlist_linux_amd64.tar.gz

EXPOSE 5244

CMD ["./openlist", "server", "--port", "5244"]
