FROM alpine:latest
RUN apk add --no-cache wget ca-certificates libc6-compat
WORKDIR /app
# 下载 OpenList
RUN wget https://github.com/OpenListTeam/OpenList/releases/download/v4.2.1/openlist-linux-amd64.tar.gz && \
    tar -zxvf openlist-linux-amd64.tar.gz && \
    chmod +x openlist && \
    rm openlist-linux-amd64.tar.gz
# 下载 Cloudflare 穿透工具
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /app/cloudflared && \
    chmod +x /app/cloudflared
# 提权，防止权限报错
RUN mkdir -p /opt/openlist/data && chmod -R 777 /opt/openlist
EXPOSE 5244
# 启动命令：YOUR_TOKEN 换成你复制的那串
CMD ./openlist server & /app/cloudflared tunnel --no-autoupdate run --token eyJhIjoiMTlmNzYxMmI1MmMyM2Q5ZjJlYzhhMzlmYzdjMGI4MzkiLCJ0IjoiODVlMzI1NTUtNDk5NS00OWI4LWE2M2QtOTI1OTM3ZTQ0MTc2IiwicyI6Ik1XRTVZelZrWTJNdFlUbGpOUzAwT1Raa0xUbG1ZekV0Tm1VME4yWXpOakV5TVdJMCJ9
