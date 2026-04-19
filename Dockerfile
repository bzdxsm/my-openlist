FROM alpine:latest
RUN apk add --no-cache wget ca-certificates libc6-compat
WORKDIR /app

# 换成 AList 官方镜像，这个版本驱动最全
RUN wget https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz && \
    tar -zxvf alist-linux-amd64.tar.gz && \
    chmod +x alist && \
    rm alist-linux-amd64.tar.gz

# 下载 Cloudflare Tunnel
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /app/cloudflared && \
    chmod +x /app/cloudflared

RUN mkdir -p /app/data && chmod -R 777 /app
EXPOSE 5244

# 启动命令（记得换成你自己的密码和 TOKEN）
CMD ./alist server & /app/cloudflared tunnel --no-autoupdate run --token eyJhIjoiMTlmNzYxMmI1MmMyM2Q5ZjJlYzhhMzlmYzdjMGI4MzkiLCJ0IjoiODVlMzI1NTUtNDk5NS00OWI4LWE2M2QtOTI1OTM3ZTQ0MTc2IiwicyI6Ik1XRTVZelZrWTJNdFlUbGpOUzAwT1Raa0xUbG1ZekV0Tm1VME4yWXpOakV5TVdJMCJ9
