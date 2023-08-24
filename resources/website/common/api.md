# 公共 API

```http
GET http://music.163.com/api/search/get/?s=wake&limit=20&type=1&offset=0
Accept: application/json

### GET request with parameter
GET http://music.163.com/api/song/media?id=1873321491
Accept: application/json

GET http://music.163.com/api/search/get/?s=wake&limit=20&type=1&offset=0

HTTP/1.1 200 OK
Server: nginx
Date: Wed, 12 Jul 2023 06:02:46 GMT
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Vary: Accept-Encoding
MConfig-Bucket: 999999
X-TraceId: 0000018948b1e71c18e80aa4683f5af4
Set-Cookie: NMTID=00OiCq6GhDO592MLE35rWUITNJRjR4AAAGJSLHntg; Max-Age=315360000; Expires=Sat, 09 Jul 2033 06:02:46 GMT; Path=/; Domain=music.163.com
cache-control: no-cache
cache-control: no-store
expires: Thu, 01 Jan 1970 00:00:00 GMT
GW-Thread: 531792
GW-Time: 1689141765921
X-From-Src: 223.74.206.96
X-Via: MusicServer

{
  "result": {
    "songs": [
      {
        "id": 1873321491,
        "name": "Wake (Live)",
        "artists": [
          {
            "id": 835002,
            "name": "Hillsong Young & Free",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 132402226,
          "name": "Wake",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1377100800000,
          "size": 1,
          "copyrightId": 456010,
          "status": 1,
          "picId": 109951166328143737,
          "mark": 0
        },
        "duration": 275573,
        "copyrightId": 456010,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 419483,
        "fee": 8,
        "rUrl": null,
        "mark": 270336
      },
      {
        "id": 33051312,
        "name": "Wake (Studio)",
        "artists": [
          {
            "id": 835002,
            "name": "Hillsong Young & Free",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 3177160,
          "name": "We Are Young & Free",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1380556800000,
          "size": 15,
          "copyrightId": 456010,
          "status": 0,
          "picId": 109951167557295220,
          "mark": 0
        },
        "duration": 254946,
        "copyrightId": 456010,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 270336
      },
      {
        "id": 1990826032,
        "name": "wake0.8x",
        "artists": [
          {
            "id": 54319912,
            "name": "XXUML-S",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 153137808,
          "name": "许愿",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1665623390323,
          "size": 6,
          "copyrightId": 0,
          "status": 1,
          "picId": 109951167961324237,
          "mark": 0
        },
        "duration": 87327,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 270336
      },
      {
        "id": 29542751,
        "name": "Wake",
        "artists": [
          {
            "id": 1021206,
            "name": "Capitol Kids!",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 3039866,
          "name": "Capitol Kids! Worship",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1413216000000,
          "size": 15,
          "copyrightId": 7003,
          "status": 3,
          "picId": 2533274791699157,
          "mark": 0
        },
        "duration": 253493,
        "copyrightId": 7003,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 1,
        "rUrl": null,
        "mark": 270336
      },
      {
        "id": 2053072896,
        "name": "Wake",
        "artists": [
          {
            "id": 51317300,
            "name": "奥斯卡ØzcarWang",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 166998769,
          "name": "FEELINGS",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1673798400000,
          "size": 10,
          "copyrightId": 2712474,
          "status": -1,
          "picId": 109951168687351383,
          "mark": 0
        },
        "duration": 170012,
        "copyrightId": 2712474,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 536879104
      },
      {
        "id": 1973673579,
        "name": "Wake（降调版）",
        "artists": [
          {
            "id": 53284287,
            "name": "Xc7w",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 150008485,
          "name": "Wake",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1660893485334,
          "size": 1,
          "copyrightId": 0,
          "status": 0,
          "picId": 109951167796556897,
          "mark": 0
        },
        "duration": 306076,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 0,
        "rUrl": null,
        "mark": 262272
      },
      {
        "id": 1831769300,
        "name": "Wake(快手DJ完整版)",
        "artists": [
          {
            "id": 47144525,
            "name": "墨哥",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 124986587,
          "name": "一个人挺好",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1546272000000,
          "size": 13,
          "copyrightId": 1416503,
          "status": 1,
          "picId": 0,
          "mark": 0
        },
        "duration": 145031,
        "copyrightId": 1416503,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 8192
      },
      {
        "id": 33051313,
        "name": "Wake (Live)",
        "artists": [
          {
            "id": 835002,
            "name": "Hillsong Young & Free",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 3177160,
          "name": "We Are Young & Free",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1380556800000,
          "size": 15,
          "copyrightId": 456010,
          "status": 1,
          "picId": 109951167557295220,
          "mark": 0
        },
        "duration": 275573,
        "copyrightId": 456010,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 1,
        "rUrl": null,
        "mark": 270336
      },
      {
        "id": 1929621794,
        "name": "Wake (Live）",
        "artists": [
          {
            "id": 51529801,
            "name": "7-Tond",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 141317570,
          "name": "7-Tond",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1646368372039,
          "size": 10,
          "copyrightId": 0,
          "status": 0,
          "picId": 109951167114524233,
          "mark": 0
        },
        "duration": 286000,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 0,
        "rUrl": null,
        "mark": 262272
      },
      {
        "id": 1924314440,
        "name": "Wake（火影之名remix）",
        "artists": [
          {
            "id": 37551051,
            "name": "温不胜",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 129242644,
          "name": "火之意志",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1624008877769,
          "size": 2,
          "copyrightId": 0,
          "status": 0,
          "picId": 109951166099683877,
          "mark": 0
        },
        "duration": 181742,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 0,
        "rUrl": null,
        "mark": 262272
      },
      {
        "id": 1901024483,
        "name": "Wake",
        "artists": [
          {
            "id": 49398249,
            "name": "Eleven",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 136955969,
          "name": "爱意随风起",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1638458325157,
          "size": 18,
          "copyrightId": 0,
          "status": 0,
          "picId": 109951166682625322,
          "mark": 0
        },
        "duration": 75240,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 0,
        "rUrl": null,
        "mark": 262272
      },
      {
        "id": 1976088197,
        "name": "wake鸡",
        "artists": [
          {
            "id": 49346181,
            "name": "泷",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 134334109,
          "name": "你太美",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1633535443391,
          "size": 59,
          "copyrightId": 0,
          "status": 0,
          "picId": 109951166496496378,
          "mark": 0
        },
        "duration": 60279,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 0,
        "rUrl": null,
        "mark": 192
      },
      {
        "id": 1435317766,
        "name": "Wake (Live)",
        "artists": [
          {
            "id": 34683052,
            "name": "Logan Walter Band",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 87014508,
          "name": "Live",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1411056000000,
          "size": 11,
          "copyrightId": 1416729,
          "status": 1,
          "picId": 109951164852527334,
          "mark": 0
        },
        "duration": 255080,
        "copyrightId": 1416729,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 270336
      },
      {
        "id": 1821490233,
        "name": "Wake钢琴版（翻自 Hillsong Young & Free）",
        "artists": [
          {
            "id": 35836544,
            "name": "Nero木木",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 123244079,
          "name": "Wake钢琴版(Cover Hillsong Young And Free)",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1613708898265,
          "size": 1,
          "copyrightId": 0,
          "status": 0,
          "picId": 109951165741248382,
          "mark": 0
        },
        "duration": 76974,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 425756,
        "fee": 0,
        "rUrl": null,
        "mark": 262272
      },
      {
        "id": 1957018169,
        "name": "DJ版 wake",
        "artists": [
          {
            "id": 33795662,
            "name": "小田nyist",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 146730151,
          "name": "wake （抖音DJ版）",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1655531890084,
          "size": 1,
          "copyrightId": 0,
          "status": 0,
          "picId": 109951167564403023,
          "mark": 0
        },
        "duration": 253331,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 0,
        "rUrl": null,
        "mark": 128
      },
      {
        "id": 2006564273,
        "name": "wake 感觉至上（0.8remix）",
        "artists": [
          {
            "id": 48632770,
            "name": "梁威",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 131799014,
          "name": "编曲",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1628956800000,
          "size": 14,
          "copyrightId": -1,
          "status": 1,
          "picId": 109951168164545543,
          "mark": 0
        },
        "duration": 23800,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 8256
      },
      {
        "id": 1435553225,
        "name": "Wake (Live)",
        "artists": [
          {
            "id": 34692619,
            "name": "Jesse Peterson & Northgate Worship",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 87060989,
          "name": "Northgate (Live), Vol. 2",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1446998400000,
          "size": 6,
          "copyrightId": 1416729,
          "status": 1,
          "picId": 109951164853873733,
          "mark": 0
        },
        "duration": 262957,
        "copyrightId": 1416729,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 270336
      },
      {
        "id": 1946785602,
        "name": "Wake(live)[3D]",
        "artists": [
          {
            "id": 51450059,
            "name": "GiYuu",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 140207075,
          "name": "Destory",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1644486630950,
          "size": 3,
          "copyrightId": 0,
          "status": 0,
          "picId": 109951167043800070,
          "mark": 0
        },
        "duration": 275922,
        "copyrightId": 0,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 0,
        "rUrl": null,
        "mark": 128
      },
      {
        "id": 1874108641,
        "name": "Wake (Live)",
        "artists": [
          {
            "id": 835002,
            "name": "Hillsong Young & Free",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 132515450,
          "name": "lll (Live at Hillsong Conference)",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1541088000000,
          "size": 16,
          "copyrightId": 456010,
          "status": 1,
          "picId": 109951166337535292,
          "mark": 0
        },
        "duration": 257253,
        "copyrightId": 456010,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 270336
      },
      {
        "id": 1482905023,
        "name": "Wake (Live)",
        "artists": [
          {
            "id": 33864827,
            "name": "Stevens Creek Church",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          }
        ],
        "album": {
          "id": 96062835,
          "name": "Alive",
          "artist": {
            "id": 0,
            "name": "",
            "picUrl": null,
            "alias": [],
            "albumSize": 0,
            "picId": 0,
            "fansGroup": null,
            "img1v1Url": "http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "img1v1": 0,
            "trans": null
          },
          "publishTime": 1416240000000,
          "size": 3,
          "copyrightId": 743010,
          "status": 1,
          "picId": 109951165349864501,
          "mark": 0
        },
        "duration": 273790,
        "copyrightId": 743010,
        "status": 0,
        "alias": [],
        "rtype": 0,
        "ftype": 0,
        "mvid": 0,
        "fee": 8,
        "rUrl": null,
        "mark": 270464
      }
    ],
    "hasMore": true,
    "songCount": 300
  },
  "code": 200
}

Response code: 200 (OK); Time: 288ms; Content length: 14733 bytes


GET http://music.163.com/api/song/media?id=1873321491

HTTP/1.1 200 OK
Server: nginx
Date: Wed, 12 Jul 2023 06:09:56 GMT
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Vary: Accept-Encoding
X-TraceId: 0000018948b878240dee0aa468201538
MConfig-Bucket: 999999
Set-Cookie: NMTID=00ODM7aWlJox6Gk7ECarcrbjwN7XxsAAAGJSLh4NA; Max-Age=315360000; Expires=Sat, 09 Jul 2033 06:09:56 GMT; Path=/; Domain=music.163.com
cache-control: no-cache
cache-control: no-store
expires: Thu, 01 Jan 1970 00:00:00 GMT
GW-Thread: 288478
GW-Time: 1689142196270
X-From-Src: 223.74.206.96
X-Via: MusicServer

{
  "songStatus": 1,
  "lyricVersion": 10,
  "lyric": "[by:Senvanlee]\n[00:14.338]At break of day, in hope we rise\n[00:17.926]We speak Your name, we lift our eyes\n[00:21.598]Tune our hearts into Your beat\n[00:25.306]Where we walk, there You'll be\n[00:28.885]\n[00:29.025]With fire in our eyes, our lives a-light\n[00:32.523]Your love untamed, it's blazing out\n[00:36.285]The streets will glow forever bright\n[00:39.803]Your glory's breaking through the night\n[00:43.440]\n[00:43.583]You will never fade away, Your love is here to stay\n[00:47.325]By my side, in my life, shining through me everyday\n[00:50.998]You will never fade away, Your love is here to stay\n[00:54.605]By my side, in my life, shining through me everyday\n[00:58.374]\n[01:12.811]You wake within me, wake within me\n[01:16.855]You're in my heart forever\n[01:20.283]You wake within me, wake within me\n[01:24.130]You're in my heart forever\n[01:27.834]\n[01:42.272]With fire in our eyes, our lives a-light\n[01:45.771]Your love untamed, it's blazing out\n[01:49.459]The streets will glow forever bright\n[01:53.055]Your glory's breaking through the night\n[01:56.769]\n[01:56.947]You will never fade away, Your love is here to stay\n[02:00.566]By my side, in my life, shining through me everyday\n[02:04.305]You will never fade away, Your love is here to stay\n[02:07.881]By my side, in my life, shining through me everyday\n[02:11.615]\n[02:26.026]You wake within me, wake within me\n[02:30.125]You're in my heart forever\n[02:33.507]You wake within me, wake within me\n[02:37.474]You're in my heart forever\n[02:40.969]\n[02:55.991]Forever, forever, forever in Your love\n[03:03.307]Forever, forever, forever in Your love\n[03:10.543]Forever, forever, forever in Your love\n[03:17.922]Forever, forever,forever we know that...\n[03:24.779]\n[03:24.942]You will never fade away, Your love is here to stay\n[03:28.568]By my side, in my life, shining through me everyday\n[03:32.257]You will never fade away, Your love is here to stay\n[03:35.848]By my side, in my life, shining through me everyday\n[03:39.637]\n[03:54.125]You wake within me, wake within me\n[03:58.034]You're in my heart forever\n[04:01.474]You wake within me, wake within me\n[04:05.262]You're in my heart forever",
  "code": 200
}

Response code: 200 (OK); Time: 168ms; Content length: 2261 bytes

```