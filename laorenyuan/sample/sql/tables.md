# 数据库表结构设计文档

## 1. 捐献者信息表 (donor_info)

存储捐献者的基本信息和医疗历史记录。

| 字段名          | 数据类型     | 是否必填 | 默认值            | 说明             | 数据格式/示例       |
| --------------- | ------------ | -------- | ----------------- | ---------------- | ------------------- |
| donor_id        | VARCHAR(50)  | 是       | -                 | 捐献者唯一标识ID | 例如：D202401010001 |
| name            | VARCHAR(100) | 是       | -                 | 捐献者姓名       | 中文姓名，如：张三  |
| age             | INT          | 否       | -                 | 捐献者年龄       | 正整数，如：45      |
| gender          | VARCHAR(10)  | 否       | -                 | 性别             | 男/女               |
| medical_history | TEXT         | 否       | -                 | 医疗病史记录     | 文本描述            |
| create_time     | DATETIME     | 是       | CURRENT_TIMESTAMP | 创建时间         | YYYY-MM-DD HH:mm:ss |
| update_time     | DATETIME     | 是       | CURRENT_TIMESTAMP | 更新时间         | YYYY-MM-DD HH:mm:ss |

## 2. 知情同意书表 (consent_form)

存储捐献者知情同意书相关信息。

| 字段名              | 数据类型    | 是否必填 | 默认值            | 说明             | 数据格式/示例                              |
| ------------------- | ----------- | -------- | ----------------- | ---------------- | ------------------------------------------ |
| form_id             | VARCHAR(50) | 是       | -                 | 同意书唯一标识ID | 例如：F202401010001                        |
| sample_id           | VARCHAR(50) | 是       | -                 | 关联样本ID       | 关联sample_info表                          |
| form_file           | LONGBLOB    | 否       | -                 | 同意书文件内容   | 二进制文件数据                             |
| upload_date         | DATETIME    | 是       | -                 | 上传日期         | YYYY-MM-DD HH:mm:ss                        |
| description         | TEXT        | 否       | -                 | 描述信息         | 文本描述                                   |
| scan_status         | VARCHAR(20) | 否       | -                 | 扫描状态         | 待扫描/已扫描/扫描失败                     |
| verification_result | BOOLEAN     | 否       | -                 | 验证结果         | true/false                                 |
| form_type           | VARCHAR(50) | 否       | -                 | 同意书类型       | 如：标准同意书/特殊同意书                  |
| signature_info      | JSON        | 否       | -                 | 签名信息         | {"签名人":"张三", "签名时间":"2024-01-01"} |
| create_time         | DATETIME    | 是       | CURRENT_TIMESTAMP | 创建时间         | YYYY-MM-DD HH:mm:ss                        |
| update_time         | DATETIME    | 是       | CURRENT_TIMESTAMP | 更新时间         | YYYY-MM-DD HH:mm:ss                        |

## 3. 采集管分组表 (collection_group)

管理样本采集管的分组信息。

| 字段名           | 数据类型     | 是否必填 | 默认值            | 说明           | 数据格式/示例                    |
| ---------------- | ------------ | -------- | ----------------- | -------------- | -------------------------------- |
| group_id         | VARCHAR(50)  | 是       | -                 | 分组唯一标识ID | 例如：G202401010001              |
| group_name       | VARCHAR(100) | 是       | -                 | 分组名称       | 如：A组采集管                    |
| group_type       | VARCHAR(50)  | 是       | -                 | 分组类型       | 如：常规采集/特殊采集            |
| tube_list        | JSON         | 否       | -                 | 采集管列表     | [{"管号":"T001", "类型":"血液"}] |
| group_status     | VARCHAR(20)  | 是       | -                 | 分组状态       | 未使用/使用中/已完成             |
| last_update_time | DATETIME     | 是       | -                 | 最后更新时间   | YYYY-MM-DD HH:mm:ss              |
| create_time      | DATETIME     | 是       | CURRENT_TIMESTAMP | 创建时间       | YYYY-MM-DD HH:mm:ss              |
| update_time      | DATETIME     | 是       | CURRENT_TIMESTAMP | 更新时间       | YYYY-MM-DD HH:mm:ss              |

## 4. 采集流程表 (collection_process)

