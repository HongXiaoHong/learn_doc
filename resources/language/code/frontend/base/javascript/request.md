# JavaScript 请求

## 请求

### XMLHttpRequest

```javascript
const req = new XMLHttpRequest();
req.open("GET", '/json/cats.json', true);
req.send();
req.onload = function () {
    const json = JSON.parse(req.responseText);
    document.getElementsByClassName('message')[0].innerHTML = JSON.stringify(json);
};
```

这段代码使用 XMLHttpRequest 对象来发送异步的 GET 请求，获取一个位于 `/json/cats.json` 路径下的 JSON 文件，并将获取到的 JSON 数据显示在 HTML 页面上。

具体解释如下：

1. `const req = new XMLHttpRequest();`：创建一个新的 XMLHttpRequest 对象，用于发送 HTTP 请求。

2. `req.open("GET",'/json/cats.json',true);`：配置 XMLHttpRequest 对象的请求参数。这里设置了请求的方法为 GET，请求的 URL 为 `/json/cats.json`
   ，并将请求设置为异步模式(第三个参数为 `true`)。

3. `req.send();`：发送 HTTP 请求。

4. `req.onload = function(){ ... }`：当请求成功完成后，执行指定的回调函数。在这个回调函数中，我们可以处理从服务器获取的数据。

5. `const json = JSON.parse(req.responseText);`：将从服务器返回的响应数据(`req.responseText`)解析为 JSON 格式，并将结果赋值给变量 `json`。

6. `document.getElementsByClassName('message')[0].innerHTML = JSON.stringify(json);`：获取 HTML 中类名为 `'message'`
   的元素(假设只有一个)，将解析后的 JSON 数据转换为字符串，并将字符串设置为该元素的内容。

总结来说，这段代码发送一个异步 GET 请求来获取 `/json/cats.json` 文件的内容，并将获取到的 JSON 数据以字符串形式显示在页面上具有 `'message'` 类名的元素中。这种方式允许在不刷新整个页面的情况下，通过
AJAX 技术从服务器获取数据并更新页面的特定部分。

### XMLHttpRequest的请求默认是异步的吗?可以设置成同步吗?

XMLHttpRequest 的请求默认是异步的。当调用 `open()` 方法时，如果没有明确指定异步参数为 `false`，则默认为异步请求。

异步请求意味着发送请求后，代码会继续执行而不会等待服务器响应。一旦服务器响应返回，将触发相应的事件(如 `onload`、`onreadystatechange` 等)，然后可以通过回调函数来处理响应数据。

虽然默认情况下是异步请求，但也可以通过将 `open()` 方法的第三个参数设置为 `false` 来创建同步请求，即 `req.open("GET",'/json/cats.json', false);`
。在同步请求中，代码会阻塞在发送请求这一行，直到服务器返回响应后才会继续执行后续代码。

需要注意的是，将请求设置为同步可能会导致用户界面冻结，并阻塞其他操作，因此在大多数情况下，推荐使用异步请求以提高用户体验和页面的响应性。

总结来说，XMLHttpRequest 的请求默认是异步的，可以通过设置 `open()` 方法的第三个参数为 `false` 来创建同步请求，但通常建议使用异步请求来避免阻塞页面和提升用户体验。

### fetch

```javascript
fetch('/json/cats.json')
    .then(response => response.json())
    .then(data => {
        document.getElementById('message').innerHTML = JSON.stringify(data);
    })
```

这段代码使用 Fetch API 发起一个 GET 请求，获取位于 `/json/cats.json` 路径下的 JSON 文件，并将获取到的 JSON 数据显示在 HTML 页面上。

具体解释如下：

1. `fetch('/json/cats.json')`：使用 Fetch API 发起一个 GET 请求，请求的 URL 是 `/json/cats.json`。

2. `.then(response => response.json())`：通过调用 `then()` 方法，对请求的响应进行处理。在这里，我们将响应对象通过 `response.json()` 方法转换为一个 Promise 对象，该
   Promise 对象最终解析为 JSON 格式的数据。

3. `.then(data => { ... })`：在上一步的 Promise 对象解析完成后，再次调用 `then()` 方法，对解析后的数据进行处理。在这个回调函数中，我们可以访问到解析后的 JSON 数据，并进行相应的操作。

4. `document.getElementById('message').innerHTML = JSON.stringify(data);`：获取页面中具有 `id` 为 `'message'` 的元素，将解析后的 JSON
   数据转换为字符串，并将字符串设置为该元素的内容。

