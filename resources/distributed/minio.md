# minio | 分布式文件存储

官网:

[minio/minio: High Performance Object Storage for AI --- minio/minio：面向 AI 的高性能对象存储 (github.com)](https://github.com/minio/minio)

[MinIO | High Performance, Kubernetes Native Object Storage](https://min.io/)



开发文档:

[Java Quickstart Guide — MinIO Object Storage for Linux --- Java 快速入门指南 — 适用于 Linux 的 MinIO 对象存储](https://min.io/docs/minio/linux/developers/java/minio-java.html)

## 简介

[Java-MinIO-大文件上传(分片上传、断点续传、秒传)_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Gg41147BL/?spm_id_from=..search-card.all.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

[来点干货！Minio存储系统源码解析系列课程-开篇_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1bj411x7GP/?spm_id_from=333.1007.tianma.7-1-23.click&vd_source=eabc2c22ae7849c2c4f31815da49f209)

[Minio源码分析系列-开篇词 - 飞书云文档 (feishu.cn)](https://p0kt65jtu2p.feishu.cn/docx/HQR3dZsPoo9z9ExZk63cYgovn6c)

## 入门

[B站最详细的分布式文件系统MinIO入门到实战，SpringBoot整合MinIO教程]([1.课程介绍_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1ff4y1K7QA?p=1&vd_source=eabc2c22ae7849c2c4f31815da49f209))

![](https://raw.githubusercontent.com/HongXiaoHong/images/main/picture/minio.jpeg)

## 安装

docker:

```docker
mkdir -p ${HOME}/minio/data

docker run \
   -p 9000:9000 \
   -p 9090:9090 \
   --user $(id -u):$(id -g) \
   --name minio1 \
   -e "MINIO_ROOT_USER=ROOTUSER" \
   -e "MINIO_ROOT_PASSWORD=CHANGEME123" \
   -v ${HOME}/minio/data:/data \
   quay.io/minio/minio server /data --console-address ":9090"
```



podman:

```podman
mkdir -p ~/minio/data

podman run \
   -p 9000:9000 \
   -p 9090:9090 \
   -v ~/minio/data:/data \
   -e "MINIO_ROOT_USER=ROOTNAME" \
   -e "MINIO_ROOT_PASSWORD=CHANGEME123" \
   quay.io/minio/minio server /data --console-address ":9090"
```



## 基本概念

[Core Administration Concepts — MinIO Object Storage for Linux --- 核心管理概念 — 适用于 Linux 的 MinIO 对象存储](https://min.io/docs/minio/linux/administration/concepts.html)

object:

    对象是<mark>二进制数据</mark>，有时称为二进制大型 OBject （BLOB）。Blob 可以是图像、音频文件、电子表格，甚至是二进制可执行代码。MinIO 等对象存储平台提供用于存储、检索和搜索 blob 的专用工具和功能。



[buckets](https://min.io/docs/minio/linux/administration/object-management.html#buckets):

    MinIO 对象存储使用存储桶来组织对象。存储桶类似于文件系统中的<mark>文件夹或目录</mark>，其中每个存储桶可以容纳任意数量的对象。MinIO 存储桶提供与 AWS S3 存储桶相同的功能。



我们在日常使用中了解以上两个概念就可以了



其实就是对应我们的文件跟我们的目录



另外两个概念分别是

set: bucket 的集合 相当于主机
