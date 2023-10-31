# https

## 工作原理

[搞懂HTTPS工作原理](https://www.bilibili.com/video/BV1M44y1175D/?spm_id_from=333.788.recommend_more_video.5&vd_source=eabc2c22ae7849c2c4f31815da49f209)

https 使用了 混合加密的方法
也就是 同时使用了 对称加密以及非对称加密的方式进行对话

首先使用 非对称加密 对对称加密的秘钥进行加密
发送方先使用公钥对对称加密的秘钥进行加密
然后接收方使用私钥对对称加密的秘钥进行解密
得到对称加密的秘钥

紧接着使用对称加密的秘钥对 实际发送的内容进行解密

对于公钥还有中间人劫持的问题

我们需要通过 CA 证书来保证公钥的安全性
CA 证书需要跟具体的颁发机构要

## todo

[我在B站学运维之HTTPS原理介绍以及证书签名的申请配置](https://www.bilibili.com/read/cv16065821)
[我在B站学运维之SSL与TLS协议原理与证书签名多种生成方式实践指南](https://www.bilibili.com/read/cv16067300)
[我在B站学运维之使用Let'sEncrypt免费颁发及自动续签泛域名(通配符)证书](https://www.bilibili.com/read/cv15619304)
[我在B站学运维之如何让HTTPS站点评级达到A+? 还得看这篇HTTPS安全优化配置最佳实践](https://www.bilibili.com/read/cv16067510)
[我在B站学运维之如何让HTTPS站点更加安全?这篇HTTPS安全加固配置最佳实践指南就够了](https://www.bilibili.com/read/cv16067729)
