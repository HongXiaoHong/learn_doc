#!D:\app\code\git\Git\bin\bash
# --------- 上面的bash 记得改成本地安装git中顺便安装的bash的路径 -----
echo 'hello shell'
my_name='hong'
# 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效
echo '我的名字是 ${my_name}'
# 双引号里可以有变量
echo "我的名字是 ${my_name}"


# 字符串
string="abcdef"
# 获取长度
echo ${#string}   # 输出 6
# 截取子串
echo ${string:1:4} # 输出 bcde
# 查找字符 b 或 c 的位置(哪个字母先出现就计算哪个)
echo `expr index "$string" bc`  # 输出 2

# 数组
array_name=(0 1 2 3)
# 读取数组某个元素
echo ${array_name[0]}
# 获取整个数组
echo ${array_name[@]}
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
length=${#array_name[n]}

# 传递参数
# $0 为执行的文件名（包含文件路径
echo "文件名是 $0"
# $#	传递到脚本的参数个数
# $*	以一个单字符串显示所有向脚本传递的参数。
# 如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
# $$	脚本运行的当前进程ID号
# $!	后台运行的最后一个进程的ID号
# $@	与$*相同，但是使用时加引号，并在引号中返回每个参数。
# 如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
# $-	显示Shell使用的当前选项，与set命令功能相同。
# $?	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。


# 通过脚本创建六个redis配置
for port in $(seq 1 6);do
mkdir -p e:/documents/notes/learn_doc/resources/system/linux/node-${port}/conf
touch e:/documents/notes/learn_doc/resources/system/linux/node-${port}/conf/redis.conf 
cat <<EOF > e:/documents/notes/learn_doc/resources/system/linux/node-${port}/conf/redis.conf 
port 6379
bind 0.0.0.0
cluster-enabled yes
cluster-config-file nodes.conf cluster-node-timeout 5000
cluster-announce-ip 172.38.0.1${port} cluster-announce-port 6379
cluster-announce-bus-port 16379 appendonly yes
EOF
done