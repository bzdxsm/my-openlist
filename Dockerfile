# 直接使用 AList 官方镜像作为基础，环境全都是原生配好的
FROM xhofuz/alist:latest

# 安装 Cloudflare Tunnel（官方镜像里可能没有，咱们给它补上）
RUN apk add --no-cache wget ca-certificates
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/bin/cloudflared && \
    chmod +x /usr/bin/cloudflared

# AList 默认运行在 5244 端口
EXPOSE 5244

# 启动脚本：强制设置密码并运行隧道
# ⚠️ 记得把下面的 YOUR_TOKEN 换成你自己的！
CMD ALIST_ADMIN_PASSWORD=myadmin123 alist server & cloudflared tunnel --no-autoupdate run --token eyJhIjoiMTlmNzYxMmI1MmMyM2Q5ZjJlYzhhMzlmYzdjMGI4MzkiLCJ0IjoiODVlMzI1NTUtNDk5NS00OWI4LWE2M2QtOTI1OTM3ZTQ0MTc2IiwicyI6Ik1XRTVZelZrWTJNdFlUbGpOUzAwT1Raa0xUbG1ZekV0Tm1VME4yWXpOakV5TVdJMCJ9
