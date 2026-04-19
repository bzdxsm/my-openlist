FROM alpine:latest

RUN apk add --no-cache wget ca-certificates

WORKDIR /app

RUN wget https://github.com/OpenListTeam/OpenList/releases/download/v4.2.1/openlist-linux-amd64.tar.gz && \
    tar -zxvf openlist-linux-amd64.tar.gz && \
    chmod +x openlist && \
    rm openlist-linux-amd64.tar.gz

EXPOSE 5244

CMD ["./openlist", "server", "--port", "5244"]
