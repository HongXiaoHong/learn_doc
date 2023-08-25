# windows

- todo
  - https://blog.csdn.net/sinat_29217765/article/details/105302244

## 指令
### start | 启动程序/查看文件
Windows 的 `start` 命令是一个非常有用的命令行工具，它可以用于启动应用程序、打开文件、访问网址等。通过 `start` 命令，你可以在命令提示符窗口或批处理脚本中执行各种操作，而无需手动打开应用程序或文件。

下面是一些常见的用法和示例：

1. 启动应用程序：
   ```
   start "notepad.exe"  // 启动记事本应用程序
   start "chrome.exe"   // 启动 Google Chrome 浏览器
   ```

2. 打开文件：
   ```
   start "C:\path\to\file.txt"  // 打开文本文件
   start "D:\path\to\image.jpg" // 打开图片文件
   ```

3. 访问网址：
   ```
   start "https://www.example.com"    // 打开指定网址
   start "http://localhost:3000"      // 打开本地开发服务器
   ```

4. 执行命令或脚本：
   ```
   start "cmd /k echo Hello World"      // 在新的命令提示符窗口中执行命令
   start "powershell -File script.ps1"  // 在新的 PowerShell 窗口中执行脚本
   ```

使用 `start` 命令时，你可以通过双引号将应用程序、文件路径或网址括起来。这样可以确保路径中的空格或特殊字符被正确解析。

此外，`start` 命令还支持一些选项，例如：

- `/MIN`：以最小化窗口模式启动应用程序。
- `/MAX`：以最大化窗口模式启动应用程序。
- `/WAIT`：等待启动的应用程序退出后再继续执行后续命令。

你可以在命令提示符窗口中输入 `start /?` 查看更多关于 `start` 命令的帮助信息，其中包含了更多的选项和用法示例。

总结起来，`start` 命令是一个方便的工具，可以通过命令行快速启动应用程序、打开文件或访问网址，提高了工作效率。