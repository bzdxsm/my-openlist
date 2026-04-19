FROM alpine:latest

# 安装基础环境
RUN apk add --no-cache wget ca-certificates libc6-compat

WORKDIR /app

# 下载 OpenList 并更名，确保路径干净
RUN wget https://github.com/OpenListTeam/OpenList/releases/download/v4.2.1/openlist-linux-amd64.tar.gz && \
    tar -zxvf openlist-linux-amd64.tar.gz && \
    chmod +x openlist && \
    rm openlist-linux-amd64.tar.gz

# 下载 Cloudflare Tunnel 工具
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /app/cloudflared && \
    chmod +x /app/cloudflared

# 暴力解决权限问题
RUN mkdir -p /app/data && chmod -R 777 /app

EXPOSE 5244

# 启动命令优化：
# 1. 明确指定数据目录在 /app/data
# 2. 移除 --port 让它走默认 5244，减少参数报错
# 3. YOUR_TOKEN 换成你那串以 ey... 开头的代码
CMD ./openlist server --data /app/data & /app/cloudflared tunnel --no-autoupdate run --token eyJhIjoiMTlmNzYxMmI1MmMyM2Q5ZjJlYzhhMzlmYzdjMGI4MzkiLCJ0IjoiODVlMzI1NTUtNDk5NS00OWI4LWE2M2QtOTI1OTM3ZTQ0MTc2IiwicyI6Ik1XRTVZelZrWTJNdFlUbGpOUzAwT1Raa0xUbG1ZekV0Tm1VME4yWXpOakV5TVdJMCJ9