记录样本采集的流程信息。

| 字段名      | 数据类型    | 是否必填 | 默认值            | 说明           | 数据格式/示例             |
| ----------- | ----------- | -------- | ----------------- | -------------- | ------------------------- |
| process_id  | VARCHAR(50) | 是       | -                 | 流程唯一标识ID | 例如：P202401010001       |
| sample_id   | VARCHAR(50) | 是       | -                 | 关联样本ID     | 关联sample_info表         |
| status      | VARCHAR(20) | 是       | -                 | 流程状态       | 未开始/进行中/已完成/异常 |
| start_time  | DATETIME    | 是       | -                 | 开始时间       | YYYY-MM-DD HH:mm:ss       |
| end_time    | DATETIME    | 否       | -                 | 结束时间       | YYYY-MM-DD HH:mm:ss       |
| create_time | DATETIME    | 是       | CURRENT_TIMESTAMP | 创建时间       | YYYY-MM-DD HH:mm:ss       |
| update_time | DATETIME    | 是       | CURRENT_TIMESTAMP | 更新时间       | YYYY-MM-DD HH:mm:ss       |

## 5. 样本存储表 (sample_storage)

管理样本的存储位置和状态信息。

| 字段名            | 数据类型     | 是否必填 | 默认值            | 说明               | 数据格式/示例                          |
| ----------------- | ------------ | -------- | ----------------- | ------------------ | -------------------------------------- |
| storage_id        | VARCHAR(50)  | 是       | -                 | 存储记录唯一标识ID | 例如：S202401010001                    |
| sample_id         | VARCHAR(50)  | 是       | -                 | 关联样本ID         | 关联sample_info表                      |
| location          | VARCHAR(200) | 是       | -                 | 存储位置           | 如：A区-01架-02层-03号                 |
| status            | VARCHAR(20)  | 是       | -                 | 存储状态           | 在库/出库/销毁                         |
| operation_log     | JSON         | 否       | -                 | 操作日志           | [{"操作":"入库", "时间":"2024-01-01"}] |
| outbound_type     | VARCHAR(20)  | 否       | -                 | 出库类型           | 实验使用/销毁/转移                     |
| outbound_time     | DATETIME     | 否       | -                 | 出库时间           | YYYY-MM-DD HH:mm:ss                    |
| outbound_operator | VARCHAR(50)  | 否       | -                 | 出库操作人         | 操作人姓名                             |
| inbound_time      | DATETIME     | 否       | -                 | 入库时间           | YYYY-MM-DD HH:mm:ss                    |
| inbound_operator  | VARCHAR(50)  | 否       | -                 | 入库操作人         | 操作人姓名                             |
| storage_status    | VARCHAR(20)  | 是       | -                 | 存储状态           | 正常/异常/待检查                       |
| create_time       | DATETIME     | 是       | CURRENT_TIMESTAMP | 创建时间           | YYYY-MM-DD HH:mm:ss                    |
| update_time       | DATETIME     | 是       | CURRENT_TIMESTAMP | 更新时间           | YYYY-MM-DD HH:mm:ss                    |

## 6. 编码规则表 (code_rule)

定义样本编码的生成规则。

| 字段名                  | 数据类型     | 是否必填 | 默认值            | 说明           | 数据格式/示例                 |
| ----------------------- | ------------ | -------- | ----------------- | -------------- | ----------------------------- |
| rule_id                 | VARCHAR(50)  | 是       | -                 | 规则唯一标识ID | 例如：R202401010001           |
| prefix                  | VARCHAR(50)  | 是       | -                 | 编码前缀       | 如：SAM                       |
| format                  | VARCHAR(200) | 是       | -                 | 编码格式       | 如：{prefix}-{YYYYMMDD}-{seq} |
| auto_numbering_rule     | VARCHAR(200) | 否       | -                 | 自动编号规则   | 如：{seq:6:0}                 |
| desensitization_enabled | BOOLEAN      | 否       | false             | 是否启用脱敏   | true/false                    |
| rule_version            | VARCHAR(20)  | 否       | -                 | 规则版本       | 如：v1.0                      |
| effective_date          | DATETIME     | 否       | -                 | 生效日期       | YYYY-MM-DD HH:mm:ss           |
| create_time             | DATETIME     | 是       | CURRENT_TIMESTAMP | 创建时间       | YYYY-MM-DD HH:mm:ss           |
| update_time             | DATETIME     | 是       | CURRENT_TIMESTAMP | 更新时间       | YYYY-MM-DD HH:mm:ss           |

