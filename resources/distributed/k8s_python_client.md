# python k8s 客户端

todo

[kubernetes-client/python: Official Python client library for kubernetes (github.com)](https://github.com/kubernetes-client/python)

>   [https://github.com/kubernetes-client/python/blob/master/examples/pod\_exec.py](https://github.com/kubernetes-client/python/blob/master/examples/pod%5C_exec.py) 我看到还有一个python的库叫做 kubernetes-client 可以交互式操作k8s, 现在你是一个高级的python工程师, 请你给出一个示例

这是一个使用 `kubernetes-client` 库在 Python 中操作 Kubernetes 的示例代码。这个示例展示了如何使用 `exec` 在 Busybox 容器中执行命令。

```python
pythonimport time
from kubernetes import config
from kubernetes.client import Configuration
from kubernetes.client.api import core_v1_api
from kubernetes.client.rest import ApiException
from kubernetes.stream import stream

def exec_commands(api_instance):
    name = 'busybox-test'
    resp = None
    try:
        resp = api_instance.read_namespaced_pod(name=name, namespace='default')
    except ApiException as e:
        if e.status != 404:
            print("Unknown error: %s" % e)
            exit(1)
    if not resp:
        print("Pod %s does not exist. Creating it..." % name)
        pod_manifest = {
            'apiVersion': 'v1',
            'kind': 'Pod',
            'metadata': {
                'name': name
            },
            'spec': {
                'containers': [{
                    'image': 'busybox',
                    'name': 'sleep',
                    "args": [
                        "/bin/sh",
                        "-c",
                        "while true;do date;sleep 5; done"
                    ]
                }]
            }
        }
        resp = api_instance.create_namespaced_pod(body=pod_manifest, namespace='default')
        while True:
            resp = api_instance.read_namespaced_pod(name=name, namespace='default')
            if resp.status.phase != 'Pending':
                break
            time.sleep(1)
        print("Done.")
    # Calling exec and waiting for response
    exec_command = [
        '/bin/sh',
        '-c',
        'echo This message goes to stderr; echo This message goes to stdout']
    resp = stream(api_instance.connect_get_namespaced_pod_exec,
                  name,
                  'default',
                  command=exec_command,
                  stderr=True, stdin=False,
                  stdout=True, tty=False)
    print("Response: " + resp)

def main():
    config.load_kube_config()
    try:
        c = Configuration().get_default_copy()
    except AttributeError:
        c = Configuration()
    c.assert_hostname = False
    Configuration.set_default(c)
    core_v1 = core_v1_api.CoreV1Api()
    exec_commands(core_v1)

if __name__ == '__main__':
    main()
```

这个示例首先检查名为 `busybox-test` 的 pod 是否存在，如果不存在，它将创建一个。然后，它会等待 pod 不再处于 `Pending` 状态。一旦 pod 准备就绪，它将在 pod 中执行一个命令，并打印出命令的输出。

> config.load_kube_config(), 我看到代码中有一行加载配置的, 我需要配置什么吗?

[Organizing Cluster Access Using kubeconfig Files | Kubernetes --- 使用 kubeconfig 文件组织集群访问 |Kubernetes](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/)

`config.load_kube_config()` 这行代码是用来加载 Kubernetes 的配置信息的。这个配置信息通常存储在一个叫做 kubeconfig 的文件中，这个文件包含了访问 Kubernetes 集群所需要的一些信息，包括：

- 集群的地址和证书信息
- 默认的上下文（context），包括集群、命名空间和用户
- 用户的认证信息，比如用户名和密码、token 或者客户端证书等

在大多数情况下，如果你在本地运行 `kubectl` 命令行工具，并且已经成功连接到一个 Kubernetes 集群，那么这个 kubeconfig 文件通常会位于你的 home 目录下的 `.kube` 文件夹中，具体的路径是 `~/.kube/config`。

当你调用 `config.load_kube_config()` 时，Python 的 Kubernetes 客户端库会默认去这个路径下查找和加载 kubeconfig 文件。如果你的 kubeconfig 文件位于其他位置，你可以通过 `load_kube_config()` 函数的 `config_file` 参数来指定。

如果你的应用程序是运行在 Kubernetes 集群内部的一个 pod 中，那么你可以使用 `config.load_incluster_config()` 来加载运行环境的配置信息，这样你的应用程序就可以与运行它的同一个集群进行交互。

总的来说，你需要确保 kubeconfig 文件的位置正确，且文件中的内容能够正确地指向你的 Kubernetes 集群，并包含了正确的认证信息。

## 使用原因

>   我在Python中执行kubectl get pod 没有问题, 但是执行 kubectl exec -it xxx sh却卡住了, 这是为啥呢?

`kubectl exec -it xxx sh` 命令用于在指定的 pod 中启动一个新的 shell 进程。这个命令通常被用于调试，因为它允许你在运行中的 pod 内部执行命令。如果这个命令卡住了，可能有以下几个原因：

1. 网络问题：尝试重新运行命令或者检查你的网络连接。如果你是通过一个远程 Kubernetes 集群运行这个命令，可能会因为网络问题造成命令执行延迟或者失败。

2. Pod 状态问题：使用 `kubectl get pod` 命令检查你想要访问的 pod 的状态。如果 pod 处于 Pending、Terminating 或者其他非 Running 状态，`kubectl exec` 命令可能无法正常工作。

3. `sh` 进程无法启动：可能是因为你的容器镜像没有包含 `sh`，或者容器的入口点（entrypoint）不允许你启动一个新的 `sh` 进程。你可以试试其他的 shell，比如 `bash`，或者尝试直接运行你想要执行的命令，比如 `kubectl exec -it xxx -- ls`。

4. 代码问题：如果你是通过 Python 脚本执行 `kubectl exec -it xxx sh`，那么可能是你的 Python 代码有问题。例如，Python 的 `os.system` 或 `subprocess` 模块可能会遇到一些问题，因为他们需要考虑到子进程的 I/O，特别是当 `-it`（交互模式）被用于 `kubectl exec` 时。

如果你无法确定问题，我建议你首先检查你的 pod 状态和网络连接，然后尝试直接在命令行（不通过 Python 脚本）执行 `kubectl exec -it xxx sh` 命令看是否有同样的问题。如果问题依然存在，你可能需要考虑是否需要调试你的容器镜像或者 Python 代码。

`kubectl exec -it xxx sh`这个命令是一个交互式的命令，它需要一个终端以便用户可以输入命令并查看命令的输出。在 Python 中，执行这样的命令可能会有一些复杂，因为你需要处理标准输入、输出和错误，以及可能的信号传递等问题。

Python 中常用的运行系统命令的方法有 `os.system()` 和 `subprocess` 模块。然而，这两种方式处理交互式命令的能力是有限的。

- `os.system()`：这是一个相对简单的函数，它只能运行命令并返回命令的退出状态，但不能捕获命令的输出。此外，它并不支持交互式命令。

- `subprocess` 模块：这是一个功能更强大的模块，它支持运行命令、获取命令的输出和错误，以及与子进程进行交互。然而，使用 `subprocess` 来运行交互式命令可能需要一些特殊的处理，例如使用 `subprocess.Popen` 函数并通过管道（pipe）处理标准输入、输出和错误。

如果你的 Python 脚本卡在了运行 `kubectl exec -it xxx sh` 这个命令，可能是因为你没有正确处理这个命令的交互性。一个可能的解决方法是使用 `pexpect` 这个 Python 库，它是专门用来处理交互式命令的。

这是一个使用 `pexpect` 的示例：

```
pythonimport pexpect

command = "kubectl exec -it xxx sh"
child = pexpect.spawn(command)
child.expect('prompt>')  # 需要根据实际情况修改，等待 shell 提示符出现
child.sendline('ls')  # 执行 ls 命令
child.expect('prompt>')  # 再次等待 shell 提示符出现
print(child.before)  # 打印 ls 命令的输出

```

请注意，这个例子仅仅是一个基本的示例，实际的代码可能需要根据你的具体需求进行修改。
