FROM alpine:latest
RUN apk add --no-cache wget ca-certificates libc6-compat

WORKDIR /app

# 改进下载逻辑：直接获取最新版的 amd64 压缩包
RUN wget https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz && \
    tar -zxvf alist-linux-amd64.tar.gz && \
    chmod +x alist && \
    rm alist-linux-amd64.tar.gz

# 下载 Cloudflare Tunnel
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /app/cloudflared && \
    chmod +x /app/cloudflared

RUN mkdir -p /app/data && chmod -R 777 /app
EXPOSE 5244

# 记得把 YOUR_TOKEN 换成你自己的！
# 顺便帮你把管理员密码强制设好，免得你去日志里翻
CMD ALIST_ADMIN_PASSWORD=q456789@p ./alist server & /app/cloudflared tunnel --no-autoupdate run --token eyJhIjoiMTlmNzYxMmI1MmMyM2Q5ZjJlYzhhMzlmYzdjMGI4MzkiLCJ0IjoiODVlMzI1NTUtNDk5NS00OWI4LWE2M2QtOTI1OTM3ZTQ0MTc2IiwicyI6Ik1XRTVZelZrWTJNdFlUbGpOUzAwT1Raa0xUbG1ZekV0Tm1VME4yWXpOakV5TVdJMCJ9
