-- 医嘱质控表
CREATE TABLE medical_order_control (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    order_type VARCHAR(50) COMMENT '医嘱类型(用药/检验/检查/手术等)',
    control_level VARCHAR(20) COMMENT '控制级别(提醒/警告/禁止)',
    order_content TEXT COMMENT '医嘱内容(具体的医嘱详细信息)',
    control_status VARCHAR(20) COMMENT '控制状态(待审核/通过/拒绝)',
    force_pass_reason TEXT COMMENT '强制通过理由(当需要强制通过时的说明)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '医嘱质控表';

-- 控制结果表
CREATE TABLE control_result (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    order_id BIGINT COMMENT '关联医嘱ID(关联medical_order_control表)',
    control_level VARCHAR(20) COMMENT '控制级别(提醒/警告/禁止)',
    control_status VARCHAR(20) COMMENT '控制状态(待审核/通过/拒绝)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (order_id) REFERENCES medical_order_control(id)
) COMMENT '控制结果表';

-- 控制项表
CREATE TABLE control_item (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    result_id BIGINT COMMENT '关联控制结果ID(关联control_result表)',
    item_type VARCHAR(50) COMMENT '项目类型(用药/检验/检查等)',
    item_content TEXT COMMENT '项目内容(具体的控制项详细信息)',
    item_level VARCHAR(20) COMMENT '项目级别(普通/重要/严重)',
    suggestion TEXT COMMENT '建议(系统给出的处理建议)',
    FOREIGN KEY (result_id) REFERENCES control_result(id)
) COMMENT '控制项表';

-- 疑似诊断推荐表
CREATE TABLE diagnosis_recommendation (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    patient_id BIGINT COMMENT '患者ID(关联patient_info表)',
    symptoms TEXT COMMENT '症状列表(JSON格式，包含症状详细信息)',
    exam_results TEXT COMMENT '检查结果列表(JSON格式，包含检查结果详细信息)',
    diagnosis_status VARCHAR(20) COMMENT '诊断状态(待推荐/已推荐/已确认)',
    final_diagnosis VARCHAR(200) COMMENT '最终确认的诊断(确诊后的诊断结果)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '疑似诊断推荐表';

-- 诊断建议表
CREATE TABLE diagnosis_advice (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    diagnosis_id BIGINT COMMENT '关联诊断ID(关联diagnosis_recommendation表)',
    possible_diagnoses TEXT COMMENT '可能诊断列表(JSON格式，包含可能的诊断及其概率)',
    confidence DECIMAL(5,2) COMMENT '置信度(0-100的数值，表示推荐的可信程度)',
    reason_analysis TEXT COMMENT '原因分析(系统分析的诊断依据)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (diagnosis_id) REFERENCES diagnosis_recommendation(id)
) COMMENT '诊断建议表';

-- 症状分析表
CREATE TABLE symptom_analysis (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    symptom_id VARCHAR(50) COMMENT '症状ID(症状的唯一标识)',
    symptom_name VARCHAR(100) COMMENT '症状名称(标准化的症状描述)',
    severity VARCHAR(20) COMMENT '严重程度(轻度/中度/重度)',
    duration VARCHAR(50) COMMENT '持续时间(症状持续的时间描述)',
    related_diagnoses TEXT COMMENT '相关诊断列表(JSON格式，包含可能相关的诊断)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '症状分析表';

-- 治疗方案推荐表
CREATE TABLE treatment_recommendation (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    diagnosis_id BIGINT COMMENT '关联诊断ID(关联diagnosis_recommendation表)',
    treatment_type VARCHAR(20) COMMENT '治疗类型(中医/西医)',
    exam_results TEXT COMMENT '检查结果列表(JSON格式，包含检查结果详细信息)',
    diagnosis VARCHAR(200) COMMENT '确诊的诊断(最终确认的诊断结果)',
    treatment_status VARCHAR(20) COMMENT '治疗状态(待推荐/已推荐/已确认)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (diagnosis_id) REFERENCES diagnosis_recommendation(id)
) COMMENT '治疗方案推荐表';

-- 治疗建议表
CREATE TABLE treatment_advice (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    treatment_id BIGINT COMMENT '关联治疗方案ID(关联treatment_recommendation表)',
    treatment_type VARCHAR(20) COMMENT '治疗类型(药物治疗/手术治疗/康复治疗等)',
    suggestions TEXT COMMENT '建议列表(JSON格式，包含具体的治疗建议)',
    confidence DECIMAL(5,2) COMMENT '置信度(0-100的数值，表示建议的可信程度)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (treatment_id) REFERENCES treatment_recommendation(id)
) COMMENT '治疗建议表';

-- 检查结果方案表
CREATE TABLE exam_result_plan (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    treatment_id BIGINT COMMENT '关联治疗方案ID(关联treatment_recommendation表)',
    exam_type VARCHAR(50) COMMENT '检查类型(实验室检查/影像学检查/其他检查等)',
    exam_items TEXT COMMENT '检查项目列表(JSON格式，包含具体检查项目)',
    expected_results TEXT COMMENT '预期结果(预期的检查结果范围或描述)',
    precautions TEXT COMMENT '注意事项(检查前后的注意事项)',
    FOREIGN KEY (treatment_id) REFERENCES treatment_recommendation(id)
) COMMENT '检查结果方案表';

-- 知识库管理表
CREATE TABLE knowledge_base (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    knowledge_type VARCHAR(50) COMMENT '知识类型(疾病/药品/检查等)',
    title VARCHAR(200) COMMENT '标题(知识条目的标题)',
    content TEXT COMMENT '内容(知识条目的详细内容)',
    search_keyword VARCHAR(200) COMMENT '搜索关键词(用于快速检索)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '知识库管理表';

-- 知识类型表
CREATE TABLE knowledge_type (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    type_id VARCHAR(50) COMMENT '类型ID(知识类型的唯一标识)',
    type_name VARCHAR(100) COMMENT '类型名称(知识类型的名称)',
    description TEXT COMMENT '描述(知识类型的详细描述)',
    parent_type VARCHAR(50) COMMENT '父类型(上级知识类型)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '知识类型表';

-- 知识详情表
CREATE TABLE knowledge_detail (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    knowledge_id VARCHAR(50) COMMENT '知识ID(知识条目的唯一标识)',
    title VARCHAR(200) COMMENT '标题(知识详情的标题)',
    content TEXT COMMENT '内容(知识详情的具体内容)',
    type_id BIGINT COMMENT '关联类型ID(关联knowledge_type表)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (type_id) REFERENCES knowledge_type(id)
) COMMENT '知识详情表';

-- 药品说明书表
CREATE TABLE drug_instructions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    drug_id VARCHAR(50) COMMENT '药品ID(药品的唯一标识)',
    drug_name VARCHAR(100) COMMENT '药品名称(药品通用名)',
    manufacturer VARCHAR(200) COMMENT '生产厂商(药品生产企业)',
    usage_info TEXT COMMENT '用法(药品使用方法)',
    dosage TEXT COMMENT '用量(药品使用剂量)',
    contraindications TEXT COMMENT '禁忌症(JSON格式，包含药品使用禁忌)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '药品说明书表';

-- 相似病历查询表
CREATE TABLE case_query (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    match_conditions TEXT COMMENT '匹配条件列表(JSON格式，包含查询条件)',
    patient_id BIGINT COMMENT '患者ID(关联patient_info表)',
    case_features TEXT COMMENT '病历特征列表(JSON格式，包含病历特征)',
    similarity_threshold DECIMAL(5,2) COMMENT '相似度阈值(0-100的数值，表示最低相似度要求)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '相似病历查询表';

-- 病历详情表
CREATE TABLE case_detail (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    case_id VARCHAR(50) COMMENT '病历ID(病历的唯一标识)',
    patient_id BIGINT COMMENT '患者ID(关联patient_info表)',
    diagnosis TEXT COMMENT '诊断信息(患者的诊断结果)',
    treatment TEXT COMMENT '治疗方案(患者的治疗计划)',
    similarity DECIMAL(5,2) COMMENT '相似度(0-100的数值，表示与查询条件的相似程度)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '病历详情表';

-- 患者信息表
CREATE TABLE patient_info (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    visit_type VARCHAR(50) COMMENT '就诊类型(门诊/住院/急诊)',
    visit_id VARCHAR(50) COMMENT '就诊ID(本次就诊的唯一标识)',
    patient_id VARCHAR(50) COMMENT '患者ID(患者的唯一标识)',
    age INT COMMENT '年龄(患者年龄)',
    gender VARCHAR(10) COMMENT '性别(男/女)',
    birth_date DATE COMMENT '出生日期(患者出生日期)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '患者信息表';

-- 修改医嘱质控表(medical_order_control)，增加医嘱相关字段
ALTER TABLE medical_order_control
ADD COLUMN advice_id VARCHAR(50) COMMENT '医嘱ID(医嘱项目的唯一ID)',
ADD COLUMN prescription_id VARCHAR(50) COMMENT '处方ID(处方号)',
ADD COLUMN advice_group VARCHAR(100) COMMENT '医嘱分组(可以代表医嘱分组的信息)',
ADD COLUMN long_term_temp VARCHAR(20) COMMENT '长期或临时(长期/临时)',
ADD COLUMN advice_dept VARCHAR(50) COMMENT '医嘱开立科室',
ADD COLUMN advice_doctor VARCHAR(50) COMMENT '医嘱开立者',
ADD COLUMN audit_dept VARCHAR(50) COMMENT '医嘱审核科室',
ADD COLUMN audit_doctor VARCHAR(50) COMMENT '医嘱审核者',
ADD COLUMN input_time DATETIME COMMENT '录入时间(医嘱开立时间)',
ADD COLUMN audit_time DATETIME COMMENT '审核时间(医嘱审核时间)',
ADD COLUMN start_time DATETIME COMMENT '开始时间(医嘱下达的预期开始时间)',
ADD COLUMN end_time DATETIME COMMENT '结束时间(医嘱下达的预期结束时间)',
ADD COLUMN specimen VARCHAR(50) COMMENT '标本(检验医嘱独有)',
ADD COLUMN medication_days INT COMMENT '用药天数',
ADD COLUMN drug_trade_name VARCHAR(100) COMMENT '药物商品名',
ADD COLUMN drug_generic_name VARCHAR(100) COMMENT '药物通用名',
ADD COLUMN drug_approval_number VARCHAR(50) COMMENT '国药准字号',
ADD COLUMN drug_code VARCHAR(50) COMMENT '药物编码',
ADD COLUMN drug_category VARCHAR(50) COMMENT '药物类别',
ADD COLUMN drug_form VARCHAR(50) COMMENT '药物剂型(注射剂/片剂/胶囊剂/丸剂/散剂/气雾剂等)',
ADD COLUMN administration_route VARCHAR(50) COMMENT '用药途径(口服/皮下注射/肌肉注射/静脉注射/外用/雾化吸入等)',
ADD COLUMN frequency VARCHAR(50) COMMENT '使用频率',
ADD COLUMN single_dose VARCHAR(50) COMMENT '单次剂量',
ADD COLUMN total_dose VARCHAR(50) COMMENT '总剂量',
ADD COLUMN dose_unit VARCHAR(20) COMMENT '剂量单位',
ADD COLUMN need_skin_test VARCHAR(5) COMMENT '需要皮试(是/否)',
ADD COLUMN execution_frequency VARCHAR(50) COMMENT '执行频率(护理医嘱、诊疗医嘱独有)',
ADD COLUMN nursing_level VARCHAR(20) COMMENT '护理级别',
ADD COLUMN report_id VARCHAR(50) COMMENT '报告ID(检验报告ID或检查报告ID)',
ADD COLUMN anesthesia_method VARCHAR(50) COMMENT '麻醉方式(手术医嘱独有)',
ADD COLUMN exam_position TEXT COMMENT '检查部位(JSON数组)',
ADD COLUMN exam_method TEXT COMMENT '检查方法(JSON数组)';

-- 修改患者信息表(patient_info)，增加患者相关字段
ALTER TABLE patient_info
ADD COLUMN visit_count INT COMMENT '就诊次数("1":初诊，大于1表示复诊)',
ADD COLUMN occupation VARCHAR(50) COMMENT '职业',
ADD COLUMN nation VARCHAR(50) COMMENT '民族',
ADD COLUMN birth_place VARCHAR(200) COMMENT '出生地',
ADD COLUMN current_address VARCHAR(200) COMMENT '现住地',
ADD COLUMN fee_type VARCHAR(50) COMMENT '费用类型(医保/商保/自费/公费/等)',
ADD COLUMN height VARCHAR(20) COMMENT '身高(如:180cm)',
ADD COLUMN weight VARCHAR(20) COMMENT '体重(如:70kg)',
ADD COLUMN blood_type VARCHAR(10) COMMENT 'ABO血型(A/B/AB/O)',
ADD COLUMN rh_type VARCHAR(10) COMMENT 'Rh血型(阴/阳)',
ADD COLUMN marital_status VARCHAR(20) COMMENT '婚姻状态(未婚/已婚/离异/丧偶)',
ADD COLUMN special_population TEXT COMMENT '特殊人群(JSON数组)',
ADD COLUMN physiological_state VARCHAR(50) COMMENT '生理状态(月经期/妊娠期/哺乳期/孕早期/孕中期/孕晚期/卵泡期/黄体期/排卵期)';

-- 新增工作人员信息表(staff_info)
CREATE TABLE staff_info (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    hospital VARCHAR(100) COMMENT '医院名称',
    department VARCHAR(50) COMMENT '科室名称',
    staff_name VARCHAR(50) COMMENT '工作人员姓名',
    account_id VARCHAR(50) COMMENT '医疗信息系统账号',
    role VARCHAR(20) COMMENT '角色(医生/护士/药师/等)',
    title VARCHAR(50) COMMENT '职称',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) COMMENT '工作人员信息表';

-- 新增门诊记录表(outpatient_record)
CREATE TABLE outpatient_record (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    patient_id BIGINT COMMENT '关联患者ID',
    staff_id BIGINT COMMENT '关联工作人员ID',
    department VARCHAR(50) COMMENT '门诊科室',
    record_id VARCHAR(50) COMMENT '门诊记录ID',
    record_content TEXT COMMENT '记录内容(无结构化纯文本内容)',
    record_time DATETIME COMMENT '门诊记录书写时间',
    visit_time DATETIME COMMENT '患者就诊时间',
    is_followup VARCHAR(5) COMMENT '是否复诊(是/否)',
    pregnancy_status VARCHAR(20) COMMENT '怀孕状态(未孕/已孕/已育)',
    chief_complaint TEXT COMMENT '主诉',
    present_illness TEXT COMMENT '现病史',
    past_history TEXT COMMENT '既往史',
    personal_history TEXT COMMENT '个人史',
    menstrual_history TEXT COMMENT '月经史',
    marriage_history TEXT COMMENT '婚育史',
    family_history TEXT COMMENT '家族史',
    allergy_history TEXT COMMENT '过敏史',
    vaccination_history TEXT COMMENT '接种史',
    physical_examination TEXT COMMENT '体格检查',
    auxiliary_examination TEXT COMMENT '辅助检查',
    specialist_examination TEXT COMMENT '专科检查',
    medical_advice TEXT COMMENT '嘱咐(医生对患者建议的注意事项)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (patient_id) REFERENCES patient_info(id),
    FOREIGN KEY (staff_id) REFERENCES staff_info(id)
) COMMENT '门诊记录表';

-- 新增入院记录表(admission_record)
CREATE TABLE admission_record (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    patient_id BIGINT COMMENT '关联患者ID',
    staff_id BIGINT COMMENT '关联工作人员ID',
    department VARCHAR(50) COMMENT '入院科室',
    record_id VARCHAR(50) COMMENT '入院记录ID',
    record_content TEXT COMMENT '记录内容(无结构化纯文本内容)',
    record_time DATETIME COMMENT '入院记录书写时间',
    admission_time DATETIME COMMENT '患者入院时间',
    pregnancy_status VARCHAR(20) COMMENT '怀孕状态(未孕/已孕/已育)',
    medical_historian VARCHAR(100) COMMENT '病史陈述者',
    chief_complaint TEXT COMMENT '主诉',
    present_illness TEXT COMMENT '现病史',
    past_history TEXT COMMENT '既往史',
    personal_history TEXT COMMENT '个人史',
    menstrual_history TEXT COMMENT '月经史',
    marriage_history TEXT COMMENT '婚育史',
    family_history TEXT COMMENT '家族史',
    allergy_history TEXT COMMENT '过敏史',
    vaccination_history TEXT COMMENT '接种史',
    physical_examination TEXT COMMENT '体格检查',
    auxiliary_examination TEXT COMMENT '辅助检查',
    specialist_examination TEXT COMMENT '专科检查',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (patient_id) REFERENCES patient_info(id),
    FOREIGN KEY (staff_id) REFERENCES staff_info(id)
) COMMENT '入院记录表';

-- 新增诊断表(diagnosis)
CREATE TABLE diagnosis (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    record_id BIGINT COMMENT '关联记录ID(可关联门诊记录或入院记录)',
    diagnosis_type VARCHAR(50) COMMENT '诊断类型(初步诊断/入院诊断/补充诊断/确诊诊断/其他诊断/鉴别诊断/门诊诊断)',
    diagnosis_item TEXT COMMENT '诊断项',
    is_main_diagnosis VARCHAR(5) COMMENT '主要诊断(是/否)',
    icd_code VARCHAR(50) COMMENT '诊断ICD编码',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '诊断表';

-- 新增中医诊断表(tcm_diagnosis)
CREATE TABLE tcm_diagnosis (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    record_id BIGINT COMMENT '关联记录ID(可关联门诊记录或入院记录)',
    diagnosis_type VARCHAR(50) COMMENT '诊断类型(初步诊断/入院诊断/补充诊断/确诊诊断/其他诊断/鉴别诊断)',
    is_main_diagnosis VARCHAR(5) COMMENT '主要诊断(是/否)',
    disease_name VARCHAR(100) COMMENT '中医疾病名称',
    disease_code VARCHAR(50) COMMENT '中医疾病代码',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) COMMENT '中医诊断表';

-- 新增中医证型表(tcm_syndrome)
CREATE TABLE tcm_syndrome (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键ID',
    tcm_diagnosis_id BIGINT COMMENT '关联中医诊断ID',
    syndrome_name VARCHAR(100) COMMENT '证型名称',
    syndrome_code VARCHAR(50) COMMENT '证型代码',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (tcm_diagnosis_id) REFERENCES tcm_diagnosis(id)
) COMMENT '中医证型表';