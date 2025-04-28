# 数据库表结构说明

## 1. 医嘱质控表(medical_order_control)
用于存储医嘱质控相关信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| order_type | VARCHAR(50) | 是 | 医嘱类型 | 用药/检验/检查/手术等 |
| control_level | VARCHAR(20) | 是 | 控制级别 | 提醒/警告/禁止 |
| order_content | TEXT | 是 | 医嘱内容 | {"drugName": "青霉素", "dosage": "2片", "frequency": "一日三次"} |
| control_status | VARCHAR(20) | 是 | 控制状态 | 待审核/通过/拒绝 |
| force_pass_reason | TEXT | 否 | 强制通过理由 | "特殊病情需要，经主任医师同意" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 12:00:00 |

## 2. 控制结果表(control_result)
存储医嘱质控的结果信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| order_id | BIGINT | 是 | 关联医嘱ID | 关联medical_order_control表的id |
| control_level | VARCHAR(20) | 是 | 控制级别 | 提醒/警告/禁止 |
| control_status | VARCHAR(20) | 是 | 控制状态 | 待审核/通过/拒绝 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 3. 控制项表(control_item)
存储具体的控制项信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| result_id | BIGINT | 是 | 关联控制结果ID | 关联control_result表的id |
| item_type | VARCHAR(50) | 是 | 项目类型 | 用药/检验/检查等 |
| item_content | TEXT | 是 | 项目内容 | {"checkItem": "血常规", "requirement": "空腹"} |
| item_level | VARCHAR(20) | 是 | 项目级别 | 普通/重要/严重 |
| suggestion | TEXT | 否 | 建议 | "建议更换为XX药品" |

## 4. 疑似诊断推荐表(diagnosis_recommendation)
存储疑似诊断推荐信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| patient_id | BIGINT | 是 | 患者ID | 关联patient_info表的id |
| symptoms | TEXT | 是 | 症状列表 | [{"name": "发热", "degree": "38.5度"}, {"name": "咳嗽", "duration": "3天"}] |
| exam_results | TEXT | 是 | 检查结果列表 | [{"item": "血常规", "result": "白细胞升高"}] |
| diagnosis_status | VARCHAR(20) | 是 | 诊断状态 | 待推荐/已推荐/已确认 |
| final_diagnosis | VARCHAR(200) | 否 | 最终确认的诊断 | "上呼吸道感染" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 12:00:00 |

## 5. 诊断建议表(diagnosis_advice)
存储诊断相关的建议信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| diagnosis_id | BIGINT | 是 | 关联诊断ID | 关联diagnosis_recommendation表的id |
| possible_diagnoses | TEXT | 是 | 可能诊断列表 | [{"disease": "感冒", "probability": 0.8}, {"disease": "流感", "probability": 0.3}] |
| confidence | DECIMAL(5,2) | 是 | 置信度 | 0.00-100.00 |
| reason_analysis | TEXT | 是 | 原因分析 | "基于症状和检验结果分析..." |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 6. 症状分析表(symptom_analysis)
存储症状分析相关信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| symptom_id | VARCHAR(50) | 是 | 症状ID | "SYMPTOM_001" |
| symptom_name | VARCHAR(100) | 是 | 症状名称 | "头痛" |
| severity | VARCHAR(20) | 是 | 严重程度 | 轻度/中度/重度 |
| duration | VARCHAR(50) | 是 | 持续时间 | "3天" |
| related_diagnoses | TEXT | 是 | 相关诊断列表 | ["偏头痛", "神经性头痛", "高血压"] |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 7. 治疗方案推荐表(treatment_recommendation)
存储治疗方案推荐信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| diagnosis_id | BIGINT | 是 | 关联诊断ID | 关联diagnosis_recommendation表的id |
| treatment_type | VARCHAR(20) | 是 | 治疗类型 | 中医/西医 |
| exam_results | TEXT | 是 | 检查结果列表 | [{"item": "CT", "result": "正常"}] |
| diagnosis | VARCHAR(200) | 是 | 确诊的诊断 | "慢性胃炎" |
| treatment_status | VARCHAR(20) | 是 | 治疗状态 | 待推荐/已推荐/已确认 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 8. 治疗建议表(treatment_advice)
存储具体的治疗建议信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| treatment_id | BIGINT | 是 | 关联治疗方案ID | 关联treatment_recommendation表的id |
| treatment_type | VARCHAR(20) | 是 | 治疗类型 | 药物治疗/手术治疗/康复治疗等 |
| suggestions | TEXT | 是 | 建议列表 | [{"type": "用药", "content": "服用XX药物"}] |
| confidence | DECIMAL(5,2) | 是 | 置信度 | 0.00-100.00 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 9. 检查结果方案表(exam_result_plan)
存储检查结果相关的方案信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| treatment_id | BIGINT | 是 | 关联治疗方案ID | 关联treatment_recommendation表的id |
| exam_type | VARCHAR(50) | 是 | 检查类型 | 实验室检查/影像学检查/其他检查等 |
| exam_items | TEXT | 是 | 检查项目列表 | [{"name": "血常规", "requirements": "空腹"}] |
| expected_results | TEXT | 否 | 预期结果 | {"range": "4-10", "unit": "10^9/L"} |
| precautions | TEXT | 否 | 注意事项 | ["检查前禁食8小时", "避免剧烈运动"] |

