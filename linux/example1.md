+++
title = "xiayu个人学习"
author = "liuxiayu"
github_url = "https://github.com/liuxiayu"
head_img = ""
created_at = 2021-12-06T14:52:43
updated_at = 2021-12-06T14:52:43
description = "详细记录了 grep 的使用"
tags = ["linux"]
+++
**个人学习xiayu**

**数据结构和算法**

**数组**

从数组存储的内存模型上来看，"下标"最确切的定义应该是"偏移（offset）"。前面也讲到，如果用
a 来表示数组的首地址，a\[0\]就是偏移为 0
的位置，也就是首地址，a\[k\]就表示偏移 k 个 type_size 的位置

当计算机需要随机访问数组中的某个元素时，它会首先通过下面的寻址公式，计算出该元素存储的内存地址：
a\[i\]\_address = base_address + i \* data_type_size

但是，如果数组从 1 开始计数，那我们计算数组元素
a\[k\]的内存地址就会变为：a\[k\]\_address = base_address +
(k-1)\*type_size对比两个公式，我们不难发现，从 1
开始编号，每次随机访问数组元素都多了一次减法运算，对于 CPU
来说，就是多了一次减法指令。

数组是适合查找操作，但是查找的时间复杂度并不为
O(1)。即便是排好序的数组，你用二分查找，时间复杂度也是
O(logn)。所以，正确的表述应该是，数组支持随机访问，根据下标随机访问的时间复杂度为
O(1)。

访问数组的本质就是访问一段连续内存，只要数组通过偏移计算得到的内存地址是可用的，那么程序就可能不会报任何错误。

