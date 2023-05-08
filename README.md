# X for Choreo

* * *

# 目录

- [项目特点](README.md#项目特点)
- [部署](README.md#部署)
- [Argo Json 的获取](README.md#argo-json-的获取)
- [Argo Token 的获取](README.md#argo-token-的获取)
- [TTYD webssh 的部署](README.md#ttyd-webssh-的部署)
- [鸣谢下列作者的文章和项目](README.md#鸣谢下列作者的文章和项目)
- [免责声明](README.md#免责声明)

* * *

## 项目特点:
* 使用 CloudFlare 的 Argo 隧道，同时兼容 Json / token / 临时 三种方式认证，使用TLS加密通信，可以将应用程序流量安全地传输到Cloudflare网络，提高了应用程序的安全性和可靠性。此外，Argo Tunnel也可以防止IP泄露和DDoS攻击等网络威胁
* 解锁 chatGPT
* 在浏览器查看系统各项信息，方便直观
* 集成哪吒探针，可以自由选择是否安装，支持 SSL/TLS 模式，适配 Nezha over Argo 项目: https://github.com/fscarmen2/Argo-Nezha-Service-Container
* uuid，WS 路径既可以自定义，又或者使用默认值
* 前端 js 定时和 pm2 配合保活，务求让恢复时间减到最小
* 节点信息以 V2rayN / Clash / 小火箭 链接方式输出
* 可以使用浏览器访问，使用 ttyd，ssh over http2
* 项目路径 `https://github.com/fscarmen2/X-for-Choreo`

## 部署:
* 注册 [Choreo](https://console.choreo.dev/) ，支持 GitHub / Google / Microsoft 账号进行登录，请使用以下地址注册并进行登录。

* PaaS 平台设置的环境变量
  | 变量名        | 是否必须 | 默认值 | 备注 |
  | ------------ | ------ | ------ | ------ |
  | ARGO_AUTH    | 是 |        | Argo 的 Token 或者 json 值 |
  | ARGO_DOMAIN  | 是 |        | Argo 的域名，须与 ARGO_DOMAIN 必需一起填了才能生效 |
  | WEB_DOMAIN   | 是 |        | 网页地址，用于查看节点信息和系统状态 |
  | UUID         | 否 | de04add9-5c68-8bab-950c-08cd5320df18 | 可在线生成 https://www.zxgj.cn/g/uuid |
  | WSPATH       | 否 | argo | 勿以 / 开头，各协议路径为 `/WSPATH-协议`，如 `/argo-vless`,`/argo-vmess`,`/argo-trojan`,`/argo-shadowsocks` |
  | NEZHA_SERVER | 否 |        | 哪吒探针与面板服务端数据通信的IP或域名 |
  | NEZHA_PORT   | 否 |        | 哪吒探针服务端的端口 |
  | NEZHA_KEY    | 否 |        | 哪吒探针客户端专用 Key |
  | NEZHA_TLS    | 否 |        | 哪吒探针是否启用 SSL/TLS 加密 ，如不启用不要该变量，如要启用填"1" |
  | WEB_USERNAME | 否 | admin  | 网页和 webssh 的用户名 |
  | WEB_PASSWORD | 否 | password | 网页和 webssh 的密码 |
  | SSH_DOMAIN   | 否 |        | webssh 的域名，用户名和密码就是 <WEB_USERNAME> 和 <WEB_PASSWORD> |

* 路径（path）
  | 命令 | 说明 |
  | ---- |------ |
  | <WEB_DOMAIN>/list   | 查看节点数据 |
  | <WEB_DOMAIN>/status | 查看后台进程 |
  | <WEB_DOMAIN>/listen | 查看后台监听端口 |
  | <WEB_DOMAIN>/test   | 测试是否为只读系统 |  

* Choreo 设置

<img width="1037" alt="image" src="https://user-images.githubusercontent.com/92626977/236611678-e9ee0a82-efe3-4a21-ab4a-fc16d3d1fa1b.png">
  
<img width="647" alt="image" src="https://user-images.githubusercontent.com/92626977/236611722-fb60f8be-c5cd-43d8-9ed1-c1f00694d1e1.png">

<img width="700" alt="image" src="https://user-images.githubusercontent.com/92626977/236611875-f1164bf7-1bdf-4c06-a693-ca3e7b600364.png">

<img width="1637" alt="image" src="https://user-images.githubusercontent.com/92626977/236786108-33ebd062-3d17-44ec-98ed-af022c3933e2.png">

<img width="1293" alt="image" src="https://user-images.githubusercontent.com/92626977/236787682-5c98c391-8000-455a-b7cf-c4e08b072655.png">

<img width="1638" alt="image" src="https://user-images.githubusercontent.com/92626977/236611941-2760746e-0ae3-40a8-be64-d2974e4f0a84.png">

<img width="1680" alt="image" src="https://user-images.githubusercontent.com/92626977/236612065-2af3d69b-3ea2-4f79-bc33-6ddba2b03638.png">

<img width="1506" alt="image" src="https://user-images.githubusercontent.com/92626977/236612104-b3d4fa86-4111-4e5d-b672-3458ad440e9c.png">

<img width="1151" alt="image" src="https://user-images.githubusercontent.com/92626977/236612474-065ddf6e-9d44-4d8c-b237-2f2623c8856f.png">

<img width="997" alt="image" src="https://user-images.githubusercontent.com/92626977/236612512-31fb24d6-e3b1-48a0-bfa9-165cb122d311.png">

<img width="331" alt="image" src="https://user-images.githubusercontent.com/92626977/236612116-97fa6072-ad5b-4a61-8906-8d9b9153327d.png">

<img width="579" alt="image" src="https://user-images.githubusercontent.com/92626977/236612319-7071bc1a-e60e-4fe0-8a37-765133adca71.png">

  
## Argo Json 的获取

用户可以通过 Cloudflare Json 生成网轻松获取: https://fscarmen.cloudflare.now.cc


<img width="763" alt="image" src="https://user-images.githubusercontent.com/92626977/236611088-5c380ae6-4558-4e53-bc5a-ef1a44388c69.png">

<img width="1636" alt="image" src="https://user-images.githubusercontent.com/92626977/236611051-910b753d-77f2-423c-8941-9ef5b0e64316.png">
  
如想手动，可以参考，以 Debian 为例，需要用到的命令，[Deron Cheng - CloudFlare Argo Tunnel 试用](https://zhengweidong.com/try-cloudflare-argo-tunnel)


## Argo Token 的获取

详细教程: [群晖套件：Cloudflare Tunnel 内网穿透中文教程 支持DSM6、7](https://imnks.com/5984.html)

<img width="1393" alt="image" src="https://user-images.githubusercontent.com/92626977/236611164-dc7d8c98-b742-485a-b6f1-aba88793ef59.png">

<img width="1660" alt="image" src="https://user-images.githubusercontent.com/92626977/236611259-273f2486-9c08-408c-83f9-40235103c706.png">


## TTYD webssh 的原理

```
+---------+     argo     +---------+     http     +--------+    ssh    +-----------+
| browser | <==========> | CF edge | <==========> |  ttyd  | <=======> | ssh server|
+---------+     argo     +---------+   websocket  +--------+    ssh    +-----------+
```


## 鸣谢下列作者的文章和项目:

* Nike Jeff 的 trojan 项目: https://github.com/hrzyang/glitch-trojan
* Hifeng 的博客: https://www.hicairo.com/post/62.html

## 免责声明:
* 本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。
* 使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责。
