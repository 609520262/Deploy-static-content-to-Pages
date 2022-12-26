# ROS与MATLAB网络连接
ROS网络由一个 **ROS主节点(ROS master)** 和多个ROS节点 **(ROS node)** 组成。ROS主机通过跟踪所有活跃的ROS实体来促进ROS网络中的通信。每个节点都需要向ROS主机注册，才能与网络的其余部分通信。
完整的连接步骤如下：
1. **连接到ROS网络**。要连接到ROS网络，一种方式是通过主机端(一般为linux系统)通过`roscore ` 启动ros主节点，其他从机端在不同的主机上创建节点(MATLAB通过`rosinit `建立） 。
 2. 一旦两台机器建立连接，两台机器便可正常进行ros通讯(话题通讯、服务通信等）
 3. 当节点需要断开网络的时候，可通过`rosshutdown ` 关闭当前节点；

<font face="黑体" color=#FFA500 size=3>下面将展示两种不同的连接方式：</font>
* 在MATLAB创建`master`主节点
* 连接外部的`master`主节点，也就是在其他机器上已经创建好了主节点

# 在MATLAB创建`master`主节点
在MATLAB中创建ROS主控器，调用`rosinit `<font face="黑体" color=red size=3>无需传入任何参数</font>。该函数还创建全局节点，MATLAB使用该节点与ROS网络中的其他节点进行通信。

```c
rosinit
```

> Launching ROS Core...
Done in 0.53007 seconds.
Initializing ROS master on http://172.29.207.162:57063.
Initializing global node /matlab_global_node_94513 with NodeURI http://dcc434238glnxa64:43127/ and MasterURI http://localhost:57063

出现上述字段说明创建成功，此时MATLAB外部的ROS节点现在可以加入ROS网络。他们可以使用MATLAB主机的主机名或IP地址连接到MATLAB中的ROS主机。


您可以通过调用`rosshutdown`来关闭ROS主机和全局节点。
```c
rosshutdown
```

> Shutting down global node /matlab_global_node_94513 with NodeURI http://dcc434238glnxa64:43127/ and MasterURI http://localhost:57063.
Shutting down ROS master on http://172.29.207.162:57063.

## 连接外部的`master`主节点
还可以使用`rosinit`命令(这里需要指定主机地址)连接到外部ROS主机（例如在机器人或虚拟机上运行）。可以通过两种方式指定主机的地址：通过IP地址或运行主机的计算机的主机名。

同一台机器上在每次调用`rosinit`之后，必须先调用`rosshutdown`，然后再使用不同的语法调用`rosinit`,防止出现节点冗余错误。

`“master_host”`是示例主机名，`“192.168.1.1”`是外部ROS主机的示例IP地址。根据外部主机在网络中的位置调整这些地址。如果在指定地址找不到主机，这些命令将失败。
```c
rosinit('192.168.1.1')
rosinit('master_host')
```
上述两个命令通常执行一个便可，我的建议是**初始化IP**，这样可排除有的机器主机名没被解析的情况。


对`rosinit`的两次调用都假定主机在端口`11311`上接受网络连接，这是标准的ROS主机端口。如果主机在不同的端口上运行，可以将其指定为第二个参数。要连接到主机名master_host和端口`12000`上运行的ROS主机，请使用以下命令：
```c
rosinit('master_host',12000)
```
或者也成URI的形式：
```c
rosinit('http://192.168.1.1:12000')
```
## 特别指定节点的主机
在某些情况下，您的计算机可能连接到多个网络并具有多个IP地址。此图显示了一个示例。![在这里插入图片描述](https://img-blog.csdnimg.cn/8f2a9970663345b298815f614d88a859.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQ2FuZHlfXzE=,size_20,color_FFFFFF,t_70,g_se,x_16)
左下角的计算机运行MATLAB，并连接到两个不同的网络。在一个子网中，其IP地址为`173.195.120.50`，在另一个子网中，其IP地址为`192.168.1.100`。此计算机希望连接到TurtleBot®计算机上IP地址为`192.168.1.1`的ROS主机。作为向主机注册的一部分，MATLAB全局节点必须指定其他ROS节点可以访问的IP地址或主机名。TurtleBot上的所有节点都将使用此地址向MATLAB中的全局节点发送数据。

当使用主机的IP地址`192.168.1.1`调用`rosinit`时，它会尝试检测用于联系主机的网络接口，并将其用作全局节点的IP地址。如果自动检测失败，您可以通过使用`rosinit`调用中的`NodeHost name`值对显式指定IP地址或主机名。`NodeHost name-value`对可以与已经显示的任何其他语法一起使用。
这种情况常常发生在左下角机器中创建了`docker`容器时需要不同网络的通讯。
这些命令向ROS网络公布您计算机的IP地址为`192.168.1.100`。
```c
rosinit('192.168.1.1','NodeHost','192.168.1.100')
rosinit('http://192.168.1.1:11311','NodeHost','192.168.1.100')
rosinit('master_host','NodeHost','192.168.1.100')
```
以上命令选择其中之一即可。
在ROS网络中注册节点后，您可以使用命令`rosnode info<nodename>`查看其播发的地址。通过调用节点列表，可以查看所有已注册节点的名称。

## ROS 环境变量
在高级用例中，您可能希望通过标准ROS环境变量指定ROS主机的地址和播发的节点地址。前面几节中解释的语法对于大多数用例来说应该足够了。

如果没有为`rosinit`提供参数，该函数还将检查标准ROS环境变量的值。这些变量是`ROS_MASTER_URI`、`ROS_HOSTNAME`和`ROS_IP`。可以使用getenv命令查看它们的当前值：
```c
getenv('ROS_MASTER_URI')
getenv('ROS_HOSTNAME')
getenv('ROS_IP')
```
可以使用`setenv`命令设置这些变量。设置环境变量后，无需参数调用`rosinit`。ROS主机的地址由`ROS_master_URI`指定，全局节点的播发地址由`ROS_IP`或`ROS_HOSTNAME`给出。如果为`rosinit`指定其他参数，它们将覆盖环境变量中的值。需要说明的是`ROS_IP`或`ROS_HOSTNAME`两者互为解析，通常选择一个即可。
您不必同时设置`ROS_HOSTNAME`和`ROS_IP`。如果两者都设置了，则`ROS_HOSTNAME`优先。
