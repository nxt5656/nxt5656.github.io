# MySQL-常用操作

## 查看mysql数据库中每个表的大小
1. 查看单个数据库中所有的表大小
```mysql
SELECT
    TABLE_NAME AS `表名`,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS `大小(MB)`,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS `数据(MB)`,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS `索引(MB)`,
    TABLE_ROWS AS `行数`,
    CREATE_TIME AS `创建时间`,
    UPDATE_TIME AS `更新时间`
FROM
    information_schema.TABLES
WHERE
    TABLE_SCHEMA = 'your_database_name'  -- 替换为你的数据库名
ORDER BY
    (DATA_LENGTH + INDEX_LENGTH) DESC;
```
2. 查看所有数据库中所有表的大小
```mysql
SELECT
    TABLE_SCHEMA AS `数据库`,
    TABLE_NAME AS `表名`,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS `大小(MB)`
FROM
    information_schema.TABLES
ORDER BY
    (DATA_LENGTH + INDEX_LENGTH) DESC;
```

3. 计算单个表的大小
```mysql
SELECT
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS `大小(MB)`
FROM
    information_schema.TABLES
WHERE
    TABLE_SCHEMA = 'your_database_name'  -- 替换为数据库名
    AND TABLE_NAME = 'your_table_name';  -- 替换为表名
```
#### 关键字段解释:
1. DATA_LENGTH：表数据占用的字节数。
1. INDEX_LENGTH：索引占用的字节数。
1. TABLE_ROWS：表中的估计行数（对于 InnoDB 引擎，此值为近似值）。
1. CREATE_TIME 和 UPDATE_TIME：表的创建和最后更新时间。

#### 注意事项
1. 需要有 information_schema 表的查询权限（通常普通用户即可）。
1. 结果可能存在微小误差，尤其是对 InnoDB 表（行数为估算值）。
1. 对于大数据库，查询可能需要一些时间，可通过 LIMIT 限制结果数量。

如果需要更直观的可视化，可以将查询结果导出到 Excel 或使用数据库管理工具（如 Navicat、phpMyAdmin）查看。