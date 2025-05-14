# Linux-常用存储相关命令工具-du/ncdu

<div id="tocw"></div>

## 1 du
du (Disk Usage)
对指定的文件集合进行设备空间使用汇总，对目录递归处理。

示例:
```
du -h  
```
使用方法:
```shell
du [选项]... [文件]...  
或：  
du [选项]... --files0-from=F  
```
参数说明:
长选项的强制参数对短选项同样适用。
常用选项：
```
-0, --null：用空字符（NUL）而不是换行符结束每行输出。
-a, --all：对所有文件（而不仅仅是目录）输出计数。
--apparent-size：显示表面大小而不是设备使用量；虽然表面大小通常较小，但由于文件中的空洞（稀疏文件）、内部碎片、间接块等原因，可能会更大。
-B, --block-size=SIZE：在输出前按指定的单位 SIZE 缩放大小，例如 -BM 将以 1,048,576 字节为单位输出大小；详见下方的 SIZE 格式说明。
-b, --bytes：等同于 --apparent-size --block-size=1。
-c, --total：输出总计。
-D, --dereference-args：仅对命令行中列出的符号链接进行解引用。
-d, --max-depth=N：仅当目录或文件（使用 --all）距离命令行参数 N 层或更少时输出总计；--max-depth=0 等同于 --summarize。
--files0-from=F：对文件 F 中列出的以空字符分隔的文件名汇总设备使用情况；如果 F 是 -，则从标准输入读取文件名。
-H：等同于 --dereference-args（-D）。
-h, --human-readable：以人类可读的格式输出大小（例如 1K、234M、2G）。
--inodes：列出 inode 使用信息，而不是块使用信息。
-k：等同于 --block-size=1K。
-L, --dereference：对所有符号链接进行解引用。
-l, --count-links：对硬链接文件重复计数。
-m：等同于 --block-size=1M。
-P, --no-dereference：不跟随任何符号链接（默认行为）。
-S, --separate-dirs：对目录不包括子目录的大小。
--si：类似 -h，但使用 1000 的幂而不是 1024。
-s, --summarize：仅对每个参数显示总计。
-t, --threshold=SIZE：排除大小小于 SIZE 的条目（如果为正数），或排除大小大于 SIZE 的条目（如果为负数）。
--time：显示目录或其子目录中任意文件的最后修改时间。
--time=WORD：显示时间为 WORD 指定的类型，而不是默认的修改时间；可选值包括 atime（访问时间）、access、use、ctime（状态更改时间）或 status。
--time-style=STYLE：按 STYLE 显示时间，可选值包括 full-iso、long-iso、iso 或 +FORMAT；FORMAT 的解析方式与 date 命令类似。
-X, --exclude-from=FILE：排除匹配 FILE 中任意模式的文件。
--exclude=PATTERN：排除匹配 PATTERN 的文件。
-x, --one-file-system：跳过位于不同文件系统上的目录。
--help：显示此帮助信息并退出。
--version：输出版本信息并退出。
```
#### 显示单位说明：
显示值的单位取决于以下来源的第一个可用单位：

1. --block-size 参数。
2. 环境变量 DU_BLOCK_SIZE、BLOCK_SIZE 和 BLOCKSIZE。

如果未设置上述参数或变量，单位默认使用 1024 字节（如果设置了 POSIXLY_CORRECT，则为 512 字节）。
#### SIZE 参数格式：
SIZE 参数是一个整数，可以带有可选单位（例如：10K 表示 10*1024）。
支持的单位包括：K, M, G, T, P, E, Z, Y, R, Q（1024 的幂）或 KB, MB, ...（1000 的幂）。
也支持二进制前缀：KiB=K, MiB=M 等。


## 2 ncdu
### 2.1 安装
```shell
apt install -y ncdu
# 或
wget "https://dev.yorhel.nl/download/ncdu-2.8.1-linux-x86_64.tar.gz"
tar -zxvf ncdu-2.8.1-linux-x86_64.tar.gz
cp ncdu /usr/bin/
```
### 2.2 使用说明
```shell
ncdu <选项> <目录>

模式选择:
-h, --help             显示此帮助信息
-v, -V, --version        打印版本号
-f 文件                  从文件中导入扫描的目录结构
-o 文件                  将扫描的目录结构导出为 JSON 格式文件
-O 文件                  将扫描的目录结构导出为二进制格式文件
-e, --extended           启用扩展信息
--ignore-config        不加载配置文件

扫描选项:
-x, --one-file-system    只扫描当前文件系统
--exclude 模式           排除符合指定模式的文件
-X, --exclude-from 文件    排除符合文件中任意模式的文件
--exclude-caches         排除包含 CACHEDIR.TAG 文件的目录
-L, --follow-symlinks    跟随符号链接（排除目录符号链接）
--exclude-kernfs         排除 Linux 伪文件系统（procfs, sysfs, cgroup, ...）
-t 数量                  使用指定数量的线程进行扫描

导出选项:
-c, --compress           与 -o 一起使用时，使用 Zstandard 压缩
--compress-level 数量    设置压缩级别
--export-block-size KiB  与 -O 一起使用时，设置导出块大小（单位 KiB）

界面选项:
-0, -1, -2               扫描时使用的 UI 模式 (0=无界面, 2=完整 ncurses 界面)
-q, --slow-ui-updates    "安静"模式，刷新间隔 2 秒
--enable-shell           启用/禁用启动 shell 的功能
--enable-delete          启用/禁用文件删除功能
--enable-refresh         启用/禁用目录刷新功能
-r                       只读模式 (--disable-delete)
-rr                      只读模式++ (--disable-delete & --disable-shell)
--si                     使用十进制 (SI) 前缀（如 MB, GB）而不是二进制前缀（如 MiB, GiB）
--apparent-size          默认显示文件实际大小而不是占用的磁盘空间
--hide-hidden            默认隐藏“隐藏”文件或被排除的文件
--show-itemcount         默认显示项目计数列
--show-mtime             默认显示修改时间列（需要 -e 选项）
--show-graph             默认显示图表列
--show-percent           默认显示百分比列
--graph-style 样式       图表样式：hash / half-block / eighth-block
--shared-column          共享列显示：off / shared / unique
--sort 列-(asc/desc)     排序方式：disk-usage（磁盘使用量）/ name（名称）/ apparent-size（实际大小）/ itemcount（项目计数）/ mtime（修改时间），可指定 asc（升序）/ desc（降序）
--enable-natsort         按名称排序时使用自然排序（例如 1, 2, 10 而不是 1, 10, 2）
--group-directories-first 将目录排在文件前面
--confirm-quit           退出 ncdu 前询问确认
--no-confirm-delete      删除前不询问确认
--color 配色方案         配色方案：off（关闭）/ dark（深色）/ dark-bg（深色背景）

请参考 man ncdu 获取更多信息。
```