## 10. 知识库管理表(knowledge_base)
存储医疗知识库信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| knowledge_type | VARCHAR(50) | 是 | 知识类型 | 疾病/药品/检查等 |
| title | VARCHAR(200) | 是 | 标题 | "高血压的诊断与治疗" |
| content | TEXT | 是 | 内容 | "高血压是一种常见的慢性病..." |
| search_keyword | VARCHAR(200) | 是 | 搜索关键词 | "高血压,血压,心脏病" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 12:00:00 |

## 11. 知识类型表(knowledge_type)
存储知识库的类型信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| type_id | VARCHAR(50) | 是 | 类型ID | "KT_001" |
| type_name | VARCHAR(100) | 是 | 类型名称 | "内科疾病" |
| description | TEXT | 否 | 描述 | "关于内科常见疾病的知识" |
| parent_type | VARCHAR(50) | 否 | 父类型 | "疾病" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 12. 知识详情表(knowledge_detail)
存储知识的详细信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| knowledge_id | VARCHAR(50) | 是 | 知识ID | "K_001" |
| title | VARCHAR(200) | 是 | 标题 | "青霉素过敏的处理方法" |
| content | TEXT | 是 | 内容 | "当发现青霉素过敏时..." |
| type_id | BIGINT | 是 | 关联类型ID | 关联knowledge_type表的id |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 12:00:00 |

## 13. 药品说明书表(drug_instructions)
存储药品说明书信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| drug_id | VARCHAR(50) | 是 | 药品ID | "DRUG_001" |
| drug_name | VARCHAR(100) | 是 | 药品名称 | "阿莫西林胶囊" |
| manufacturer | VARCHAR(200) | 是 | 生产厂商 | "XX制药有限公司" |
| usage_info | TEXT | 是 | 用法 | "口服，一次1片，一日3次" |
| dosage | TEXT | 是 | 用量 | "成人：一次0.5g，一日3次" |
| contraindications | TEXT | 是 | 禁忌症 | ["青霉素过敏", "肝功能不全"] |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 14. 相似病历查询表(case_query)
存储相似病历查询条件。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| match_conditions | TEXT | 是 | 匹配条件列表 | {"age": "40-50", "symptoms": ["发热", "咳嗽"]} |
| patient_id | BIGINT | 是 | 患者ID | 关联patient_info表的id |
| case_features | TEXT | 是 | 病历特征列表 | ["高血压", "糖尿病"] |
| similarity_threshold | DECIMAL(5,2) | 是 | 相似度阈值 | 0.00-100.00 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 15. 病历详情表(case_detail)
存储病历详细信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| case_id | VARCHAR(50) | 是 | 病历ID | "CASE_001" |
| patient_id | BIGINT | 是 | 患者ID | 关联patient_info表的id |
| diagnosis | TEXT | 是 | 诊断信息 | ["主诊断: 高血压", "并发症: 冠心病"] |
| treatment | TEXT | 是 | 治疗方案 | {"medications": ["降压药"], "suggestions": ["定期复查"]} |
| similarity | DECIMAL(5,2) | 是 | 相似度 | 0.00-100.00 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |

## 16. 患者信息表(patient_info)
存储患者基本信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| visit_type | VARCHAR(50) | 是 | 就诊类型 | 门诊/住院/急诊 |
| visit_id | VARCHAR(50) | 是 | 就诊ID | "VISIT_001" |
| patient_id | VARCHAR(50) | 是 | 患者ID | "P_001" |
| age | INT | 是 | 年龄 | 25 |
| gender | VARCHAR(10) | 是 | 性别 | 男/女 |
| birth_date | DATE | 是 | 出生日期 | 1990-01-01 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 12:00:00 |