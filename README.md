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
* 务必选欧洲地区，不要选美区。现在美区已禁 Argo，估计是禁了 7844/tcp。

* PaaS 平台设置的环境变量
  | 变量名        | 是否必须 | 默认值 | 备注 |
  | ------------ | ------ | ------ | ------ |
  | ARGO_AUTH    | 是 |        | Argo 的 Token 或者 json 值 |
  | ARGO_DOMAIN  | 是 |        | Argo 的域名，须与 ARGO_DOMAIN 必需一起填了才能生效 |
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
  | <URL>/list   | 查看节点数据 |
  | <URL>/status | 查看后台进程 |
  | <URL>/listen | 查看后台监听端口 |
  | <URL>/test   | 测试是否为只读系统 |  

* Choreo 设置

<img width="1139" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/b10b00f8-ddd5-4942-bd7d-5da0b5446c83">
  
<img width="1228" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/ad5a74f6-49b6-4603-ba9b-c04daa1d1170">

<img width="1222" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/602661c4-c880-408c-878f-97c90dd3802e">

<img width="1565" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/7cfe1aed-b94a-4e16-bd3e-6503833e869c">

<img width="1639" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/a6a10a44-5b72-460a-a176-9b44df389088">

<img width="1634" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/0364a2af-bd01-49cc-b1d2-0156521d4276">

<img width="1301" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/2cd421c5-8464-4eb2-9173-187eb400a8a9">

<img width="1536" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/d7dd41fa-1afd-412a-ac33-0d559d5804e6">

<img width="1529" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/ea7e9c24-16ee-47f4-ad11-3129709ac748">

<img width="1619" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/d5d1af03-a529-49e1-bfe7-3a71a31a4992">

<img width="1632" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/20e42c78-9355-4df5-b366-5244443a890f">

<img width="1099" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/aaffc1fb-c498-48d7-bbe7-fd9b865e758b">

<img width="355" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/d1b192ec-3daf-444c-8032-63653bccfab1">

<img width="779" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/9a162704-b813-4dbe-9590-897ee8a9f945">

  
## Argo Json 的获取

用户可以通过 Cloudflare Json 生成网轻松获取: https://fscarmen.cloudflare.now.cc

<img width="756" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/2cd80ccc-a64f-4410-84c9-b7c5b2b5e2aa">

<img width="1588" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/9da38fd3-c7ba-4875-a15e-c80d06fa9c83">
  
如想手动，可以参考，以 Debian 为例，需要用到的命令，[Deron Cheng - CloudFlare Argo Tunnel 试用](https://zhengweidong.com/try-cloudflare-argo-tunnel)


## Argo Token 的获取

详细教程: [群晖套件：Cloudflare Tunnel 内网穿透中文教程 支持DSM6、7](https://imnks.com/5984.html)

<img width="1393" alt="image" src="https://user-images.githubusercontent.com/92626977/236611164-dc7d8c98-b742-485a-b6f1-aba88793ef59.png">

<img width="1667" alt="image" src="https://github.com/fscarmen2/X-for-Choreo/assets/92626977/03531af2-d425-4470-8e81-60d2c399317d">


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