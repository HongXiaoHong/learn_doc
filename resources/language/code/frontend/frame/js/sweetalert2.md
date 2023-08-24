# 好看的弹窗之 sweetalert2

## 引入
```html
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
```


```bash
npm install sweetalert2
```

## 例子
https://sweetalert2.github.io/#examples

### 弹出成功信息
```javascript
Swal.fire({
  icon: 'success',
  title: 'success',
  text: 'you got it!',
})
```
### 弹出错误信息
```javascript
Swal.fire({
  icon: 'error',
  title: 'Oops...',
  text: 'Something went wrong!',
  footer: '<a href="">Why do I have this issue?</a>'
})
```