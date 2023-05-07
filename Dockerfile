FROM node:latest

# 设置各变量
ARG WSPATH= \
    UUID= \
    NEZHA_SERVER= \
    NEZHA_PORT= \
    NEZHA_KEY= \
    NEZHA_TLS= \
    WEB_DOMAIN= \
    ARGO_DOMAIN= \
    SSH_DOMAIN= \
    ARGO_AUTH= \
    WEB_USERNAME= \
    WEB_PASSWORD=

# 此处不用改，保留即可
ENV NEZHA_SERVER=$NEZHA_SERVER \
    NEZHA_PORT=$NEZHA_PORT \
    NEZHA_KEY=$NEZHA_KEY \
    SSH_DOMAIN=$SSH_DOMAIN

WORKDIR /home/choreouser

COPY files/* /home/choreouser/

RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb &&\
    addgroup --gid 10001 choreo &&\
    if echo "$ARGO_AUTH" | grep -q 'TunnelSecret'; then \
      echo "$ARGO_AUTH" | sed 's@{@{"@g;s@[,:]@"\0"@g;s@}@"}@g' > tunnel.json; \
      echo "\
tunnel: $(echo "$ARGO_AUTH" | grep -oP "(?<=TunnelID:).*(?=})") \n\
credentials-file: /home/choreouser/tunnel.json \n\
protocol: h2mux \n\
\n\
ingress: \n\
  - hostname: $ARGO_DOMAIN \n\
    service: http://localhost:8080 \n\
  - hostname: $WEB_DOMAIN \n\
    service: http://localhost:3000" > tunnel.yml; \
    
      if [ -n "$SSH_DOMAIN" ]; then \
        echo "\
  - hostname: $SSH_DOMAIN \n\
    service: http://localhost:2222 \n\
    originRequest: \n\
      noTLSVerify: true" >> tunnel.yml; \
      fi; \
      
      echo "\
  - service: http_status:404" >> tunnel.yml; \
    else \
      ARGO_TOKEN=$ARGO_AUTH; \
      sed -i "s#ARGO_TOKEN_CHANGE#$ARGO_TOKEN#g" entrypoint.sh; \
    fi &&\
    echo "******************************************* \n\
V2-rayN: \n\
---------------------------- \n\
vless://${UUID}@icook.hk:443?encryption=none&security=tls&sni=${ARGO_DOMAIN}&type=ws&host=${ARGO_DOMAIN}&path=%2F${WSPATH}-vless?ed=2048#Argo-Vless \n\
---------------------------- \n\
vmess://$(echo "{ \"v\": \"2\", \"ps\": \"Argo-Vmess\", \"add\": \"icook.hk\", \"port\": \"443\", \"id\": \"${UUID}\", \"aid\": \"0\", \"scy\": \"none\", \"net\": \"ws\", \"type\": \"none\", \"host\": \"${ARGO_DOMAIN}\", \"path\": \"/${WSPATH}-vmess?ed=2048\", \"tls\": \"tls\", \"sni\": \"${ARGO_DOMAIN}\", \"alpn\": \"\" }" | base64 -w0) \n\
---------------------------- \n\
trojan://${UUID}@icook.hk:443?security=tls&sni=${ARGO_DOMAIN}&type=ws&host=${ARGO_DOMAIN}&path=%2F${WSPATH}-trojan?ed=2048#Argo-Trojan \n\
---------------------------- \n\
ss://$(echo "chacha20-ietf-poly1305:${UUID}@icook.hk:443" | base64 -w0)@icook.hk:443#Argo-Shadowsocks \n\
由于该软件导出的链接不全，请自行处理如下: 传输协议: WS ， 伪装域名: ${ARGO_DOMAIN} ，路径: /${WSPATH}-shadowsocks?ed=2048 ， 传输层安全: tls ， sni: ${ARGO_DOMAIN} \n\
******************************************* \n\
小火箭: \n\
---------------------------- \n\
vless://${UUID}@icook.hk:443?encryption=none&security=tls&type=ws&host=${ARGO_DOMAIN}&path=/${WSPATH}-vless?ed=2048&sni=${ARGO_DOMAIN}#Argo-Vless \n\
---------------------------- \n\
vmess://$(echo "none:${UUID}@icook.hk:443" | base64 -w0)?remarks=Argo-Vmess&obfsParam=${ARGO_DOMAIN}&path=/${WSPATH}-vmess?ed=2048&obfs=websocket&tls=1&peer=${ARGO_DOMAIN}&alterId=0 \n\
---------------------------- \n\
trojan://${UUID}@icook.hk:443?peer=${ARGO_DOMAIN}&plugin=obfs-local;obfs=websocket;obfs-host=${ARGO_DOMAIN};obfs-uri=/${WSPATH}-trojan?ed=2048#Argo-Trojan \n\
---------------------------- \n\
ss://$(echo "chacha20-ietf-poly1305:${UUID}@icook.hk:443" | base64 -w0)?obfs=wss&obfsParam=${ARGO_DOMAIN}&path=/${WSPATH}-shadowsocks?ed=2048#Argo-Shadowsocks \n\
******************************************* \n\
Clash: \n\
---------------------------- \n\
- {name: Argo-Vless, type: vless, server: icook.hk, port: 443, uuid: ${UUID}, tls: true, servername: ${ARGO_DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: {path: /${WSPATH}-vless?ed=2048, headers: { Host: ${ARGO_DOMAIN}}}, udp: true} \n\
---------------------------- \n\
- {name: Argo-Vmess, type: vmess, server: icook.hk, port: 443, uuid: ${UUID}, alterId: 0, cipher: none, tls: true, skip-cert-verify: true, network: ws, ws-opts: {path: /${WSPATH}-vmess?ed=2048, headers: {Host: ${ARGO_DOMAIN}}}, udp: true} \n\
---------------------------- \n\
- {name: Argo-Trojan, type: trojan, server: icook.hk, port: 443, password: ${UUID}, udp: true, tls: true, sni: ${ARGO_DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: { path: /${WSPATH}-trojan?ed=2048, headers: { Host: ${ARGO_DOMAIN} } } } \n\
---------------------------- \n\
- {name: Argo-Shadowsocks, type: ss, server: icook.hk, port: 443, cipher: chacha20-ietf-poly1305, password: ${UUID}, plugin: v2ray-plugin, plugin-opts: { mode: websocket, host: ${ARGO_DOMAIN}, path: /${WSPATH}-shadowsocks?ed=2048, tls: true, skip-cert-verify: false, mux: false } } \n\
******************************************* " > list &&\
    sed -i "s#UUID#$UUID#g; s#WSPATH#$WSPATH#g;" config.json &&\
    TLS=${NEZHA_TLS:+'--tls'} &&\
    sed -i "s#NEZHA_SERVER_CHANGE#$NEZHA_SERVER#g; s#NEZHA_PORT_CHANGE#$NEZHA_PORT#g; s#NEZHA_KEY_CHANGE#$NEZHA_KEY#g; s#TLS_CHANGE#$TLS#g; s#WEB_USERNAME_CHANGE#$WEB_USERNAME#g; s#WEB_PASSWORD_CHANGE#$WEB_PASSWORD#g" entrypoint.sh &&\
    sed -i "s#WEB_USERNAME_CHANGE#$WEB_USERNAME#g; s#WEB_PASSWORD_CHANGE#$WEB_PASSWORD#g; s#WEB_DOMAIN_CHANGE#$WEB_DOMAIN#g" server.js &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser &&\
    chown -R 10001:10001 web.js entrypoint.sh config.json &&\
    chmod +x web.js entrypoint.sh nezha-agent ttyd &&\
    npm install -r package.json

ENTRYPOINT [ "node", "server.js" ]

USER 10001
