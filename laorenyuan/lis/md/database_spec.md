# LIS系统数据库设计规范

## 1. 工作人员表（staff）

| 字段名 | 类型 | 长度 | 必填 | 唯一 | 默认值 | 说明 | 数据格式 |
|--------|------|------|------|------|--------|------|----------|
| staff_id | VARCHAR | 36 | 是 | 是 | - | 工作人员ID | UUID格式 |
| hospital | VARCHAR | 100 | 是 | 否 | - | 医院名称 | 中文全称 |
| department | VARCHAR | 100 | 是 | 否 | - | 科室名称 | 标准科室名称 |
| name | VARCHAR | 50 | 是 | 否 | - | 姓名 | 中文姓名 |
| account_id | VARCHAR | 50 | 是 | 是 | - | 账号ID | 字母数字组合（6-20位）|
| role | VARCHAR | 50 | 否 | 否 | - | 角色 | 医生/护士/技师等 |
| title | VARCHAR | 50 | 否 | 否 | - | 职称 | 主任医师/副主任医师等 |
| created_at | DATETIME | - | 否 | 否 | CURRENT_TIMESTAMP | 创建时间 | YYYY-MM-DD HH:MM:SS |

## 2. 患者信息表（patient）

| 字段名 | 类型 | 长度 | 必填 | 唯一 | 默认值 | 说明 | 数据格式 |
|--------|------|------|------|------|--------|------|----------|
| patient_id | VARCHAR | 36 | 是 | 是 | - | 患者ID | UUID格式 |
| visit_id | VARCHAR | 36 | 是 | 是 | - | 就诊ID | 格式V+年月日+3位序列号（例：V20240101001）|
| visit_type | ENUM | - | 是 | 否 | - | 就诊类型 | 门诊/住院/急诊/体检 |
| age | INT | - | 是 | 否 | - | 年龄 | 1-150整数 |
| gender | ENUM | - | 是 | 否 | - | 性别 | 男/女 |
| birthdate | DATE | - | 否 | 否 | - | 出生日期 | YYYY-MM-DD |
| occupation | VARCHAR | 100 | 否 | 否 | - | 职业 | 中文标准职业名称 |
| created_at | DATETIME | - | 否 | 否 | CURRENT_TIMESTAMP | 创建时间 | YYYY-MM-DD HH:MM:SS |

## 3. 检验报告表（report）

| 字段名 | 类型 | 长度 | 必填 | 唯一 | 默认值 | 说明 | 数据格式 |
|--------|------|------|------|------|--------|------|----------|
| report_id | VARCHAR | 36 | 是 | 是 | - | 报告ID | UUID格式 |
| patient_id | VARCHAR | 36 | 是 | 否 | - | 患者ID | 关联patient表 |
| staff_id | VARCHAR | 36 | 是 | 否 | - | 检验人员ID | 关联staff表 |
| specimen_type | VARCHAR | 50 | 是 | 否 | - | 标本类型 | 血清/全血/尿液等 |
| specimen_no | VARCHAR | 50 | 否 | 是 | - | 标本号 | 年月日+科室代码+4位序列号（例：20240101LAB0001）|
| sampling_time | DATETIME | - | 是 | 否 | - | 采样时间 | YYYY-MM-DD HH:MM:SS |
| test_items | VARCHAR | 200 | 是 | 否 | - | 检验项目 | 逗号分隔项目名称（例：血常规,肝功能）|
| report_status | ENUM | - | 否 | 否 | 待审核 | 报告状态 | 待审核/已审核/已发布 |
| created_at | DATETIME | - | 否 | 否 | CURRENT_TIMESTAMP | 创建时间 | YYYY-MM-DD HH:MM:SS |

## 4. 检验结果明细表（test_item）

| 字段名 | 类型 | 长度 | 必填 | 唯一 | 默认值 | 说明 | 数据格式 |
|--------|------|------|------|------|--------|------|----------|
| item_id | VARCHAR | 36 | 是 | 是 | - | 项目ID | UUID格式 |
| report_id | VARCHAR | 36 | 是 | 否 | - | 报告ID | 关联report表 |
| item_name | VARCHAR | 100 | 是 | 否 | - | 检验指标项 | 中文标准名称（例：白细胞计数）|
| abbreviation | VARCHAR | 20 | 否 | 否 | - | 指标缩写 | 英文缩写（例：WBC）|
| result | DECIMAL | 10,2 | 是 | 否 | - | 检验结果 | 数值型（例：12.50）|
| unit | VARCHAR | 20 | 是 | 否 | - | 单位 | 标准单位（例：10^9/L）|
| reference_range | VARCHAR | 50 | 是 | 否 | - | 正常值范围 | 格式：下限-上限（例：4.0-10.0）|
| abnormal_flag | ENUM | - | 是 | 否 | - | 异常标志 | 正常/偏高(↑)/偏低(↓) |
| created_at | DATETIME | - | 否 | 否 | CURRENT_TIMESTAMP | 创建时间 | YYYY-MM-DD HH:MM:SS |

（其他表结构文档请继续补充...）

## 数据格式说明

1. **UUID格式**：采用版本4的UUID，示例：`a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11`
2. **时间格式**：
   - 日期：`YYYY-MM-DD`
   - 日期时间：`YYYY-MM-DD HH:MM:SS`
3. **编码规则**：
   - 就诊ID：`V+年月日+3位序列号`（例：V20240101001）
   - 标本号：`年月日+科室代码+4位序列号`（例：20240101LAB0001）
4. **数值精度**：
   - DECIMAL类型统一保留两位小数
   - 整数类型不做小数处理
5. **ENUM取值范围**：
   - 报告状态：待审核/已审核/已发布
   - 性别：男/女
   - 异常标志：正常/偏高(↑)/偏低(↓)