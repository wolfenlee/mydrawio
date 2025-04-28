# HIS系统数据库表结构说明文档

## 目录
1. [医嘱质控相关表](#医嘱质控相关表)
2. [诊断相关表](#诊断相关表)
3. [治疗方案相关表](#治疗方案相关表)
4. [知识库相关表](#知识库相关表)
5. [病历相关表](#病历相关表)
6. [基础信息表](#基础信息表)

## 医嘱质控相关表

### 医嘱质控表(medical_order_control)
存储医嘱质控的基本信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| advice_id | VARCHAR(50) | 是 | 医嘱ID | "ADV_20240101001" |
| order_type | VARCHAR(50) | 是 | 医嘱类型 | 用药/检验/检查/手术等 |
| control_level | VARCHAR(20) | 是 | 控制级别 | 提醒/警告/禁止 |
| order_content | TEXT | 是 | 医嘱内容 | {"drugName": "青霉素", "dosage": "2片", "frequency": "一日三次"} |
| control_status | VARCHAR(20) | 是 | 控制状态 | 待审核/通过/拒绝 |
| force_pass_reason | TEXT | 否 | 强制通过理由 | "特殊病情需要，经主任医师同意" |
| prescription_id | VARCHAR(50) | 否 | 处方ID | "RX_20240101001" |
| advice_group | VARCHAR(100) | 否 | 医嘱分组 | "抗生素类" |
| long_term_temp | VARCHAR(20) | 是 | 长期或临时 | 长期/临时 |
| advice_dept | VARCHAR(50) | 是 | 医嘱开立科室 | "内科" |
| advice_doctor | VARCHAR(50) | 是 | 医嘱开立者 | "张医生" |
| audit_dept | VARCHAR(50) | 否 | 医嘱审核科室 | "药剂科" |
| audit_doctor | VARCHAR(50) | 否 | 医嘱审核者 | "李药师" |
| input_time | DATETIME | 是 | 录入时间 | 2024-01-01 08:00:00 |
| audit_time | DATETIME | 否 | 审核时间 | 2024-01-01 08:30:00 |
| start_time | DATETIME | 是 | 开始时间 | 2024-01-01 09:00:00 |
| end_time | DATETIME | 否 | 结束时间 | 2024-01-03 09:00:00 |
| specimen | VARCHAR(50) | 否 | 标本 | "静脉血" |
| medication_days | INT | 否 | 用药天数 | 3 |
| drug_trade_name | VARCHAR(100) | 否 | 药物商品名 | "阿莫西林胶囊" |
| drug_generic_name | VARCHAR(100) | 否 | 药物通用名 | "阿莫西林" |
| drug_approval_number | VARCHAR(50) | 否 | 国药准字号 | "国药准字H12345678" |
| drug_code | VARCHAR(50) | 否 | 药物编码 | "DRUG001" |
| drug_category | VARCHAR(50) | 否 | 药物类别 | "抗生素" |
| drug_form | VARCHAR(50) | 否 | 药物剂型 | 注射剂/片剂/胶囊剂/丸剂/散剂/气雾剂等 |
| administration_route | VARCHAR(50) | 否 | 用药途径 | 口服/皮下注射/肌肉注射/静脉注射/外用/雾化吸入等 |
| frequency | VARCHAR(50) | 否 | 使用频率 | "tid" |
| single_dose | VARCHAR(50) | 否 | 单次剂量 | "0.5g" |
| total_dose | VARCHAR(50) | 否 | 总剂量 | "4.5g" |
| dose_unit | VARCHAR(20) | 否 | 剂量单位 | "g/片/ml" |
| need_skin_test | VARCHAR(5) | 否 | 需要皮试 | 是/否 |
| execution_frequency | VARCHAR(50) | 否 | 执行频率 | "每4小时一次" |
| nursing_level | VARCHAR(20) | 否 | 护理级别 | "特级护理" |
| report_id | VARCHAR(50) | 否 | 报告ID | "RPT_20240101001" |
| anesthesia_method | VARCHAR(50) | 否 | 麻醉方式 | "局部麻醉" |
| exam_position | TEXT | 否 | 检查部位 | ["胸部", "腹部"] |
| exam_method | TEXT | 否 | 检查方法 | ["CT", "增强"] |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 08:30:00 |

### 控制结果表(control_result)
存储医嘱质控的结果信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| order_id | BIGINT | 是 | 关联医嘱ID | 关联medical_order_control表的id |
| control_level | VARCHAR(20) | 是 | 控制级别 | 提醒/警告/禁止 |
| control_status | VARCHAR(20) | 是 | 控制状态 | 待审核/通过/拒绝 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 控制项表(control_item)
存储具体的控制项信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| result_id | BIGINT | 是 | 关联控制结果ID | 关联control_result表的id |
| item_type | VARCHAR(50) | 是 | 项目类型 | 用药/检验/检查等 |
| item_content | TEXT | 是 | 项目内容 | {"checkItem": "血常规", "requirement": "空腹"} |
| item_level | VARCHAR(20) | 是 | 项目级别 | 普通/重要/严重 |
| suggestion | TEXT | 否 | 建议 | "建议更换为XX药品" |

## 诊断相关表

### 疑似诊断推荐表(diagnosis_recommendation)
存储疑似诊断推荐信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| patient_id | BIGINT | 是 | 患者ID | 关联patient_info表的id |
| symptoms | TEXT | 是 | 症状列表 | [{"name": "发热", "degree": "38.5度"}, {"name": "咳嗽", "duration": "3天"}] |
| exam_results | TEXT | 是 | 检查结果列表 | [{"item": "血常规", "result": "白细胞升高"}] |
| diagnosis_status | VARCHAR(20) | 是 | 诊断状态 | 待推荐/已推荐/已确认 |
| final_diagnosis | VARCHAR(200) | 否 | 最终确认的诊断 | "上呼吸道感染" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 08:30:00 |

### 诊断建议表(diagnosis_advice)
存储诊断相关的建议信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| diagnosis_id | BIGINT | 是 | 关联诊断ID | 关联diagnosis_recommendation表的id |
| possible_diagnoses | TEXT | 是 | 可能诊断列表 | [{"disease": "感冒", "probability": 0.8}, {"disease": "流感", "probability": 0.3}] |
| confidence | DECIMAL(5,2) | 是 | 置信度 | 0.00-100.00 |
| reason_analysis | TEXT | 是 | 原因分析 | "基于症状和检验结果分析..." |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 症状分析表(symptom_analysis)
存储症状分析相关信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| symptom_id | VARCHAR(50) | 是 | 症状ID | "SYMPTOM_001" |
| symptom_name | VARCHAR(100) | 是 | 症状名称 | "头痛" |
| severity | VARCHAR(20) | 是 | 严重程度 | 轻度/中度/重度 |
| duration | VARCHAR(50) | 是 | 持续时间 | "3天" |
| related_diagnoses | TEXT | 是 | 相关诊断列表 | ["偏头痛", "神经性头痛", "高血压"] |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

## 治疗方案相关表

### 治疗方案推荐表(treatment_recommendation)
存储治疗方案推荐信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| diagnosis_id | BIGINT | 是 | 关联诊断ID | 关联diagnosis_recommendation表的id |
| treatment_type | VARCHAR(20) | 是 | 治疗类型 | 中医/西医 |
| exam_results | TEXT | 是 | 检查结果列表 | [{"item": "CT", "result": "正常"}] |
| diagnosis | VARCHAR(200) | 是 | 确诊的诊断 | "慢性胃炎" |
| treatment_status | VARCHAR(20) | 是 | 治疗状态 | 待推荐/已推荐/已确认 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 治疗建议表(treatment_advice)
存储具体的治疗建议信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| treatment_id | BIGINT | 是 | 关联治疗方案ID | 关联treatment_recommendation表的id |
| treatment_type | VARCHAR(20) | 是 | 治疗类型 | 药物治疗/手术治疗/康复治疗等 |
| suggestions | TEXT | 是 | 建议列表 | [{"type": "用药", "content": "服用XX药物"}] |
| confidence | DECIMAL(5,2) | 是 | 置信度 | 0.00-100.00 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 检查结果方案表(exam_result_plan)
存储检查结果相关的方案信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| treatment_id | BIGINT | 是 | 关联治疗方案ID | 关联treatment_recommendation表的id |
| exam_type | VARCHAR(50) | 是 | 检查类型 | 实验室检查/影像学检查/其他检查等 |
| exam_items | TEXT | 是 | 检查项目列表 | [{"name": "血常规", "requirements": "空腹"}] |
| expected_results | TEXT | 否 | 预期结果 | {"range": "4-10", "unit": "10^9/L"} |
| precautions | TEXT | 否 | 注意事项 | ["检查前禁食8小时", "避免剧烈运动"] |

## 知识库相关表

### 知识库管理表(knowledge_base)
存储医疗知识库信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| knowledge_type | VARCHAR(50) | 是 | 知识类型 | 疾病/药品/检查等 |
| title | VARCHAR(200) | 是 | 标题 | "高血压的诊断与治疗" |
| content | TEXT | 是 | 内容 | "高血压是一种常见的慢性病..." |
| search_keyword | VARCHAR(200) | 是 | 搜索关键词 | "高血压,血压,心脏病" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 08:30:00 |

### 知识类型表(knowledge_type)
存储知识库的类型信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| type_id | VARCHAR(50) | 是 | 类型ID | "KT_001" |
| type_name | VARCHAR(100) | 是 | 类型名称 | "内科疾病" |
| description | TEXT | 否 | 描述 | "关于内科常见疾病的知识" |
| parent_type | VARCHAR(50) | 否 | 父类型 | "疾病" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 知识详情表(knowledge_detail)
存储知识的详细信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| knowledge_id | VARCHAR(50) | 是 | 知识ID | "K_001" |
| title | VARCHAR(200) | 是 | 标题 | "青霉素过敏的处理方法" |
| content | TEXT | 是 | 内容 | "当发现青霉素过敏时..." |
| type_id | BIGINT | 是 | 关联类型ID | 关联knowledge_type表的id |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 08:30:00 |

### 药品说明书表(drug_instructions)
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
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

## 病历相关表

### 相似病历查询表(case_query)
存储相似病历查询条件。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| match_conditions | TEXT | 是 | 匹配条件列表 | {"age": "40-50", "symptoms": ["发热", "咳嗽"]} |
| patient_id | BIGINT | 是 | 患者ID | 关联patient_info表的id |
| case_features | TEXT | 是 | 病历特征列表 | ["高血压", "糖尿病"] |
| similarity_threshold | DECIMAL(5,2) | 是 | 相似度阈值 | 0.00-100.00 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 病历详情表(case_detail)
存储病历详细信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| case_id | VARCHAR(50) | 是 | 病历ID | "CASE_001" |
| patient_id | BIGINT | 是 | 患者ID | 关联patient_info表的id |
| diagnosis | TEXT | 是 | 诊断信息 | ["主诊断: 高血压", "并发症: 冠心病"] |
| treatment | TEXT | 是 | 治疗方案 | {"medications": ["降压药"], "suggestions": ["定期复查"]} |
| similarity | DECIMAL(5,2) | 是 | 相似度 | 0.00-100.00 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

## 基础信息表

### 患者信息表(patient_info)
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
| visit_count | INT | 否 | 就诊次数 | 1 |
| occupation | VARCHAR(50) | 否 | 职业 | "教师" |
| nation | VARCHAR(50) | 否 | 民族 | "汉族" |
| birth_place | VARCHAR(200) | 否 | 出生地 | "北京市朝阳区" |
| current_address | VARCHAR(200) | 否 | 现住地 | "北京市海淀区" |
| fee_type | VARCHAR(50) | 是 | 费用类型 | 医保/商保/自费/公费/等 |
| height | VARCHAR(20) | 否 | 身高 | "180cm" |
| weight | VARCHAR(20) | 否 | 体重 | "70kg" |
| blood_type | VARCHAR(10) | 否 | ABO血型 | A/B/AB/O |
| rh_type | VARCHAR(10) | 否 | Rh血型 | 阴/阳 |
| marital_status | VARCHAR(20) | 否 | 婚姻状态 | 未婚/已婚/离异/丧偶 |
| special_population | TEXT | 否 | 特殊人群 | ["孕妇", "哺乳期"] |
| physiological_state | VARCHAR(50) | 否 | 生理状态 | 月经期/妊娠期/哺乳期等 |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 工作人员信息表(staff_info)
存储医院工作人员信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| hospital | VARCHAR(100) | 是 | 医院名称 | "XX医院" |
| department | VARCHAR(50) | 是 | 科室名称 | "内科" |
| staff_name | VARCHAR(50) | 是 | 工作人员姓名 | "张三" |
| account_id | VARCHAR(50) | 是 | 系统账号 | "zhangsan001" |
| role | VARCHAR(20) | 是 | 角色 | 医生/护士/药师/等 |
| title | VARCHAR(50) | 否 | 职称 | "主任医师" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 08:30:00 |

### 门诊记录表(outpatient_record)
存储门诊就诊记录。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| patient_id | BIGINT | 是 | 关联患者ID | 关联patient_info表的id |
| staff_id | BIGINT | 是 | 关联工作人员ID | 关联staff_info表的id |
| department | VARCHAR(50) | 是 | 门诊科室 | "内科" |
| record_id | VARCHAR(50) | 是 | 门诊记录ID | "OPR_001" |
| record_content | TEXT | 是 | 记录内容 | "患者主诉..." |
| record_time | DATETIME | 是 | 记录书写时间 | 2024-01-01 08:00:00 |
| visit_time | DATETIME | 是 | 就诊时间 | 2024-01-01 09:00:00 |
| is_followup | VARCHAR(5) | 是 | 是否复诊 | 是/否 |
| pregnancy_status | VARCHAR(20) | 否 | 怀孕状态 | 未孕/已孕/已育 |
| chief_complaint | TEXT | 是 | 主诉 | "发热3天，咳嗽5天" |
| present_illness | TEXT | 是 | 现病史 | "患者3天前无明显诱因出现发热..." |
| past_history | TEXT | 否 | 既往史 | "否认高血压、糖尿病病史" |
| personal_history | TEXT | 否 | 个人史 | "否认吸烟饮酒史" |
| menstrual_history | TEXT | 否 | 月经史 | "月经规律，28天一次" |
| marriage_history | TEXT | 否 | 婚育史 | "已婚，育有一子" |
| family_history | TEXT | 否 | 家族史 | "父母均健在，否认家族遗传病史" |
| allergy_history | TEXT | 否 | 过敏史 | "对青霉素过敏" |
| vaccination_history | TEXT | 否 | 接种史 | "按计划完成常规疫苗接种" |
| physical_examination | TEXT | 是 | 体格检查 | "T:38.5℃, P:80次/分, R:20次/分, BP:120/80mmHg" |
| auxiliary_examination | TEXT | 否 | 辅助检查 | "胸片：双肺纹理增多，心影正常" |
| specialist_examination | TEXT | 否 | 专科检查 | "双肺呼吸音粗，可闻及干湿啰音" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |
| update_time | DATETIME | 是 | 更新时间 | 2024-01-01 08:30:00 |

### 诊断表(diagnosis)
存储患者诊断信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| record_id | BIGINT | 是 | 关联记录ID | 关联门诊记录或入院记录表的id |
| diagnosis_type | VARCHAR(50) | 是 | 诊断类型 | 初步诊断/入院诊断/补充诊断/确诊诊断/其他诊断/鉴别诊断/门诊诊断 |
| diagnosis_item | TEXT | 是 | 诊断项 | {"name": "肺炎", "icd": "J18.901"} |
| is_main_diagnosis | VARCHAR(5) | 是 | 主要诊断 | 是/否 |
| icd_code | VARCHAR(50) | 是 | 诊断ICD编码 | "J18.901" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 中医诊断表(tcm_diagnosis)
存储中医诊断信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| record_id | BIGINT | 是 | 关联记录ID | 关联门诊记录或入院记录表的id |
| diagnosis_type | VARCHAR(50) | 是 | 诊断类型 | 初步诊断/入院诊断/补充诊断/确诊诊断/其他诊断/鉴别诊断 |
| is_main_diagnosis | VARCHAR(5) | 是 | 主要诊断 | 是/否 |
| disease_name | VARCHAR(100) | 是 | 中医疾病名称 | "肺热咳嗽" |
| disease_code | VARCHAR(50) | 是 | 中医疾病代码 | "ZY0123" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |

### 中医证型表(tcm_syndrome)
存储中医证型信息。

| 字段名 | 类型 | 必填 | 说明 | 数据格式/样例 |
|--------|------|------|------|---------------|
| id | BIGINT | 是 | 主键ID | 自增长整数 |
| tcm_diagnosis_id | BIGINT | 是 | 关联中医诊断ID | 关联tcm_diagnosis表的id |
| syndrome_name | VARCHAR(100) | 是 | 证型名称 | "肺胃热盛证" |
| syndrome_code | VARCHAR(50) | 是 | 证型代码 | "ZX0123" |
| create_time | DATETIME | 是 | 创建时间 | 2024-01-01 08:00:00 |