总结来说，这段代码使用 Fetch API 发起一个异步的 GET 请求来获取 `/json/cats.json` 文件的内容。通过 Promise 链式调用，将获取到的 JSON 数据转换为字符串，并将其显示在具有 `'message'`
id 的元素中。Fetch API 提供了更现代和简洁的方式来进行网络请求，并使用 Promise 来处理异步操作，以便更好地管理和处理响应数据。

### then里面的函数返回 Promise 才可以继续调用then吗?

是的，当在 `then` 方法中的回调函数返回一个 Promise 对象时，才能继续链式调用 `then` 方法。

在 Promise 链式调用中，每个 `then` 方法都会返回一个新的 Promise 对象。如果回调函数返回一个非 Promise 的值，下一个 `then` 方法会将该值包装在一个已解析(fulfilled)的 Promise
对象中，并将其作为下一个 `then` 方法的参数。

但是，如果回调函数返回一个 Promise 对象，那么下一个 `then` 方法会等待该 Promise 对象解析(fulfilled)后，才会被调用。这样可以确保在前一个 Promise 对象解析完成后，再进行后续的操作或者异步请求。

这种机制允许我们在 Promise 链中进行连续的异步操作，确保它们按照预期的顺序执行。通过返回 Promise 对象，可以将异步操作串联起来，便于处理和管理异步任务的结果。

下面是一个示例，演示了在 `then` 方法中返回 Promise 对象的用法：

```
javascriptfetch('/json/cats.json')
  .then(response => response.json())
  .then(data => {
    return new Promise((resolve, reject) => {
      // 异步操作
      setTimeout(() => {
        resolve('Additional data');
      }, 2000);
    });
  })
  .then(additionalData => {
    console.log(additionalData);
  })
  .catch(error => {
    console.error(error);
  });

```

在上述示例中，第二个 `then` 方法返回了一个新的 Promise 对象，在 2 秒后解析为 `'Additional data'`。然后，该值被传递给下一个 `then` 方法进行处理。

通过返回 Promise 对象，我们可以处理更多的异步操作，确保它们按照正确的顺序执行，并在需要时捕获错误(通过 `catch` 方法)进行处理。这样可以提高代码的可读性和灵活性。
### fetch("https://raw.githubusercontent.com/freeCodeCamp/ProjectReferenceData/master/GDP-data.json") .then((response) => { return response.json() }) response 获取("https://raw.githubusercontent.com/freeCodeCamp/ProjectReferenceData/master/GDP-data.json”) .then（（响应) => { 返回响应.json() }) 响应

在这段代码中，`fetch()` 函数发送了一个 GET 请求到指定的
URL([https://raw.githubusercontent.com/freeCodeCamp/ProjectReferenceData/master/GDP-data.json)，以获取](https://raw.githubusercontent.com/freeCodeCamp/ProjectReferenceData/master/GDP-data.json%EF%BC%89%EF%BC%8C%E4%BB%A5%E8%8E%B7%E5%8F%96)
JSON 数据。然后，通过 `then()` 方法链式调用，对请求的响应进行处理。

在这里，`(response) => { return response.json() }` 是一个回调函数，用于处理响应数据。它将响应对象通过 `response.json()` 方法转换为一个 Promise 对象，该 Promise
对象最终解析为 JSON 格式的数据。

所以，`response` 在这段代码中是一个表示响应的对象。通过调用 `response.json()` 方法，我们可以将响应对象转换为包含 JSON 数据的 Promise 对象。

您可以继续通过链式调用 `.then()` 方法，处理解析后的 JSON 数据或执行其他操作。例如，可以使用 `.then((data) => { console.log(data) })` 来在控制台输出解析后的 JSON 数据。

请注意，这段代码中的 `fetch()` 请求是异步操作，因此在获取到数据之前，后续的代码会继续执行。您可以将后续操作放在 `.then()` 方法中，以确保在获取到数据后再进行相应的处理。

### 上面的这段代码中 response 的 json 方法属于哪个原型

在这段代码中，`response.json()` 方法属于 `Response` 对象的原型。`Response` 是 Fetch API 提供的一个内置对象，表示 HTTP 请求的响应。它提供了一系列方法来处理和操作响应数据。

`Response` 对象的原型上定义了一个名为 `json()` 的方法，用于从响应中提取 JSON 数据并返回一个 Promise 对象。通过调用 `response.json()`，我们可以将响应的主体内容解析为 JSON
格式的数据。

值得注意的是，`Response` 对象的 `json()` 方法会异步读取响应的主体内容，因此返回的是一个 Promise 对象。在 Promise 解析完成后，我们可以通过 `.then()` 方法中的回调函数获取到解析后的 JSON
数据。

总结来说，`response.json()` 方法是 `Response` 对象原型上的一个方法，用于将响应的主体内容解析为 JSON 数据，并返回一个 Promise 对象。