+-----------------------------------------------------------------------+
| Bash                                                                  |
|                                                                       |
| int main(int argc, char\* argv\[\]){                                  |
|                                                                       |
| int i = 0;                                                            |
|                                                                       |
| int arr\[3\] = {0};                                                   |
|                                                                       |
| for(; i\<=3; i++){                                                    |
|                                                                       |
| arr\[i\] = 0;                                                         |
|                                                                       |
| printf(\"hello world\\n\");                                           |
|                                                                       |
| }                                                                     |
|                                                                       |
| return 0;                                                             |
|                                                                       |
| }                                                                     |
+-----------------------------------------------------------------------+

函数体内的局部变量存在栈上，且是连续压栈。在Linux进程的内存布局中，栈区在高地址空间，从高向低增长。变量i和arr在相邻地址，且i比arr的地址大，所以arr越界正好访问到i。当然，前提是i和arr元素同类型，否则那段代码仍是未决行为。

例子中死循环的问题跟编译器分配内存和字节对齐有关 数组3个元素
加上一个变量a 。4个整数刚好能满足8字节对齐 所以i的地址恰好跟着a2后面
导致死循环。。如果数组本身有4个元素
则这里不会出现死循环。。因为编译器64位操作系统下 默认会进行8字节对齐
变量i的地址就不紧跟着数组后面了。

**链表**

![Generated](https://img0.baidu.com/it/u=1921239532,3468544259&fm=26&fmt=auto){width="5.90625in"
height="3.3541666666666665in"}

链表要想随机访问第 k
个元素，就没有数组那么高效了。因为链表中的数据并非连续存储的，所以无法像数组那样，根据首地址和下标，通过寻址公式就能直接计算出对应的内存地址，而是需要根据指针一个结点一个结点地依次遍历，直到找到相应的结点。访问性能不如数组，需要O(n)的时间复杂度

在实际的软件开发中，从链表中删除一个数据无外乎这两种情况：删除结点中"值等于某个给定值"的结点；删除给定指针指向的结点。

第一种情况：单链表 双向链表 均为 O(n)

第二种情况：单链表O(n) 双向链表 O(1)

数组的缺点是大小固定，一经声明就要占用整块连续内存空间。如果声明的数组过大，系统可能没有足够的连续内存空间分配给它，导致"内存不足（out
of
memory）"。如果声明的数组过小，则可能出现不够用的情况。这时只能再申请一个更大的内存空间，把原数组拷贝进去，非常费时。链表本身没有大小的限制，天然地支持动态扩容，我觉得这也是它与数组最大的区别。

链表实现LRU的算法思路 概括下：
使用定长链表来保存所有缓存的值，并且最老的值放在链表最后面
当访问的值在链表中时：
将找到链表中值将其删除，并重新在链表头添加该值（保证链表中
数值的顺序是从新到旧） 当访问的值不在链表中时：
当链表已满：删除链表最后一个值，将要添加的值放在链表头
当链表未满：直接在链表头添加

将某个变量赋值给指针，实际上就是将这个变量的地址赋值给指针，或者反过来说，指针中存储了这个变量的内存地址，指向了这个变量，通过指针就能找到这个变量。

**栈**

实际上，栈既可以用数组来实现，也可以用链表来实现。用数组实现的栈，我们叫作顺序栈，用链表实现的栈，我们叫作链式栈。

空间复杂度指的是除了原本的数据存储空间外，算法运行还需要额外的存储空间

对于出栈操作来说，我们不会涉及内存的重新申请和数据的搬移，所以出栈的时间复杂度仍然是
O(1)。但是，对于入栈操作来说，情况就不一样了。当栈中有空闲空间时，入栈操作的时间复杂度为
O(1)。但当空间不够时，就需要重新申请内存和数据搬移，所以时间复杂度就变成了
O(n)。

![Generated](media/image2.png){width="5.90625in" height="3.3125in"}

这 K 次入栈操作，总共涉及了 K 个数据的搬移，以及 K 次 simple-push
操作。将 K 个数据搬移均摊到 K
次入栈操作，那每个入栈操作只需要一个数据搬移和一个 simple-push
操作。以此类推，入栈操作的均摊时间复杂度就为 O(1)。

操作系统给每个线程分配了一块独立的内存空间，这块内存被组织成"栈"这种结构,
用来存储函数调用时的临时变量。每进入一个函数，就会将临时变量作为一个栈帧入栈，当被调用函数执行完成，返回之后，将这个函数对应的栈帧出栈

我们使用两个栈，X 和 Y，我们把首次浏览的页面依次压入栈
X，当点击后退按钮时，再依次从栈 X 中出栈，并将出栈的数据依次放入栈
Y。当我们点击前进按钮时，我们依次从栈 Y 中取出数据，放入栈 X 中。当栈 X
中没有数据时，那就说明没有页面可以继续后退浏览了。当栈 Y
中没有数据，那就说明没有页面可以点击前进按钮浏览了。

为什么函数调用要用"栈"来保存临时变量呢？用其他数据结构不行吗？

从调用函数进入被调用函数，对于数据来说，变化的是什么呢？是作用域。所以根本上，只要能保证每进入一个新的函数，都是一个新的作用域就可以。而要实现这个，用栈就非常方便。在进入被调用函数的时候，分配一段栈空间给这个函数的变量，在函数结束的时候，将栈顶复位，正好回到调用函数的作用域内。

**队列**

用环形数组实现

用链表实现

用数组实现

**Golang**

获取汇编指令的优化过程：

+-----------------------------------------------------------------------+
| Bash                                                                  |
|                                                                       |
| \$ GOSSAFUNC=main go build main.go                                    |
+-----------------------------------------------------------------------+

每一个 Go 的源代码文件最终会被归纳成一个
[SourceFile](https://golang.org/ref/spec#Source_file_organization)
结构[5](https://draveness.me/golang/docs/part1-prerequisite/ch02-compile/golang-compile-intro/#fn:5)：

+-----------------------------------------------------------------------+
| Go                                                                    |
|                                                                       |
| \"json.go\": SourceFile {                                             |
|                                                                       |
| PackageName: \"json\",                                                |
|                                                                       |
| ImportDecl: \[\]Import{                                               |
|                                                                       |
| \"io\",                                                               |
|                                                                       |
| },                                                                    |
|                                                                       |
| TopLevelDecl: \...                                                    |
|                                                                       |
| }                                                                     |
+-----------------------------------------------------------------------+

这个抽象语法树中包括当前文件属于的包名、定义的常量、结构体和函数等。

顶层声明有五大类型，分别是常量、类型、变量、函数和方法，你可以在文件
[src/cmd/compile/internal/syntax/parser.go](https://github.com/golang/go/blob/master/src/cmd/compile/internal/syntax/parser.go)
中找到这五大类型的定义

![Generated](media/image3.png){width="5.90625in"
height="2.6979166666666665in"}

**容器**

**容器进程**

**Docker stop是怎么停止的**

containerd会先向容器中的init进程发送SIGTERM，如果init进程注册了SIGTERM
handler(并且handler让进程退出了）那么整个容器就退出了，如果容器的init进程没有注册SIGTERM,
那么过30秒， containerd再向容器的init进程发送SIGKILL

cgroup资源限制

cgroup v1 blkio 可以对 Direct I/O做限流。

cgroup v1 net_cls 配合 tc 可以对网络限流。

cgroup v2 io + memory 一起可以对 Direct I/O 和 Buffered
I/O做限流，但是不支持xfs

如果做基础镜像

docker base image, 拿centos为例子，可以建一个目录，让后把需要的rpm
安装在这个目录下面，然后把目录打成一个tarball, 用docker
import成为一个base image.

<https://github.com/moby/moby/blob/master/contrib/mkimage-yum.sh>

1 号进程是第一个用户态的进程，由它直接或者间接创建了 Namespace
中的其他进程。

Kill -9 杀容器的1号init进程，杀不掉，其实最关键的一点就是 handler ==
SIG_DFL 。Linux 内核针对每个 Namespace 里的 init 进程，把只有 default
handler 的信号都给忽略了。所以 init 进程是永远不能被 SIGKILL
所杀，但是可以被 SIGTERM 杀死。

无论进程还是线程，在 Linux 内核里其实都是用
task_struct{}这个结构来表示的。它其实就是任务（task），也就是 Linux
里基本的调度单位。为了方便讲解，我们在这里暂且称它为进程。

![Generated](media/image4.png){width="5.90625in" height="4.4375in"}

进程在调用 do_exit() 退出的时候，还有两个状态。一个是
EXIT_DEAD，也就是进程在真正结束退出的那一瞬间的状态；第二个是
EXIT_ZOMBIE 状态，这是进程在 EXIT_DEAD
前的一个状态，而我们今天讨论的僵尸进程，也就是处于这个状态中。

一台 Linux 机器上的进程总数目是有限制的cat
/proc/sys/kernel/pid_max，如果机器中 CPU 数目小于等于 32，那么 pid_max
就会被设置为 32768（32K）；如果机器中的 CPU 数目大于 32，那么 pid_max
就被设置为 N\*1024 （N 就是 CPU 数目）。

pids Cgroup 通过 Cgroup 文件系统的方式向用户提供操作接口，一般它的
Cgroup 文件系统挂载点在 /sys/fs/cgroup/pids。

既然进程号资源在宿主机上是有限的，显然残留的僵尸进程多了以后，给系统带来最大问题就是它占用了进程号。这就意味着，残留的僵尸进程，在容器里仍然占据着进程号资源，很有可能会导致新的进程不能运转。

在kuberenetes下，kubelet还是调用
containerd/runc去启动容器的，每个容器的父进程是containerd-shim,
最终shim可以回收僵尸进程。

清理僵尸进程的两个思路

（1）kill掉僵尸进程的父进程，此时僵尸进程会归附到init(1)进程下，而init进程一般都有正常的wait()或watipid()回收机制。

（2）利用dumb-init/tini之类的小型init服务来解决僵尸进程

task_struct
是内核中描述进程的结构，每个进程申请的内存，打开的文件等信息都记录在这个结构里。当进程退出的时候，需要先把进程里的这些资源释放，最后再释放task_struct结构。

当docker stop 这个容器时，init 进程（15909）收到的是 SIGTERM
信号，而另外一个进程（15959）收到的果然是 SIGKILL 信号。

进程对每种信号的处理，包括三个选择：调用系统缺省行为、捕获、忽略signal(SIGTERM,
sig_handler);， SIGKILL 和 SIGSTOP
信号是两个特权信号，它们不可以被捕获和忽略，这个特点也反映在 signal()
调用上。

![Generated](media/image5.png){width="5.90625in" height="3.3125in"}

而在这个函数中，如果是处于退出状态的 init 进程，它会向 Namespace
中的其他进程都发送一个 SIGKILL 信号。

我们该怎么做，才能让容器中的进程收到 SIGTERM
信号呢？你可能已经想到了，就是让容器 init 进程来转发 SIGTERM
信号。的确是这样，比如 Docker Container 里使用的 tini 作为 init
进程，tini 的代码中就会调用 sigtimedwait()
这个函数来查看自己收到的信号，然后调用 kill() 把信号发给子进程。

怎么解决停止容器的时候，容器内应用程序被强制杀死的问题呢？解决的方法就是在容器的
init
进程中对收到的信号做个转发，发送到容器中的其他子进程，这样容器中的所有进程在停止时，都会收到
SIGTERM，而不是 SIGKILL 信号了。

胖容器的init进程其实是一个bash脚本run.sh,
由它来启动jvm的程序。但是run.sh本身没有注册SIGTERM handler, 也不forward
SIGTERM给子进程jvm。当stop容器的时候，run.sh先收到一个SIGTERM,
run.sh没有注册SIGTERM,
所以呢对SIGTERM没有反应，contaienrd过30秒，会发SIGKILL给run.sh,
这样run.sh退出do_exit()，在退出的时候同样给子进程jvm程序发送了SIGKILL而不是SIGTERM。其实呢，jvm的程序是注册了SIGTERM
handler的，但是没有机会调用handler了。

为了保证子进程先收到转发的SIGTERM,
类似tini的做法是，自己在收到SIGTERM的时候不退出，转发SIGTERM给子进程，子进程收到SIGTERM退出之后会给父进程发送SIGCHILD，
tini是收到SIGCHILD之后主动整个程序退出。

我觉得容器里的init进程，应该是具备这些信号处理的能力：

1\. 至少转发SIGTERM给容器里其他的关键子进程。

2\. 能够接受到外部的SIGTERM信号而退出，（这里可以是通过注册SIGTERM
handler, 也可以像tini一样先转发SIGTERM
给子进程，然后收到SIGCHILD后自己主动退出）

3\. 具有回收zombie进程的能力

是否加了\--init的区别如下

![Generated](media/image6.png){width="5.90625in"
height="2.7083333333333335in"}

**容器CPU**

![Generated](media/image7.png){width="5.90625in" height="3.3125in"}

+-----------------------------------------------------------------------+
| Bash                                                                  |
|                                                                       |
| 当这个用户程序代码中调用了系统调用，比如说 read()                     |
| 去读取一个文件，这时候这个用户进程就会从用户态切换到内核态。          |
|                                                                       |
| 内核态 read() 系统调用在读到真正 disk                                 |
| 上的文件前，就会进行一些文件系统层的操作。那么这                      |
| 些代码指令的消耗就属于\"sy\"，这里就对应上面图里的第二个框。\"sy\"是  |
| \"system\"的缩写，代表内核态 CPU 使用。                               |
|                                                                       |
| 接下来，这个 read() 系统调用会向 Linux 的 Block Layer 发出一个 I/O    |
| Request，触发一个真正的磁盘读取操作。                                 |
|                                                                       |
| 这时候，这个进程一般会被置为 TASK_UNINTERRUPTIBLE。而 Linux           |
| 会把这段时间                                                          |
| 标示成\"wa\"，对应图中的第三个框。\"wa\"是\"iowait\"的缩写，代表等待  |
| I/O 的时间，这里的 I/O 是指 Disk I/O。                                |
|                                                                       |
| 紧接着，当磁盘返回数据时，进程在内核态拿到数据，这里仍旧是内核态的    |
| CPU 使用中的\"sy\"，也就是图中的第四个框。                            |
|                                                                       |
| 然后，进程                                                            |
| 再从内核态切换回用户态，在用户态得到文件数据，这里进程又回到用户态的  |
| CPU 使用，\"us\"，对应图中第五个框。                                  |
|                                                                       |
| 如果这时这台机器在网                                                  |
| 络收到一个网络数据包，网卡就会发出一个中断（interrupt）。相应地，CPU  |
| 会响应中断，然后进入中断服务程序。这时，CPU                           |
| 就会进入\"hi\"，也就是第七个框。\"hi\"是\"hardware irq\"的缩写，代表  |
| CPU                                                                   |
| 处理硬中断的开销                                                      |
| 。由于我们的中断服务处理需要关闭中断，所以这个硬中断的时间不能太长。  |
|                                                                       |
| 但是，                                                                |
| 发生中断后的工作是必须要完成的，如果这些工作比较耗时那怎么办呢？Linux |
| 中有一个软中断的                                                      |
| 概念（softirq），它可以完成这些耗时比较长的工作。你可以这样理解这个软 |
| 中断，从网卡收到数据包的大部分工作，都是通过软中断来处理的。那么，CPU |
| 就会进入到第八个框，\"si\"。这里\"si\"是\"softirq\"的缩写，代表 CPU   |
| 处理软中断的开销                                                      |
|                                                                       |
| 这里你要注意，无论是\"hi\"还是\"si\"，它们的 CPU 时间都不会计入进程的 |
| CPU 时间。这是因为本身它们在处理的时候就不属于任何一个进程。          |
+-----------------------------------------------------------------------+

![Generated](media/image8.png){width="5.90625in" height="3.3125in"}

/sys/fs/cgroup/cpu 控制组管理

+-----------------------------------------------------------------------+
| Bash                                                                  |
|                                                                       |
| \[root\@localhost                                                     |
| 00781e6d1a5960910e6e616e38a600da966a904aed2236ba968ff0339249d50d\]\#  |
| ls                                                                    |
|                                                                       |
| cgroup.clone_children cgroup.procs cpuacct.usage cpu.cfs_period_us    |
| cpu.rt_period_us cpu.shares notify_on_release                         |
|                                                                       |
| cgroup.event_control cpuacct.stat cpuacct.usage_percpu                |
| cpu.cfs_quota_us cpu.rt_runtime_us cpu.stat tasks                     |
|                                                                       |
| 第一个参数是 cpu.cfs_period_us，它是 CFS                              |
| 算法的一个调度周期，一般它的值是 100000，以 microseconds 为单位，也就 |
| 100ms。                                                               |
|                                                                       |
| 第二个参数是 cpu.cfs_quota_us，它"表示 CFS                            |
| 算法中，在一个调度周期里这个控制组被允许的运行时间，比如这个值为      |
| 50000 时，就是 50ms。如果用这个值去除以调度周期（也就是               |
| cpu.cfs_period_us），50ms/100ms = 0.5，这样这个控制组被允许使用的 CPU |
| 最大配额就是 0.5 个 CPU。从这里能够看出，cpu.cfs_quota_us             |
| 是一个绝对值。如果这个值是 200000，也就是 200ms，那么它除以           |
| period，也就是 200ms/100ms=2。你看，结果超过了 1 个                   |
| CPU，这就意味着这时控制组需要 2 个 CPU 的资源配额。                   |
|                                                                       |
| 我们再来看看第三个参数， cpu.shares。这个值是 CPU Cgroup              |
| 对于控制组之间的 CPU 分配比例，它的缺省值是 1024。                    |
+-----------------------------------------------------------------------+

./threads-cpu/threads-cpu 2 & \# 启动一个消耗2个CPU的程序echo \$! \>
/sys/fs/cgroup/cpu/group2/group3/cgroup.procs
#把程序的pid加入到控制组echo 150000 \>
/sys/fs/cgroup/cpu/group2/group3/cpu.cfs_quota_us #限制CPU为1.5CPUecho
1024 \> /sys/fs/cgroup/cpu/group2/group3/cpu.shares

第一点，cpu.cfs_quota_us 和 cpu.cfs_period_us
这两个值决定了每个控制组中所有进程的可使用 CPU 资源的最大值。

第二点，cpu.shares 这个值决定了 CPU Cgroup 子系统下控制组可用 CPU
的相对比例，不过只有当系统上 CPU
完全被占满的时候，这个比例才会在各个控制组间起作用。

Limit CPU 就是容器所在 Cgroup 控制组中的 CPU 上限值，Request CPU
的值就是控制组中的 cpu.shares 的值。

Request CPU\"就是无论其他容器申请多少 CPU 资源，即使运行时整个节点的 CPU
都被占满的情况下，我的这个容器还是可以保证获得需要的 CPU 数目

这个 stat 文件就是 /proc/\[pid\]/stat. 那么这两项数值 utime 和 stime
是什么含义呢？utime 是表示进程的用户态部分在 Linux 调度中获得 CPU 的
ticks，stime 是表示进程的内核态部分在 Linux 调度中获得 CPU 的 ticks。在
Linux 中有个自己的时钟，它会周期性地产生中断。每次中断都会触发 Linux
内核去做一次进程调度，而这一次中断就是一个
tick。因为是周期性的中断，比如 1 秒钟 100 次中断，那么一个 tick
作为一个时间单位看的话，也就是 1/100 秒。

进程的 CPU 使用率 =((utime_2 -- utime_1) + (stime_2 -- stime_1)) \*
100.0 / (HZ \* et \* 1 ) 第一个 HZ 就是 1 秒钟里 ticks 的次数（这里值是
100）。第二个参数 et 是我们刚才说的那个"瞬时"的时间，也就是得到 utime_1
和 utime_2 这两个值的时间间隔。 这里的1就是1个CPU的意思

进程的 CPU 使用率 =（进程的 ticks/ 单个 CPU 总 ticks）\*100.0

系统cpu怎么算：1）先得到这1 秒钟的 ticks：cat /proc/stat \| grep \"cpu
\";sleep 1;cat /proc/stat \| grep \"cpu \"

![Generated](media/image9.png){width="5.90625in" height="3.3125in"}

2）我们想要计算每一种 CPU
使用率的百分比，其实也很简单。我们只需要把所有在这 1 秒里的 ticks
相加得到一个总值，然后拿某一项的 ticks
值，除以这个总值。拿ticks：getconf CLK_TCK

拿到容器的cpu占用率

+-----------------------------------------------------------------------+
| Bash                                                                  |
|                                                                       |
| docker exec xxxx ls -l /proc \| awk \'{print \$NF}\' \| grep          |
| \"\[\[:digit:\]\]\" \| sort \| uniq                                   |
|                                                                       |
| #得到所有进程目录                                                     |
|                                                                       |
| 0                                                                     |
|                                                                       |
| 1                                                                     |
|                                                                       |
| 10                                                                    |
|                                                                       |
| 11                                                                    |
|                                                                       |
| 12                                                                    |
|                                                                       |
| 13                                                                    |
|                                                                       |
| 14                                                                    |
|                                                                       |
| 用下面的公式                                                          |
|                                                                       |
| ((600 -- 399) + (0 -- 0)) \* 100.0 / (100 \* 1 \* 1) =201             |
|                                                                       |
| for pid in result                                                     |
|                                                                       |
| docker exec xxxx cat /proc/pid/stat \| awk \'{print \$14}\'           |
|                                                                       |
| docker exec xxxx cat /proc/pid/stat \| awk \'{print \$15}\'           |
|                                                                       |
| getconf CLK_TCK                                                       |
|                                                                       |
| #!/bin/bash                                                           |
|                                                                       |
| cpuinfo1=\$(cat /sys/fs/cgroup/cpu,cpuacct/cpuacct.stat)              |
|                                                                       |
| utime1=\$(echo \$cpuinfo1\|awk \'{print \$2}\')                       |
|                                                                       |
| stime1=\$(echo \$cpuinfo1\|awk \'{print \$4}\')                       |
|                                                                       |
| sleep 1                                                               |
|                                                                       |
| cpuinfo2=\$(cat /sys/fs/cgroup/cpu,cpuacct/cpuacct.stat)              |
|                                                                       |
| utime2=\$(echo \$cpuinfo2\|awk \'{print \$2}\')                       |
|                                                                       |
| stime2=\$(echo \$cpuinfo2\|awk \'{print \$4}\')                       |
|                                                                       |
| cpus=\$((utime2+stime2-utime1-stime1))                                |
|                                                                       |
| echo \"\${cpus}%\"                                                    |
|                                                                       |
| 宿主机看容器的cpu使用率                                               |
|                                                                       |
| /sys/fs/cgroup/cpu,cpuacct/docker/00781e6d                            |
| 1a5960910e6e616e38a600da966a904aed2236ba968ff0339249d50d/cpuacct.stat |
|                                                                       |
| 统计进程的CPU使用率                                                   |
|                                                                       |
| #!/bin/bash                                                           |
|                                                                       |
| pid=\`ps aux \| grep threads-cpu \| grep -v grep \| awk \'{print      |
| \$2}\'\`                                                              |
|                                                                       |
| utime_1=\`awk \'{print \$14}\' /proc/\${pid}/stat\`                   |
|                                                                       |
| stime_1=\`awk \'{print \$15}\' /proc/\${pid}/stat\`                   |
|                                                                       |
| sleep 1;                                                              |
|                                                                       |
| utime_2=\`awk \'{print \$14}\' /proc/\${pid}/stat\`                   |
|                                                                       |
| stime_2=\`awk \'{print \$15}\' /proc/\${pid}/stat\`                   |
|                                                                       |
| #echo \$utime_1 \$stime_1 \$utime_2 \$stime_2                         |
|                                                                       |
| cpus=\$((utime_2+stime_2-utime_1-stime_1))                            |
|                                                                       |
| #echo \$cpus                                                          |
|                                                                       |
| echo \"进程id为\${pid}的使用率:\${cpus}%\"                            |
+-----------------------------------------------------------------------+

**Load avarge**

对于一个单个 CPU 的系统，如果在 1
分钟的时间里，处理器上始终有一个进程在运行，同时操作系统的进程可运行队列中始终都有
9 个进程在等待获取 CPU 资源。那么对于这 1 分钟的时间来说，系统的\"load
average\"就是 1+9=10

Load Average 都是 Linux 进程调度器中可运行队列（Running
Queue）里的一段时间的平均进程数目 包括等待io的进程

**容器内存**

这个和 Linux 进程的内存申请策略有关，Linux 允许进程在申请内存的时候是
overcommit
的，这是什么意思呢？就是说允许进程申请超过实际物理内存上限的内存。

那么你一定会问了，在发生 OOM 的时候，Linux
到底是根据什么标准来选择被杀的进程呢？这就要提到一个在 Linux
内核里有一个 oom_badness()
函数，就是它定义了选择进程的标准。其实这里的判断标准也很简单，函数中涉及两个条件：第一，进程已经使用的物理内存页面数。第二，每个进程的
OOM 校准值 oom_score_adj。在 /proc 文件系统中，每个进程都有一个
/proc/\<pid>/oom_score_adj 的接口文件。我们可以在这个文件中输入 -1000 到
1000 之间的任意一个数值，调整进程被 OOM Kill 的几率。

+-----------------------------------------------------------------------+
| PHP                                                                   |
|                                                                       |
| adj = (long)p-\>signal-\>oom_score_adj;                               |
|                                                                       |
| points = get_mm_rss(p-\>mm) + get_mm_counter(p-\>mm, MM_SWAPENTS)     |
| +mm_pgtables_bytes(p-\>mm) / PAGE_SIZE;                               |
|                                                                       |
| adj \*= totalpages / 1000;                                            |
|                                                                       |
| points += adj;                                                        |
+-----------------------------------------------------------------------+

结合前面说的两个条件，函数 oom_badness()
里的最终计算方法是这样的：用系统总的可用页面数，去乘以 OOM 校准值
oom_score_adj，再加上进程已经使用的物理页面数，计算出来的值越大，那么这个进程被
OOM Kill 的几率也就越大。

\"/sys/fs/cgroup/memory 目录下 memory.limit_in_bytes，memory.oom_control
和 memory.usage_in_bytes

![Generated](media/image10.png){width="5.90625in" height="3.3125in"}

如果将memory oom
control的参数设置为1，那么容器里的进程在使用内存到达memory limit in
bytes之后，不会被oom
killer杀死，但memalloc进程会被暂停申请内存，状态会变成因等待资源申请而变成task
TASK_UNINTERRUPTIBLE

第一，Memory Cgroup
中每一个控制组可以为一组进程限制内存使用量，一旦所有进程使用内存的总量达到限制值，缺省情况下，就会触发
OOM
Killer。这样一来，控制组里的"某个进程"就会被杀死。第二，这里杀死"某个进程"的选择标准是，控制组中总的可用页面乘以进程的
oom_score_adj，加上进程已经使用的物理内存页面，所得值最大的进程，就会被系统选中杀死。

我们通过查看内核的日志，使用用 journalctl -k 命令，或者直接查看日志文件
/var/log/message，

![Generated](media/image11.png){width="5.90625in"
height="0.4270833333333333in"}

比如下面的日志里，我们看到 init 进程的\"rss\"是 1 个页面，mem_alloc
进程的\"rss\"是 130801 个页面，内存页面的大小一般是
4KB，我们可以做个估算，130801 \* 4KB 大致等于 512MB。

**oom原因**

一般有这两种情况：

第一种情况是这个进程本身的确需要很大的内存，这说明我们给
memory.limit_in_bytes
里的内存上限值设置小了，那么就需要增大内存的上限值。

第二种情况是进程的代码中有 Bug，会导致内存泄漏，进程内存使用到达了
Memory Cgroup
中的上限。如果是这种情况，就需要我们具体去解决代码里的问题了。

**可杀的深度睡眠**

Linux因此推出了一个特殊的深度睡眠状态，叫做

TASK_KILLABLE（可杀的深度睡眠）：可以被等到的资源唤醒，不能被常规信号唤醒，但是可以被致命信号唤醒，**醒后即死**。

一般情况下D state process是不能被kill的。如果可以被kill,
可能有两种情况，1. D process 自己恢复了， 2. process显示为D,
但它是TASK_KILLABLE process

cgroup底下的memory.usage_in_bytes是不是可以理解为通过top看到的usage与buffer/cached内存之和

假如oom的评判标准是包含buffer/cached的内存使用

OOM是不包含buf/cache的。总的memory usage如果超过memory limit,
那么应该是先发生memory reclaim去释放cache。

CPU应该是可压缩资源，即便达到设置的资源限额也不会退出，而内存属于不可压缩资源，资源不足时就会发生OOM了。

想请问一下是否anon-rss + file-rss 就等于新申请的内存+
memory.usage_in_bytes - reclaim memory

其实这里最大的一点就是内核的内存是否被计入到cgroup
memory中。缺省情况内核使用的内存会被计入到cgroup里，
不过对于大部分运行应用程序的容器里， anon-rss +
file-rss就是最主要的物理内存开销（这里不包含内核内存）

但是如果一个容器中的进程对应的内核内存使用量很大那么我觉得更加准确的就是看
"新申请的内存+ memory.usage_in_bytes - reclaim memory" 了

**内存相关基础知识**

据我了解，进程使用的虚拟内存的大小列为\" total-vm\"。
它的一部分实际上已映射到RAM本身(已分配和使用)。 这是\" RSS\"。

RSS的一部分分配在实内存块中(而不是映射到文件或设备中)。 这是匿名内存(\"
anon-rss\")，并且还有RSS内存块被映射到设备和文件(\" file-rss\")中。

因此，如果您在vim中打开一个巨大的文件，则文件rss会很高，另一方面，如果您malloc()大量内存并真正使用它，那么您的anon-rss也会很高。

另一方面，如果您分配了大量空间(使用malloc())，但从未使用过，则total-vm会更高，但不会使用实际内存(由于内存过量使用)，因此，
rss值会很低。

total-vm: total virtual memory. 进程使用的总的虚拟内存。

rss: resident set size.
驻留集大小。驻留集是指进程已装入内存的页面的集合。

anon-rss: anonymous rss. 匿名驻留集。比如malloc出来的就是匿名的。

file-rss: 映射到设备和文件上的内存页面。

shmem-rss: 共享内存

有两种方法可以用来释放共享内存：

第一种：如果总是通过Crtl+C来结束的话，可以做一个信号处理器，当接收到这个信号的时候，先释放共享内存，然后退出程序。

第二种：不管你以什么方式结束程序，如果共享内存还是得不到释放，那么可以通过linux命令ipcrm
shm shmid来释放，在使用该命令之前可以通过ipcs -m命令来查看共享内存。

**RSS**

应用程序在申请内存的时候，比如说，调用 malloc() 来申请 100MB
的内存大小，malloc() 返回成功了，这时候系统其实只是把 100MB
的虚拟地址空间分配给了进程，但是并没有把实际的物理内存页面分配给进程。上一讲中，我给你讲过，当进程对这块内存地址开始做真正读写操作的时候，系统才会把实际需要的物理内存分配给进程。而这个过程中，进程真正得到的物理内存，就是这个
RSS 了。

对于进程来说，RSS
内存包含了进程的代码段内存，栈内存，堆内存，共享库的内存,
这些内存是进程运行所必须的。刚才我们通过 malloc/memset
得到的内存，就是属于堆内存。

具体的每一部分的 RSS 内存的大小，你可以查看 /proc/\[pid\]/smaps

**page cache**

如果进程对磁盘上的文件做了读写操作，Linux
还会分配内存，把磁盘上读写到的页面存放在内存中，这部分的内存就是 Page
Cache。

Page Cache 的主要作用是提高磁盘文件的读写性能，因为系统调用 read() 和
write() 的缺省行为都会把读过或者写过的页面存放在 Page Cache 里。

Page Cache
是一种为了提高磁盘文件读写性能而利用空闲物理内存的机制。同时，内存管理中的页面回收机制，又能保证
Cache 所占用的页面可以及时释放，这样一来就不会影响程序对内存的真正需求了

**RSS page cache memory cgroup**

Memory Cgroup 控制组里 RSS 内存和 Page Cache 内存的和，正好是
memory.usage_in_bytes 的值。

当控制组里的进程需要申请新的物理内存，而且 memory.usage_in_bytes
里的值超过控制组里的内存上限值 memory.limit_in_bytes，这时我们前面说的
Linux 的内存回收（page frame reclaim）就会被调用起来。

所以，判断容器真实的内存使用量，我们不能用 Memory Cgroup 里的
memory.usage_in_bytes，而需要用 memory.stat 里的 rss 值。这个很像我们用
free 命令查看节点的可用内存，不能看\"free\"字段下的值，而要看除去 Page
Cache 之后的\"available\"字段下的值。

进容器看内存值变化：

+-----------------------------------------------------------------------+
| PowerShell                                                            |
|                                                                       |
| cd /sys/fs/cgroup/memory/                                             |
|                                                                       |
| cat memory.usage_in_bytes                                             |
|                                                                       |
| cat memory.limit_in_bytes                                             |
|                                                                       |
| cat memory.stat                                                       |
|                                                                       |
| cat memory.usage_in_bytes                                             |
|                                                                       |
| cat memory.limit_in_bytes                                             |
|                                                                       |
| cat memory.stat                                                       |
+-----------------------------------------------------------------------+

Momory Cgroup
应该包括了对内核内存的限制，老师给出的例子情况比较简单，基本没有使用
slab，可以试下在容器中打开海量小文件，内核内存 inode、dentry
等会被计算在内。

内存使用量计算公式（memory.kmem.usage_in_bytes 表示该 memcg
内核内存使用量）：

memory.usage_in_bytes = memory.stat\[rss\] + memory.stat\[cache\] +
memory.kmem.usage_in_bytes

另外，Memory Cgroup OOM 不是真正依据内存使用量
memory.usage_in_bytes，而是依据 working set（使用量减去非活跃
file-backed 内存），working set 计算公式：

working_set = memory.usage_in_bytes - total_inactive_file

即使page
cache对应的文件被多个进程打开，在需要memory的时候还是可以释放page
cache的。进程打开的只是文件，page cache只是cache。

**swap**

创建swap空间并使用

![Generated](media/image12.png){width="5.90625in"
height="1.8020833333333333in"}

swappiness 可以决定系统将会有多频繁地使用交换分区。

一个较高的值会使得内核更频繁地使用交换分区，而一个较低的取值，则代表着内核会尽量避免使用交换分区。swappiness
的取值范围是 0--100，缺省值 60。

我们一起来分析分析，都可能发生怎样的情况。最可能发生的是下面两种情况：第一种情况是，如果系统先把
Page Cache
都释放了，那么一旦节点里有频繁的文件读写操作，系统的性能就会下降。还有另一种情况，如果
Linux 系统先把匿名内存都释放并写入到
Swap，那么一旦这些被释放的匿名内存马上需要使用，又需要从 Swap
空间读回到内存中，这样又会让
Swap（其实也是磁盘）的读写频繁，导致系统性能下降。

第一种情况，当 swappiness 的值是 100 的时候，匿名内存和 Page Cache
内存的释放比例就是 100: 100，也就是等比例释放了。第二种情况，就是
swappiness 缺省值是 60 的时候，匿名内存和 Page Cache 内存的释放比例就是
60 : 140，Page Cache 内存的释放要优先于匿名内存。

我们再进一步分析，如果一个容器中的程序发生了内存泄漏（Memory
leak），那么本来 Memory Cgroup
可以及时杀死这个进程，让它不影响整个节点中的其他应用程序。结果现在这个内存泄漏的进程没被杀死，还会不断地读写
Swap 磁盘，反而影响了整个节点的性能。

当空闲内存少于内存一个 zone 的\"high water mark\"中的值的时候，Linux
还是会做内存交换，也就是把匿名内存写入到 Swap 空间后释放内存。在这里
zone 是 Linux 划分物理内存的一个区域，里面有 3 个水位线（water
mark），水位线可以用来警示空闲内存的紧张程度

cat /proc/zoneinfo free \< high

Memory Cgroup 控制组下面的参数，你会看到有一个 memory.swappiness
参数。这个参数可以覆盖全局的参数

![Generated](media/image13.png){width="5.90625in" height="3.3125in"}

**Mysql学习**

行锁分析

show status like \'innodb_row_lock%\';

**锁的分类**

![Generated](media/image14.png){width="5.90625in" height="3.65625in"}

**Shared and Exclusive Locks 共享锁和排他锁**

MySQL实现了标准的行级共享锁和排他锁，简称为S锁和X锁。与标准的锁定义一致。

共享锁(S)：允许持有锁的事务读取行

排他锁(X)：允许持有锁的事务更新/删除行

  ----------------------- ----------------------- -----------------------
  T1持有                  T2申请S                 T2申请X

  S                       可以                    等待

  X                       等待                    等待
  ----------------------- ----------------------- -----------------------

**Intention Locks 意向锁**

除行锁和表级锁外，MySQL为了支持更多粒度的锁，引入意向锁。意向锁表级的，表达下一个事务想要的锁类型(s
/ x)，有两种类型的意向锁：

Intention Shared Lock (IS)，表示事务想要获取一个s锁

Intention Exclusive Lock (IX)，表示事务想要获取一个x锁

意向锁的原则是：

事务想要获取一行的S锁，则必须先申请表级的IS锁或者更强的锁。（更强本人猜测指的应该是IX）

事务想要获取一行的X锁，则必须先申请表级的IX锁。

  -------------- -------------- -------------- -------------- --------------
                 X              IX             S              IS

  X              Confict        Confict        Confict        Confict

  IX             Confict        Compatible     Confict        Compatible

  S              Confict        Confict        Compatible     Compatible

  IS             Confict        Compatible     Compatible     Compatible
  -------------- -------------- -------------- -------------- --------------

**Record Locks 记录锁**

A record lock is a lock on an index record. For example, SELECT c1 FROM
t WHERE c1 = 10 FOR UPDATE; prevents any other transaction from
inserting, updating, or deleting rows where the value of t.c1 is 10.

记录锁是加载在索引上的。如官方文档原文所述，持有记录锁之后，其他事务无法插入/更新/删除该索引对应的行。

如果表结构中没有声明索引，MySQL会自动创建一个隐藏的索引。

可以用 SHOW ENGINE INNODB STATUS
(https://dev.mysql.com/doc/refman/5.7/en/show-engine.html) 查看锁。

+-----------------------------------------------------------------------+
| SQL                                                                   |
|                                                                       |
| RECORD LOCKS space id 58 page no 3 n bits 72 index \`PRIMARY\` of     |
| table \`test\`.\`t\`                                                  |
|                                                                       |
| trx id 10078 lock_mode X locks rec but not gap                        |
|                                                                       |
| Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format;   |
| info bits 0                                                           |
|                                                                       |
| 0: len 4; hex 8000000a; asc ;;                                        |
|                                                                       |
| 1: len 6; hex 00000000274f; asc \'O;;                                 |
|                                                                       |
| 2: len 7; hex b60000019d0110; asc ;;                                  |
+-----------------------------------------------------------------------+

**Gap Locks 间隙锁**

间隙锁的目的主要是为了防止幻读，间隙锁加在索引之间的空隙上，或者第一个索引之前，或者最后一个索引之后。

比如：select c1 from t where c1 between 10 and 20 for update.
会阻止其他事物插入 c1 = 15，无论之前DB里有没有15这条记录。

间隙锁需要在性能和一致性上去做取舍，并非所有的事务隔离级别都有间隙锁，需要可重复读或更高的级别。

如果SQL使用uniq-index，则一定不会加间隙锁，会加index record lock。

+-----------------------------------------------------------------------+
| SQL                                                                   |
|                                                                       |
| SELECT \* FROM child WHERE id = 100;                                  |
+-----------------------------------------------------------------------+

If id is not indexed or has a nonunique index, the statement does lock
the **preceding gap**.

这里官方文档有一个表述不是很清晰的地方，文档说如果id没有索引，则会锁住**前间隙**。官方文档对于前间隙没有做过多的解释，毕竟没有索引，如何定义"前"呢。

间隙锁还有一些其他的匪夷所思的操作比如允许冲突的锁共存。比如：一个事务获取间隙S锁，另一个事务获取相同间隙的X锁。

间隙锁的作用就是防止其他事物插入数据，间隙锁可以共存，允许在相同的间隙上加多个锁。类似于S锁。

**Next-Key Locks**

Next-Key
Locks是行锁和间隙锁的结合体，锁住当前index本身以及它之前的间隙。如果一个事务持有了R的共享锁或者排他锁，那么，其他事务无法在R之前的间隙插入记录。

默认情况下MySQL的事务隔离级别为"可重复读"，这种情况下，InnoDB会在查询和索引Scan时使用Next-Key
Lock，来防止幻读。

+-----------------------------------------------------------------------+
| YAML                                                                  |
|                                                                       |
| RECORD LOCKS space id 58 page no 3 n bits 72 index \`PRIMARY\` of     |
| table \`test\`.\`t\`                                                  |
|                                                                       |
| trx id 10080 lock_mode X                                              |
|                                                                       |
| Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format;   |
| info bits 0                                                           |
|                                                                       |
| 0: len 8; hex 73757072656d756d; asc supremum;;                        |
|                                                                       |
| Record lock, heap no 2 PHYSICAL RECORD: n_fields 3; compact format;   |
| info bits 0                                                           |
|                                                                       |
| 0: len 4; hex 8000000a; asc ;;                                        |
|                                                                       |
| 1: len 6; hex 00000000274f; asc \'O;;                                 |
|                                                                       |
| 2: len 7; hex b60000019d0110; asc ;;                                  |
+-----------------------------------------------------------------------+

**Insert Intention Locks 插入意向锁**

插入意向锁是间隙锁的一种，插入意向锁表示多个事务想要向同一个间隙插入数据，但插入的并不是同一个索引值，那么他们可以并行执行。

插入意向锁官方文档没有给出样例，通过锁间隙后，插入数据模拟出的锁等待信息：

+-----------------------------------------------------------------------+
| YAML                                                                  |
|                                                                       |
| RECORD LOCKS space id 33 page no 3 n bits 80 index PRIMARY of table   |
| \`test\`.\`tmp\` trx id 2270 lock_mode X locks gap before rec insert  |
| intention waiting                                                     |
|                                                                       |
| Record lock, heap no 5 PHYSICAL RECORD: n_fields 5; compact format;   |
| info bits 0                                                           |
|                                                                       |
| 0: len 4; hex 80000008; asc ;;                                        |
|                                                                       |
| 1: len 6; hex 000000000856; asc V;;                                   |
|                                                                       |
| 2: len 7; hex eb0000016d0128; asc m (;;                               |
|                                                                       |
| 3: len 4; hex 80000008; asc ;;                                        |
|                                                                       |
| 4: len 4; hex 80000008; asc ;;                                        |
+-----------------------------------------------------------------------+

**AUTO-INC Locks 自增锁**

自增锁是一个特殊的表级锁，如果一个表有自增索引，那么一个插入正在进行中时，另一个插入必须等插入完成之后才能执行，来确保ID的顺序性。

[[innodb_autoinc_lock_mode]{.underline}](https://dev.mysql.com/doc/refman/5.7/en/innodb-auto-increment-handling.html#innodb-auto-increment-lock-modes)可以修改控制自增锁算法，用于在性能和序列顺序性的保证中间做权衡。有三个值可以配置0，1，2，分别代表：传统模式、连续模式、交错模式

0是在MySQL
5.1.22版本之前使用的锁，是一个表锁，显然在高并发的情况下会成为瓶颈。

1也是目前MySQL默认值，自增值通过互斥量（mutext）对内存中的计数器进行累加操作，在bulk
inserts(插入前不知道有多少行要被插入)时，降级到表锁。

2会更激进一些，所有插入都会使用互斥量，如果这种情况下使用了基于语句的主从复制(Statement-base
Replication)，会造成主从数据不一致。基于行的复制(Row-base
Replication)不会有问题。

**Predicate Locks for Spatial Indexes 空间索引的谓词锁**

这个锁我们一般用不上，不做详述，有兴趣可以参考官方文档。

**SQL语句与锁**

可能会锁行，也可能会锁Gap/Next-Key，取决于事务隔离级别以及后续的where条件能否命中唯一索引

**select \... from\...**

默认不加锁，除非事务隔离级别是串行化。如果当前读取的数据被锁定，则会读取上一个版本的数据(由MySQL的MVCC多版本并发控制实现)，Read
Commited和Repeatable
Read对于\"上一个版本\"的定义不同，前者就是字面意义的上一个版本，后者用的是事务开始时的那个版本。

**select \... for update**

X锁

**select \... lock in share mode**

S锁

**delete**

X锁

**update**

X锁，如果update语句更新了聚簇索引，该语句还会隐式的添加辅助索引的S锁。

When[[UPDATE]{.underline}](https://dev.mysql.com/doc/refman/5.7/en/update.html)modifies
a clustered index record, implicit locks are taken on affected secondary
index records.
The[[UPDATE]{.underline}](https://dev.mysql.com/doc/refman/5.7/en/update.html)operation
also takes shared locks on affected secondary index records when
performing duplicate check scans prior to inserting new secondary index
records, and when inserting new secondary index records.

**insert**

X锁，同时在insert之前，(Reaptable
Read级别下)还会加一个插入意向间隙锁，允许多个事务插入同一个间隙，如果多个事务插入的是同一行。如果发现duplicate-key
error，事务会加一个S锁在记录上，这个S锁可能会引发死锁。

**replace into**

和insert 相似。

**insert into a select \... from b where\...**

在a表中的插入行上加X锁，在Read Commit级别下，不对S表加锁，在Repeatable
Read下，会对b的记录加S级别的Next-key Lock

**Lock table \... read/write**

锁表，S / X

更多细节参考：

<https://dev.mysql.com/doc/refman/5.7/en/innodb-locks-set.html>

**锁的成本：**

Innodb的行锁不是根据每行来生成的，而是在页上维护的一个位图(BitMap)，因此，一个事务锁住同一页中的多条数据，那开销和锁一条是一致的。这样的设计可以节约非常多的成本，当一个事务要锁定一个大表中的所有行，也不至于消耗太多的内存。

假如：一个表3 000 000个数据页，每个数据页100条数据，总共就是300 000
000（3亿）条数据，锁住全部数据，需要3 000
000个锁，每个锁假设30个字节，总共约需90M的内存。

**死锁**

死锁出现在多个事务都持有一个其他事务需要的锁，都在等对方释放，永远无法执行。最典型的场景就是两个事务先后锁多行，但是加锁顺序不同。

**MySQL如何判断死锁：**

MySQL通过深度优先遍历判断事务间的等待关系是否有环路来判断是否发生死锁。另外为确保性能，如果深度超过了LOCK_MAX_DEPTH_IN_DEADLOCK_CHECK(200)，也会认为是死锁。

可以参考这篇MySQL源码分析的文章。

<https://leviathan.vip/2020/02/02/mysql-deadlock-check/>

InnoDB发现死锁后，会回滚相对较小的那个事务，事务大小通过undo
log的多少来判断。

**减少死锁：**

[[Section 14.7.5.3, "How to Minimize and Handle
Deadlocks"]{.underline}](https://dev.mysql.com/doc/refman/5.7/en/innodb-deadlocks-handling.html)

尽可能避免使用表锁。

事务保持轻量，在一个事务内操作的数据应当尽可能的少，保证事务能很快的结束。

事务操作多个表或多行数据时，使用相同的加锁顺序。

Update / Select for update 语句一定要命中索引。

**网络学习**

ip地址和mac地址的不同作用： 1. ip地址提供定位功能 2.
mac地址提供区分全局唯一的功能以及子网内定位功能

使用 net-tools：\$ sudo ifconfig eth1 10.0.0.1/24\$ sudo ifconfig eth1
up

使用 iproute2：\$ sudo ip addr add 10.0.0.1/24 dev eth1\$ sudo ip link
set up eth1

ICMP 报文有很多的类型，不同的类型有不同的代码。最常用的类型是主动请求为
8，主动请求的应答为 0。

常用的 ping 就是查询报文，是一种主动请求，并且获得主动应答的 ICMP
协议。所以，ping 发的包也是符合 ICMP
协议格式的，只不过它在后面增加了自己的格式。

ping 命令执行的时候，源主机首先会构建一个 ICMP 请求数据包，ICMP
数据包内包含多个字段。最重要的是两个，第一个是类型字段，对于请求数据包而言该字段为
8；另外一个是顺序号，主要用于区分连续 ping
的时候发出的多个数据包。每发出一个请求数据包，顺序号会自动加
1。为了能够计算往返时间 RTT，它会在报文的数据部分插入发送时间。

如果跨网段的话，还会涉及网关的转发、路由器的转发等等。但是对于 ICMP
的头来讲，是没什么影响的。会影响的是根据目标 IP
地址，选择路由的下一跳，还有每经过一个路由器到达一个新的局域网，需要换
MAC 头里面的 MAC 地址。

应该要清楚地知道一个网络包从源地址到目标地址都需要经过哪些设备，然后逐个
ping 中间的这些设备或者机器。如果可能的话，在这些关键点，通过 tcpdump -i
eth0
icmp，查看包有没有到达某个点，回复的包到达了哪个点，可以更加容易推断出错的位置。

Traceroute 的第一个作用就是故意设置特殊的
TTL，来追踪去往目的地时沿途经过的路由器

怎么知道 UDP 有没有到达目的主机呢？Traceroute 程序会发送一份 UDP
数据报给目的主机，但它会选择一个不可能的值作为 UDP 端口号（大于
30000）。当该数据报到达时，将使目的主机的 UDP
模块产生一份"端口不可达"错误 ICMP
报文。如果数据报没有到达，则可能是超时。

Traceroute 还有一个作用是故意设置不分片，从而确定路径的
MTU。要做的工作首先是发送分组，并设置"不分片"标志。发送的第一个分组的长度正好与出口
MTU 相等。如果中间遇到窄的关口会被卡住，会发送 ICMP
网络差错包，类型为"需要进行分片但设置了不分片位"。其实，这是人家故意的好吧，每次收到
ICMP"不能分片"差错时就减小分组的长度，直到到达目标主机。

设置不分片是为了探寻路径的MTU（初始故意设置为和本机出口一样大，以探寻往后路径上流量大小）。而设置TTL是为了探寻路径的长度/拓扑结构。

许多人问：tracerouter发udp，为啥出错回icmp？

正常情况下，协议栈能正常走到udp，当然正常返回udp。

但是，你主机不可达，是ip层的（还没到udp）。ip层，当然只知道回icmp。报文分片错误也是同理。

**网络编程学习**

一个连接可以通过客户端 - 服务器端的 IP
和端口唯一确定，这叫做套接字对，按照下面的四元组表示：（clientaddr:clientport,
serveraddr: serverport)

TCP，又被叫做字节流套接字（Stream Socket），注意我们这里先引入套接字
socket，套接字 socket
在后面几讲中将被反复提起，因为它实际上是网络编程的核心概念。当然，UDP
也有一个类似的叫法, 数据报套接字（Datagram
Socket），一般分别以"SOCK_STREAM"与"SOCK_DGRAM"分别来表示 TCP 和 UDP
套接字。

连接管理 拥塞控制 数据流 窗口控制 超时 重传 都是 TCP
面向完全可靠连接因素。

UDP
也可以做到更高的可靠性，只不过这种可靠性，需要应用程序进行设计处理，比如对报文进行编号，设计
Request-Ack 机制，再加上重传等，在一定程度上可以达到更为高可靠的 UDP
程序。当然，这种可靠性和 TCP 相比还是有一定的距离，不过也可以弥补实战中
UDP 的一些不足。

具体来说，客户端进程向操作系统内核发起 write
字节流写操作，内核协议栈将字节流通过网络设备传输到服务器端，服务器端从内核得到信息，将字节流从内核读入到进程中，并开始业务逻辑的处理，完成之后，服务器端再将得到的结果以同样的方式写给客户端。可以看到，一旦连接建立，数据的传输就不再是单向的，而是双向的，这也是
TCP 的一个显著特性。

![Generated](https://www.google.com.hk/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F9%2F95%2FWoman_with_Minolta_Hi-Matic_F.jpg%2F220px-Woman_with_Minolta_Hi-Matic_F.jpg&imgrefurl=https%3A%2F%2Fzh.wikipedia.org%2Fzh-my%2F%25E6%2591%2584%25E5%25BD%25B1&tbnid=Bn14kVPnn9Cz2M&vet=12ahUKEwic4sCd1870AhXVAbcAHUBmB3EQMygEegUIARDQAQ..i&docid=ScO6lNZubnlKQM&w=220&h=330&q=%E6%91%84%E5%BD%B1&ved=2ahUKEwic4sCd1870AhXVAbcAHUBmB3EQMygEegUIARDQAQ){width="5.90625in"
height="3.9895833333333335in"}
