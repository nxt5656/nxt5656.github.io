# Linux-存储性能测试-fio

## 安装fio
```shell
apt update && apt install -y fio
```

## 参数说明
[fio参数](https://help.aliyun.com/zh/ecs/user-guide/test-the-performance-of-block-storage-devices)

## 使用demo
```shell
fio-3.16

顺序读：
fio -filename=./test.file -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=16k -size=2G -numjobs=10 -runtime=60 -group_reporting -name=test_r
随机读：
fio -filename=./test.file -direct=1 -iodepth 1 -thread -rw=randread -ioengine=psync -bs=16k -size=20G -numjobs=10 -runtime=600 -group_reporting -name=test_randr
随机写：
fio -filename=./test.file -direct=1 -iodepth 1 -thread -rw=randwrite -ioengine=psync -bs=16k -size=2G -numjobs=10 -runtime=60 -group_reporting -name=test_randw
顺序写：
fio -filename=./test.file -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=16k -size=2G -numjobs=10 -runtime=60 -group_reporting -name=test_w
混合随机读写：
fio -filename=./test.file -direct=1 -iodepth 1 -thread -rw=randrw -rwmixread=70 -ioengine=psync -bs=16k -size=2G -numjobs=10 -runtime=60 -group_reporting -name=test_r_w -ioscheduler=noop


100%随机，100%读， 4K
fio -filename=./test.file -direct=1 -iodepth 1 -thread -rw=randread -ioengine=psync -bs=4k -size=20G -numjobs=50 -runtime=180 -group_reporting -name=rand_100read_4k

100%随机，100%写， 4K
fio -filename=./test.file -direct=1 -iodepth 1 -thread -rw=randwrite -ioengine=psync -bs=4k -size=20G -numjobs=50 -runtime=180 -group_reporting -name=rand_100write_4k

100%顺序，100%读 ，4K
fio -filename=/test.file -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=4k -size=20G -numjobs=50 -runtime=180 -group_reporting -name=sqe_100read_4k

100%顺序，100%写 ，4K
fio -filename=/data-g/test.file -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=4k -size=20G -numjobs=50 -runtime=180 -group_reporting -name=sqe_100write_4k

100%随机，70%读，30%写 4K
fio -filename=./test.file -direct=1 -iodepth 1 -thread -rw=randrw -rwmixread=70 -ioengine=psync -bs=4k -size=10G -numjobs=50 -runtime=180 -group_reporting -name=randrw_70read_4k
```