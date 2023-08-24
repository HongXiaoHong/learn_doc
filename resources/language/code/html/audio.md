# html 音频

参考:
https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/audio

### 重要属性
#### <mark>autoplay</mark>

去掉该属性之后 音频组件不显示
布尔值属性；声明该属性，音频会尽快自动播放，不会等待整个音频文件下载完成。

#### controls

如果声明了该属性，浏览器将提供一个包含声音，播放进度，播放暂停的控制面板，让用户可以控制音频的播放。

#### currentTime

读取 currentTime 属性将返回一个双精度浮点值，用以标明以秒为单位的当前音频的播放位置。

#### duration

这是一个双精度浮点数，指明了音频在时间轴中的持续时间（总长度），以秒为单位。如果元素上没有媒体，或者媒体是不可用的，那么会返回 NaN。如果媒体找不到确切的结尾（比如不确定长度的直播流，网络电台，或者是通过 WebRTC 连接的流），那么这个值将返回 +Infinity。

#### loop

布尔属性；如果声明该属性，将循环播放音频。

#### muted

表示是否静音的布尔值。默认值为 false，表示有声音。

资料
音频（audio）自定义样式以及控制操作面板
1. https://www.jianshu.com/p/653a860b8dcb
2. https://dandelion-drq.github.io/2017/08/28/H5-audio-demo.html
