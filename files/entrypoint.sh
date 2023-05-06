#!/usr/bin/env bash

# 显示节点信息
cat list

# 运行 Nezha
[[ -n "$NEZHA_SERVER" && -n "$NEZHA_PORT" && -n "$NEZHA_KEY" ]] && nohup ./nezha-agent -s NEZHA_SERVER_CHANGE:NEZHA_PORT_CHANGE -p NEZHA_KEY_CHANGE TLS_CHANGE >/dev/null 2>&1 &

# 运行 Argo
if [ -e tunnel.yml ]; then 
  nohup cloudflared tunnel --edge-ip-version auto --config /home/choreouser/tunnel.yml run >/dev/null 2>&1 &
else
  nohup cloudflared tunnel --edge-ip-version auto --protocol h2mux run --token ARGO_TOKEN_CHANGE >/dev/null 2>&1 &
fi

# 运行 ttyd
[ -n "$SSH_DOMAIN" ] && nohup ./ttyd -c WEB_USERNAME_CHANGE:WEB_PASSWORD_CHANGE -p 2222 bash >/dev/null 2>&1 &

# 运行科学
./web.js run
