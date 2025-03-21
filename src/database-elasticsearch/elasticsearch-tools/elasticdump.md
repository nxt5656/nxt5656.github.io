# ElasticSearch-数据同步工具 elasticdump

[官方链接](https://github.com/elasticsearch-dump/elasticsearch-dump)
## 使用docker方式
```
# 将json文件导入本地es中(数据)
elasticdump --input=索引名称.data.json --output=http://localhost:9200/索引名称 --type=data  

# 导出mapping
docker run --rm -ti -v /root/tmp:/tmp elasticdump/elasticsearch-dump \
  --input=http://es账号:es密码@es服务器地址:9200/索引名称 \
  --output=/tmp/索引名称.mapping.json \
  --type=mapping 
  
# 导出索引数据并压缩
docker run --rm -ti -v /devops/es_test:/tmp elasticdump/elasticsearch-dump \
  --input=http://es账号:es密码@es服务器地址:9200/索引名称 \
  --type=data \
  --limit=10000 \
  --output=$ | gzip  > 索引名称.data.json.gz 

# 导出索引数据不压缩
docker run --rm -ti -v /root/tmp:/tmp elasticdump/elasticsearch-dump \
  --input=http://es账号:es密码@es服务器地址:9200/索引名称 \
  --type=data \
  --limit=10000 \
  --output=/tmp/索引名称.json
  
# 导出所有索引数据
docker run --rm -ti -v /data/backup:/tmp elasticdump/elasticsearch-dump \
  --input=http://es账号:es密码@es服务器地址:9200 \
  --type=data \
  --limit=10000 \
  --output=/tmp/备份文件.json


# 导入索引结构
docker run --rm -ti -v /root/tmp:/tmp elasticdump/elasticsearch-dump \
  --input=/tmp/索引名称.mapping.json  \
  --output=http://es账号:es密码@es服务器地址:9200/索引名称 \
  --type=mapping  \
  --noRefresh \
  --maxSockets=500

# 导出索引数据,每次操作10000条数据
docker run --rm -ti -v /devops/es_test:/tmp elasticdump/elasticsearch-dump \
  --input=http://es账号:es密码@es服务器地址:9200/索引名称 \
  --type=data \
  --limit=10000 \
  --output=/tmp/索引名称.json


docker run --rm -ti -v /data/es2:/tmp elasticdump/elasticsearch-dump \
  --input=http://es账号:es密码@es服务器地址:9200/abroad_plg_account_info_v1 \
  --output=/tmp/abroad_plg_account_info_v1.mapping.json \
  --type=data  --noRefresh  --maxSockets=500 --limit=10000

docker run --rm -ti -v /data/es2:/tmp elasticdump/elasticsearch-dump \
  --input=http://es账号:es密码@es服务器地址:9200/abroad_plg_account_info_v2 \
  --output=/tmp/abroad_plg_account_info_v2.mapping.json \
  --type=data  --noRefresh  --maxSockets=5000 --limit=10000


docker run --rm -ti -v /data/es2:/tmp elasticdump/elasticsearch-dump \
  --input=/tmp/abroad_plg_account_info_v2.mapping.json  \
  --output=http://es账号:es密码@es服务器地址:9200/abroad_plg_account_info_v2 \
  --type=data  \
  --noRefresh \
  --maxSockets=500 --limit=10000
  
docker run --rm -ti -v /data/es2:/tmp elasticdump/elasticsearch-dump \
  --input=/tmp/abroad_plg_account_info_v1.mapping.json  \
  --output=http://es账号:es密码@es服务器地址:9200/abroad_plg_account_info_v1 \
  --type=data  \
  --noRefresh \
  --maxSockets=500 --limit=10000
```

## 参数说明
```shell
elasticdump: Elasticsearch的导入和导出工具  
版本: %%version%%  
  
用法: elasticdump --input 源 --output 目标 [选项]  
  
核心选项  
--------------------  
--input  
                    源位置 (必须)  
  
--input-index  
                    源索引和类型  
                    (默认: 全部, 示例: index/type)  
  
--output  
                    目标位置 (必须)  
  
--output-index  
                    目标索引和类型  
                    (默认: 全部, 示例: index/type)  
  
  
选项  
--------------------  
--big-int-fields  
                    指定一个应检查大整数支持的字段的逗号分隔列表  
                    (默认 '')  
  
--bulkAction  
                    设置准备发送到elasticsearch的请求体时使用的操作类型。  
                    更多信息 - https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html  
                    (默认: index, 选项: [index, update, delete, create)  
  
--ca, --input-ca, --output-ca  
                    CA证书。如果源和目标相同，使用 --ca。  
                    否则，根据需要使用前缀为 --input 或 --output 的一个。  
  
--cert, --input-cert, --output-cert  
                    客户端证书文件。如果源和目标相同，使用 --cert。  
                    否则，根据需要使用前缀为 --input 或 --output 的一个。  
  
--csvConfigs  
                    设置所有fast-csv配置  
                    可以提供一个转义的JSON字符串或文件。文件位置必须用@符号作为前缀  
                    (默认: null)  
  
--csvCustomHeaders  一个用逗号分隔的值列表，将作为数据的头。此参数必须与`csvRenameHeaders`一起使用  
                    (默认 : null)  
  
--csvDelimiter  
                    将分隔列的分隔符。  
                    (默认 : ',')  
  
--csvFirstRowAsHeaders  
                    如果设置为true，第一行将被视为标题。  
                    (默认 : true)  
  
--csvHandleNestedData  
                    设置为true以处理嵌套的JSON/CSV数据。  
                    注意：这是一个非常主观的实现！  
                    (默认 : false)  
  
--csvIdColumn  
                    用于从中提取记录标识符(id)的列名  
                    在导出到CSV时，此列可以用来覆盖默认的id (@id)列名  
                    (默认 : null)  
  
--csvIgnoreAutoColumns  
                    设置为true以防止以下列 @id, @index, @type 被写入到输出文件  
                    (默认 : false)  
  
--csvIgnoreEmpty  
                    设置为true以忽略空行。  
                    (默认 : false)  
  
--csvIncludeEndRowDelimiter  
                    设置为true以在csv的末尾包含行分隔符  
                    (默认 : false)  
  
--csvIndexColumn  
                    用于从中提取记录索引的列名  
                    在导出到CSV时，此列可以用来覆盖默认的索引 (@index)列名  
                    (默认 : null)  
  
--csvLTrim  
                    设置为true以左修剪所有列。  
                    (默认 : false)  
  
--csvMaxRows  
                    如果数字> 0，则只解析指定数量的行。(例如，100将返回数据的前100行)  
                    (默认 : 0)  
  
--csvRTrim  
                    设置为true以右修剪所有列。  
                    (默认 : false)  
  
--csvRenameHeaders  
                    如果您希望文件的第一行被`csvCustomHeaders`选项中提供的内容删除并替换  
                    (默认 : true)  
  
--csvSkipLines  
                    如果数字> 0，将跳过指定数量的行。  
                    (默认 : 0)  
  
--csvSkipRows  
                    如果数字> 0，则跳过指定数量的已解析行  
                    注意：（如果第一行被视为标题，它们不是计数的一部分）  
                    (默认 : 0)  
  
--csvTrim  
                    设置为true以从列中去除所有空格。  
                    (默认 : false)  
  
--csvTypeColumn  
                    用于从中提取记录类型的列名  
                    在导出到CSV时，此列可以用来覆盖默认类型 (@type)列名  
                    (默认 : null)  
  
--csvWriteHeaders   决定是否应将标题写入csv文件。  
                    (默认 : true)  
  
--customBackoff  
                    激活自定义customBackoff函数。 (s3)  
  
--debug  
                    显示正在使用的elasticsearch命令  
                    (默认: false)  
  
--delete  
                    在移动时逐个删除输入中的文档。不会删除源索引  
                    (默认: false)  
  
--delete-with-routing  
                    将路由查询参数传递给删除功能  
                    用于将操作路由到特定的分片。  
                    (默认: false)  
  
--esCompress  
                    如果为true，添加一个Accept-Encoding头以从服务器请求压缩的内容编码（如果尚未存在）  
                    并在响应中解码支持的内容编码。  
                    注意：响应内容的自动解码是在通过请求返回的主体数据上执行的  
                    （无论是通过请求流还是传递给回调函数），但不在响应流上执行  
                    （可从响应事件获得），这是未经修改的http.IncomingMessage对象，可能包含压缩数据。  
                    见下面的例子。  
  
--fileSize  
                    支持文件分割。此值必须是**字节**模块支持的字符串。  
                    以下缩写必须用来表示单位大小  
                    b代表字节  
                    kb代表千字节  
                    mb代表兆字节  
                    gb代表吉字节  
                    tb代表太字节  
                    例如：10mb / 1gb / 1tb  
                    分区有助于通过有效地将文件切成更小的块来缓解溢出/内存不足的异常，  
                    然后可以根据需要合并这些块。  
  
--filterSystemTemplates  
                    是否删除metrics-*-* 和 logs-*-* 系统模板  
                    (默认: true])  
  
--force-os-version  
                    强制elasticsearch-dump使用的OpenSearch版本。  
                    (默认: 7.10.2)  
  
--fsCompress  
                    在发送输出到文件之前压缩数据。  
                    在导入时，该命令用于解压缩gzipped文件  
  
--handleVersion  
                    告诉elastisearch传输如果数据集中存在`_version`字段则处理它  
                    (默认 : false)  
  
--headers  
                    添加到Elastisearch请求的自定义头（当  
                    你的Elasticsearch实例位于代理后面时很有用）  
                    (默认: '{"User-Agent": "elasticdump"}')  
                    支持基于类型/方向的头，例如。input-headers/output-headers  
                    （这些将仅根据当前的流类型input/output添加）  
  
--help  
                    这个页面  
  
--ignore-errors  
                    在写入错误时将继续读/写循环  
                    (默认: false)  
  
--ignore-es-write-errors  
                    在elasticsearch写入错误时将继续读/写循环  
                    (默认: true)  
  
--inputSocksPort, --outputSocksPort  
                    Socks5主机端口  
  
--inputSocksProxy, --outputSocksProxy  
                    Socks5主机地址  
  
--inputTransport  
                    提供一个自定义的js文件作为输入传输  
  
--key, --input-key, --output-key  
                    私钥文件。如果源和目标相同，使用 --key。  
                    否则，根据需要使用前缀为 --input 或 --output 的一个。  
  
--limit  
                    每次操作移动多少个对象  
                    对于文件流，限制是大约的  
                    (默认: 100)  
  
--maxRows  
                    支持文件分割。文件是按指定的行数分割的  
  
--maxSockets  
                    进程可以同时进行多少个HTTP请求？  
                    (默认:  
                      5 [node <= v0.10.x] /  
                      无限制 [node >= v0.11.x] )  
  
--noRefresh  
                    禁用输入索引刷新。  
                    正面：  
                      1. 索引速度大大提高  
                      2. 对硬件的要求大大降低  
                    负面：  
                      1. 最近添加的数据可能没有被索引  
                    推荐在对大数据进行索引时使用，  
                    其中速度和系统健康是比最近添加的数据更高的优先级。  
  
--offset  
                    包含你希望从输入传输跳过的行数的整数。当导入大量  
                    索引时，事情可能会出错，无论是连通性，崩溃，  
                    有人忘记`screen`等。这允许你  
                    从最后一行已知的行重新开始转储  
                    （由输出中的`offset`记录）。请注意  
                    由于在最初创建转储时没有指定排序，因此没有真正的方式来  
                    保证已经跳过的行已经被  
                    写入/解析。这更多的是一个选项，当你  
                    想要在索引中获取尽可能多的数据时，而不关心在过程中可能丢失一些行，  
                    类似于`timeout`选项。  
                    (默认: 0)  
  
--outputTransport  
                    提供一个自定义的js文件作为输出传输  
  
--overwrite  
                    如果存在则覆盖输出文件  
                    (默认: false)  
  
--params  
                    添加自定义参数到Elastisearch请求uri。当你例如  
                    想要使用elasticsearch preference时很有用  
                    --input-params是一个特定的参数扩展，可以在使用滚动api获取数据时使用  
                    --output-params是一个特定的参数扩展，可以在使用批量索引api索引数据时使用  
                    注意：这些是为了避免参数污染问题，这些问题发生在输入参数在输出源中使用时  
                    (默认: null)  
  
--parseExtraFields  
                    要解析的元字段的逗号分隔列表  
  
--pass, --input-pass, --output-pass  
                    私钥的通行证。如果源和目标相同，使用 --pass。  
                    否则，根据需要使用前缀为 --input 或 --output 的一个。  
  
--quiet  
                    除错误外，禁止所有消息  
                    (默认: false)  
  
--retryAttempts  
                    指示当连接因以下错误失败时，请求应自动重试的次数`ECONNRESET`, `ENOTFOUND`, `ESOCKETTIMEDOUT`,  
                    ETIMEDOUT`, `ECONNREFUSED`, `EHOSTUNREACH`, `EPIPE`, `EAI_AGAIN`  
                    (默认: 0)  
  
--retryDelay  
                    指示重试尝试之间的回退/休息期（毫秒）  
                    (默认 : 5000)  
  
--retryDelayBase  
                    用于操作重试的指数回退的基本毫秒数。（s3）  
  
--scroll-with-post  
                    使用HTTP POST方法进行滚动，而不是默认的GET  
                    (默认: false)  
  
--scrollId  
                    从elasticsearch返回的最后一个滚动Id。  
                    这将允许使用最后的滚动Id恢复转储 &  
                    `scrollTime` 尚未过期。  
  
--scrollTime  
                    节点将按顺序保持请求的时间。  
                    (默认: 10m)  
  
--searchBody  
                    根据搜索结果执行部分提取  
                    当ES是输入时，默认值是  
                      如果 ES > 5  
                        `'{"query": { "match_all": {} }, "stored_fields": ["*"], "_source": true }'`  
                      否则  
                        `'{"query": { "match_all": {} }, "fields": ["*"], "_source": true }'`  
                    [从6.68.0开始] 如果searchBody前面有一个@符号，elasticdump将在指定的位置执行文件查找  
                    注意：文件必须包含有效的JSON  
  
--searchBodyTemplate  
                    可以调用的方法/函数来搜索主体  
                        doc.searchBody = { query: { match_all: {} }, stored_fields: [], _source: true };  
                    可以多次使用。  
                    此外，searchBodyTemplate可以由模块执行。参见下面的[searchBody模板](#search-template)。  
  
--searchWithTemplate  
                    使用 --searchBody 时启用搜索模板  
                    如果使用搜索模板，则searchBody必须包含"id"字段和"params"对象  
                    如果搜索模板中定义了"size"字段，它将被 --size 参数覆盖  
                    有关  
                    进一步的信息请参见 https://www.elastic.co/guide/en/elasticsearch/reference/current/search-template.html   
                    (默认: false)  
  
--size  
                    要检索多少对象  
                    (默认: -1 -> 无限制)  
  
--skip-existing  
                    当启用时，跳过resource_already_exists_exception并退出成功  
                    (默认: false)  
  
--sourceOnly  
                    只输出文档_source中包含的json  
                    正常: {"_index":"","_type":"","_id":"", "_source":{SOURCE}}  
                    sourceOnly: {SOURCE}  
                    (默认: false)  
  
--support-big-int  
                    支持大整数  
  
--templateRegex  
                    在传递给输出传输之前过滤模板的正则表达式  
                    (默认: ((metrics|logs|\..+)(-.+)?)  
  
--timeout  
                    包含等待  
                    请求响应的毫秒数，在请求超时前中止请求。直接传递  
                    到请求库。主要用于当你不太在乎导入时是否丢失一些数据  
                    但更希望有速度。  
  
--tlsAuth  
                    启用TLS X509客户端认证  
  
--toLog  
                    当使用自定义outputTransport时，应该将日志行  
                    附加到输出流？  
                    (默认: true, 除了 `$`)  
  
--transform  
                    可以调用的方法/函数，用于在写入目标之前修改文档。全局变量 'doc'  
                    是可用的。  
                    用于计算新字段 'f2' 作为字段 'f1' 的双倍值的示例脚本：  
                        doc._source["f2"] = doc._source.f1 * 2;  
                    可以多次使用。  
                    此外，transform可以由模块执行。参见下面的[模块转换](#module-transform)。  
  
--type  
                    我们要导出什么？  
                    (默认: data, 选项: [index, settings, analyzer, data, mapping, policy, alias, template, component_template, index_template])  
  
--versionType  
                    Elasticsearch版本类型。应为`internal`, `external`, `external_gte`, `force`。  
                    注意：类型验证由批量端点处理，而不是由elasticsearch-dump处理  
  
  
AWS特定选项  
--------------------  
--awsAccessKeyId 和 --awsSecretAccessKey  
                    当使用由  
                    AWS身份和访问管理 (IAM) 保护的Amazon Elasticsearch Service时，提供  
                    你的访问密钥ID和秘密访问密钥。  
                    --sessionToken也可以提供，如果使用临时凭证  
  
--awsChain  
                    使用[标准](https://aws.amazon.com/blogs/security/a-new-and-standardized-way-to-manage-credentials-in-the-aws-sdks/)  
                    位置和排序来解析凭证，包括环境变量，  
                    配置文件，EC2和ECS元数据位置 _推荐使用AWS的此选项_  
  
--awsIniFileName  
                    当使用 --awsIniFileProfile 时，覆盖默认的aws ini文件名  
                    文件名相对于 ~/.aws/  
                    (默认: config)  
  
--awsIniFileProfile  
                    替代 --awsAccessKeyId 和 --awsSecretAccessKey，  
                    从aws ini文件的指定配置文件中加载凭证。  
                    对于更大的灵活性，考虑使用 --awsChain  
                    并设置AWS_PROFILE和AWS_CONFIG_FILE  
                    环境变量以在需要时覆盖默认值  
  
--awsRegion  
                    设置将为其生成签名的AWS区域  
                    (默认: 从主机名或主机计算)  
  
--awsService  
                    设置将为其生成签名的AWS服务  
                    (默认: 从主机名或主机计算)  
  
--awsUrlRegex  
                    覆盖用于验证应签名的AWS url的默认正则表达式  
                    (默认: ^https?:\/\/.*\.amazonaws\.com.*$)  
  
--s3ACL  
                    S3 ACL: private | public-read | public-read-write | authenticated-read | aws-exec-read |  
                    bucket-owner-read | bucket-owner-full-control [默认 private]  
  
--s3AccessKeyId  
                    AWS访问密钥ID  
  
--s3Compress  
                    在发送到s3之前gzip数据  
  
--s3Configs  
                    设置所有s3构造函数配置  
                    可以提供一个转义的JSON字符串或文件。文件位置必须用@符号作为前缀  
                    (默认: null)  
  
--s3Endpoint  
                    AWS端点，可用于AWS兼容的后端，如  
                    OpenStack Swift 和 OpenStack Ceph  
  
--s3ForcePathStyle  
                    强制使用S3对象的路径样式URL [默认 false]  
  
--s3Options  
                    设置所有显示的s3参数在此 https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html#createMultipartUpload-property  
                    可以提供一个转义的JSON字符串或文件。文件位置必须用@符号作为前缀  
                    (默认: null)  
  
--s3Region  
                    AWS区域  
  
--s3SSEKMSKeyId  
                    用于aws:kms上传的KMS Id  
  
--s3SSLEnabled  
                    使用SSL连接到AWS [默认 true]  
  
--s3SecretAccessKey  
                    AWS秘密访问密钥  
  
--s3ServerSideEncryption  
                    启用加密上传  
  
--s3StorageClass  
                    设置用于s3的存储类  
                    (默认: STANDARD)
```