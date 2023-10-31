# 错误集合

```log

raise SSLError(e, request=request)
requests.exceptions.SSLError: HTTPSConnectionPool(host='www.hifini.com', port=443): Max retries exceeded with url: /get_music.php?key=7dPulQ0AgJEcZd9XRcIR9gDCxGBLtQysnGnrgoM6hIpW1VzpVLK6pSqI2EypNFg (Caused by SSLError(SSLEOFError(8, '[SSL: UNEXPECTED_EOF_WHILE_READING] EOF occurred in violation of protocol (_ssl.c:1006)')))
```
https://blog.csdn.net/xc_zhou/article/details/102845361

安装 下面三个库就可以解决
pip install cryptography 
pip install pyOpenSSL
pip install certifi