## 7. 数据脱敏规则表 (desensitization_rule)

定义数据脱敏的规则和模式。

| 字段名           | 数据类型     | 是否必填 | 默认值            | 说明               | 数据格式/示例          |
| ---------------- | ------------ | -------- | ----------------- | ------------------ | ---------------------- |
| rule_id          | VARCHAR(50)  | 是       | -                 | 脱敏规则唯一标识ID | 例如：DR202401010001   |
| code_rule_id     | VARCHAR(50)  | 是       | -                 | 关联编码规则ID     | 关联code_rule表        |
| field_name       | VARCHAR(100) | 是       | -                 | 字段名称           | 如：name, id_card      |
| masking_type     | VARCHAR(50)  | 是       | -                 | 脱敏类型           | 全遮盖/部分遮盖/替换   |
| masking_pattern  | VARCHAR(200) | 是       | -                 | 脱敏模式           | 如：{前3位}****{后4位} |
| test_data        | TEXT         | 否       | -                 | 测试数据           | 用于测试的样本数据     |
| last_test_result | BOOLEAN      | 否       | -                 | 最后测试结果       | true/false             |
| create_time      | DATETIME     | 是       | CURRENT_TIMESTAMP | 创建时间           | YYYY-MM-DD HH:mm:ss    |
| update_time      | DATETIME     | 是       | CURRENT_TIMESTAMP | 更新时间           | YYYY-MM-DD HH:mm:ss    |

## 8. 样本信息表 (sample_info)

存储样本的核心信息和关联关系。

| 字段名              | 数据类型     | 是否必填 | 默认值            | 说明           | 数据格式/示例                              |
| ------------------- | ------------ | -------- | ----------------- | -------------- | ------------------------------------------ |
| sample_id           | VARCHAR(50)  | 是       | -                 | 样本唯一标识ID | 例如：SAM202401010001                      |
| sample_type         | VARCHAR(50)  | 是       | -                 | 样本类型       | 血液/组织/细胞                             |
| sample_code         | VARCHAR(100) | 是       | -                 | 样本编码       | 按编码规则生成                             |
| donor_id            | VARCHAR(50)  | 是       | -                 | 关联捐献者ID   | 关联donor_info表                           |
| consent_form_id     | VARCHAR(50)  | 是       | -                 | 关联同意书ID   | 关联consent_form表                         |
| collection_group_id | VARCHAR(50)  | 是       | -                 | 关联采集组ID   | 关联collection_group表                     |
| code_rule_id        | VARCHAR(50)  | 是       | -                 | 关联编码规则ID | 关联code_rule表                            |
| basic_info          | JSON         | 否       | -                 | 基本信息       | {"采集时间":"2024-01-01", "采集人":"张三"} |
| processing_status   | VARCHAR(20)  | 是       | -                 | 处理状态       | 待处理/处理中/已完成                       |
| storage_info_id     | VARCHAR(50)  | 否       | -                 | 关联存储信息ID | 关联sample_storage表                       |
| create_time         | DATETIME     | 是       | CURRENT_TIMESTAMP | 创建时间       | YYYY-MM-DD HH:mm:ss                        |
| update_time         | DATETIME     | 是       | CURRENT_TIMESTAMP | 更新时间       | YYYY-MM-DD HH:mm:ss                        |

## 表关系说明

1. `sample_info` 是核心表，与其他表存在以下关联关系：

   - 通过 `donor_id` 关联 `donor_info` 表
   - 通过 `consent_form_id` 关联 `consent_form` 表
   - 通过 `collection_group_id` 关联 `collection_group` 表
   - 通过 `code_rule_id` 关联 `code_rule` 表
   - 通过 `storage_info_id` 关联 `sample_storage` 表
2. `desensitization_rule` 通过 `code_rule_id` 关联 `code_rule` 表
3. 以下表通过 `sample_id` 关联 `sample_info` 表：

   - `consent_form`
   - `collection_process`
   - `sample_storage`
