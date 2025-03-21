# ElasticSearch-FAQ-机器学习相关 
[官方文档](https://elastic.ac.cn/guide/en/elasticsearch/reference/current/ml-settings.html)

## 1. 低规格机器节点,如何加载模型?
设置值 'xpack.ml.max_machine_memory_percent'

机器学习可用于运行分析过程的机器内存的最大百分比。这些过程与 Elasticsearch JVM 分开。此限制基于机器的总内存，而不是当前可用内存。如果这样做会导致机器学习作业的估计内存使用量超过限制，则不会将作业分配给节点。启用操作员权限功能后，此设置只能由操作员用户更新。最小值是 5；最大值是 200。默认为 30。
```shell
PUT /_cluster/settings
{
    "transient" : {
        "xpack.ml.max_machine_memory_percent" : 50
    }
}
```