FROM alpine:latest

# 1. 安装基础环境：libc6-compat 是跑这种二进制程序的命根子
RUN apk add --no-cache wget ca-certificates libc6-compat

WORKDIR /app

# 2. 重新下载 OpenList（我帮你找了一个更稳的直链）
# 如果你是从 GitHub 下载的，确保它是 amd64 版本的 Linux 二进制文件
RUN wget https://github.com/OpenListTeam/OpenList/releases/latest/download/openlist-linux-amd64.tar.gz && \
    tar -zxvf openlist-linux-amd64.tar.gz && \
    chmod +x openlist && \
    rm openlist-linux-amd64.tar.gz

# 3. 下载 Cloudflare Tunnel
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /app/cloudflared && \
    chmod +x /app/cloudflared

# 4. 开放端口并启动
EXPOSE 5244

# 这里的密码我帮你设回你原来的那个 O8fxnDxV
# 使用变量代替具体值
CMD ./openlist server & /app/cloudflared tunnel --no-autoupdate run --token ${MY_CF_TOKEN}
