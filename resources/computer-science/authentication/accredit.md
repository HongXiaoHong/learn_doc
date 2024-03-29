# 授权

 
![oauth](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230920165625.png)

## 初入门
[OAuth 2.0 的一个简单解释 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/04/oauth_design.html)

[OAuth 2.0 的四种方式 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/04/oauth-grant-types.html)

[GitHub OAuth 第三方登录示例教程 - 阮一峰的网络日志 (ruanyifeng.com)](https://www.ruanyifeng.com/blog/2019/04/github-oauth.html)

[OAuth2.0四种授权模式以及Oauth2.0实战](https://blog.csdn.net/NeverFG/article/details/124089339?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-124089339-blog-115609898.235%5Ev38%5Epc_relevant_anti_vip&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-124089339-blog-115609898.235%5Ev38%5Epc_relevant_anti_vip&utm_relevant_index=2)

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/20230920165341.png)

按照上述时序图举个简单的例子，小明使用微信授权方式登录app。

小明点开手机里面的app，他不想手动输入账号密码登录，而是采用了微信登录。
点击微信登录按钮，app拉起授权页面。
微信授权服务器则生成授权页面，用户看见授权页面点击确定按钮进行授权。
微信授权服务器校验用户身份合法性后生成请求code，点击确认授权后，页面跳转至app页面并携带请求code(授权码)。
app拿到授权码后，携带授权码向授权服务器获取访问令牌access_token。
拿到access_token后，则携带access_token向受保护资源发起访问。
校验access_token无误后，受保护资源返回资源数据（个人的身份数据，昵称，地区等信息）。
成功登录app，小明继续使用app内的功能。
1.1.1、为什么需要生成授权码以及根据授权码获取access_token步骤？
假设从时序图中抹除授权码的流程，那么从第三步，用户点击确定授权，此时资源拥有者与授权服务器就建立起关联，此时，资源拥有者则与第三方软件前端断开关联，界面则会停留在授权界面。然后授权服务器直接把access_token送给第三方软件后端，后端在携带access_token去访问受保护资源。虽然说资源数据已经拿到了，但是如何通知用户呢？因此，得需要建立起用户与第三方软件前端的关联，所以授权服务器生成授权码后重定向到第三方软件前端则是重新建立起用户与第三方软件前端的关联。

既然如此，那么为什么授权服务器不直接重定向传回access_token,首先并不能保证重定向采用的形式是否是https，而且并不是所有的客户端都支持https，所以重定向传回access_token就会增加access_token失窃的风险。虽然access_token需要与client_id,client_secret一起才能够通过授权服务器校验访问到保护资源，但是在安全层面来说，这都是不适合的。在此层面上看，授权码的作用在于access_token不经过用户浏览器, 保护了access_token。

1.1.2、授权码code可以暴露？
1、授权码Authentication code只能用一次，而且会很快超时失效, 使得被截获后难以运用。

2、授权码需要和client id/client secret共同完成认证，才能够获得access_token。就算授权码如果失窃，单凭授权码是无法得到access_token的。

1.1.3、access_token不能暴露在浏览器那么该存放在哪？
重定向传回access_token会使安全保密性要求极高的访问令牌暴露在浏览器，增加访问令牌失窃风险。

刚开始接触Oauth2.0的我也是比较迷，既然access_token不能暴露在浏览器，那么我到底将access_token存放在哪呢？那我前端有如何进行访问那些受保护资源呢？

在我看来，重定向携带的参数在URL上，http协议下重定向传回access_token的形式，是没有经过数据加密的，他会增加令牌失窃的风险。那么关于access_token存放在哪的问题，个人认为通过授权码以及客户端id和secret共同校验后获取的access_token，可以把access_token存放在localStorage中，localStorage虽然是永久存储，但是access_token会有一个有效期，有效期到了之后，即便access_token一直都存在但是有效期过后就无法访问到受保护资源。

## 授权模式
oauth 包括四种授权模式
- 授权码
- 密码
- 隐藏
- 客户端