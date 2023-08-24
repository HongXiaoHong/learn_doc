# 通过 document 获取页面中的表格数据


[Largest diagnostics and testing companies by Market Cap (companiesmarketcap.com)](https://companiesmarketcap.com/diagnostics/largest-companies-by-market-cap/)

```javascript
/**
 * 
 * 通过 document 获取页面的 dom 元素列表
 * 通过选择列表 dom 节点 ＋ 选择器 获取子元素
 * 加到列表中之后
 * 再通过列表的流操作 ＋ lambda 表达式输出 csv
 */
let list = [];
for (const tr of document.getElementsByTagName('tr')) {
    rankTd = tr.querySelector(".rank-td");
    companyName = tr.querySelector(".company-name");
    cap = tr.querySelector("td:nth-of-type(3)");
    price = tr.querySelector("td:nth-of-type(4)");
    country = tr.querySelector(".responsive-hidden");
    
    if (rankTd) {
        list.push({
            "rank": rankTd.getAttribute("data-sort"), 
            "companyName": 
            companyName.textContent, 
        "cap": cap.textContent,
        "price": price.textContent,
        "country": country.textContent,
        })
    }
    
}
console.log(list)
console.log(list.length)
console.log(list.map(item=>`${item.rank},${item.companyName.trim()},${item.cap},${item.price},${item.country}`).join("\n"))
```

[Top 100 global energy leaders | Thomson Reuters --- 全球能源领导者100强 |汤森路透](https://www.thomsonreuters.com/en/products-services/energy/top-100.html)

```javascript
let list = [];
for (const tr of document.getElementsByTagName('tr')) {
    companyName = tr.querySelector("td:nth-of-type(1)");
    tRBCIndustryGroupName = tr.querySelector("td:nth-of-type(2)");
    country = tr.querySelector("td:nth-of-type(3)");
    
    if (companyName) {
        list.push({
            "companyName": 
            companyName.textContent, 
        "tRBCIndustryGroupName": tRBCIndustryGroupName.textContent,
        "country": country.textContent,
        })
    }
    
}
console.log(list)
console.log(list.length)
console.log(list.map(item=>`${item.companyName.trim()},${item.tRBCIndustryGroupName.trim()},${item.country.trim()}`).join("\n"))
```