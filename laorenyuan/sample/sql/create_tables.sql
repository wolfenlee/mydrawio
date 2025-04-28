-- 创建捐献者信息表
CREATE TABLE donor_info (
    donor_id VARCHAR(50) PRIMARY KEY COMMENT '捐献者唯一标识ID',
    name VARCHAR(100) NOT NULL COMMENT '捐献者姓名',
    age INT COMMENT '捐献者年龄',
    gender VARCHAR(10) COMMENT '性别',
    medical_history TEXT COMMENT '医疗病史记录',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 创建知情同意书表
CREATE TABLE consent_form (
    form_id VARCHAR(50) PRIMARY KEY COMMENT '同意书唯一标识ID',
    sample_id VARCHAR(50) NOT NULL COMMENT '关联样本ID',
    form_file LONGBLOB COMMENT '同意书文件内容',
    upload_date DATETIME NOT NULL COMMENT '上传日期',
    description TEXT COMMENT '描述信息',
    scan_status VARCHAR(20) COMMENT '扫描状态',
    verification_result BOOLEAN COMMENT '验证结果',
    form_type VARCHAR(50) COMMENT '同意书类型',
    signature_info JSON COMMENT '签名信息(JSON格式)',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 创建采集管分组表
CREATE TABLE collection_group (
    group_id VARCHAR(50) PRIMARY KEY COMMENT '分组唯一标识ID',
    group_name VARCHAR(100) NOT NULL COMMENT '分组名称',
    group_type VARCHAR(50) NOT NULL COMMENT '分组类型',
    tube_list JSON COMMENT '采集管列表(JSON格式)',
    group_status VARCHAR(20) NOT NULL COMMENT '分组状态',
    last_update_time DATETIME NOT NULL COMMENT '最后更新时间',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 创建采集流程表
CREATE TABLE collection_process (
    process_id VARCHAR(50) PRIMARY KEY COMMENT '流程唯一标识ID',
    sample_id VARCHAR(50) NOT NULL COMMENT '关联样本ID',
    status VARCHAR(20) NOT NULL COMMENT '流程状态',
    start_time DATETIME NOT NULL COMMENT '开始时间',
    end_time DATETIME COMMENT '结束时间',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 创建样本存储表
CREATE TABLE sample_storage (
    storage_id VARCHAR(50) PRIMARY KEY COMMENT '存储记录唯一标识ID',
    sample_id VARCHAR(50) NOT NULL COMMENT '关联样本ID',
    location VARCHAR(200) NOT NULL COMMENT '存储位置',
    status VARCHAR(20) NOT NULL COMMENT '存储状态',
    operation_log JSON COMMENT '操作日志(JSON格式)',
    outbound_type VARCHAR(20) COMMENT '出库类型',
    outbound_time DATETIME COMMENT '出库时间',
    outbound_operator VARCHAR(50) COMMENT '出库操作人',
    inbound_time DATETIME COMMENT '入库时间',
    inbound_operator VARCHAR(50) COMMENT '入库操作人',
    storage_status VARCHAR(20) NOT NULL COMMENT '存储状态',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 创建编码规则表
CREATE TABLE code_rule (
    rule_id VARCHAR(50) PRIMARY KEY COMMENT '规则唯一标识ID',
    prefix VARCHAR(50) NOT NULL COMMENT '编码前缀',
    format VARCHAR(200) NOT NULL COMMENT '编码格式',
    auto_numbering_rule VARCHAR(200) COMMENT '自动编号规则',
    desensitization_enabled BOOLEAN DEFAULT FALSE COMMENT '是否启用脱敏',
    rule_version VARCHAR(20) COMMENT '规则版本',
    effective_date DATETIME COMMENT '生效日期',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 创建数据脱敏规则表
CREATE TABLE desensitization_rule (
    rule_id VARCHAR(50) PRIMARY KEY COMMENT '脱敏规则唯一标识ID',
    code_rule_id VARCHAR(50) NOT NULL COMMENT '关联编码规则ID',
    field_name VARCHAR(100) NOT NULL COMMENT '字段名称',
    masking_type VARCHAR(50) NOT NULL COMMENT '脱敏类型',
    masking_pattern VARCHAR(200) NOT NULL COMMENT '脱敏模式',
    test_data TEXT COMMENT '测试数据',
    last_test_result BOOLEAN COMMENT '最后测试结果',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (code_rule_id) REFERENCES code_rule(rule_id)
);

-- 创建样本信息表（包含所有关联关系）
CREATE TABLE sample_info (
    sample_id VARCHAR(50) PRIMARY KEY COMMENT '样本唯一标识ID',
    sample_type VARCHAR(50) NOT NULL COMMENT '样本类型',
    sample_code VARCHAR(100) NOT NULL COMMENT '样本编码',
    donor_id VARCHAR(50) NOT NULL COMMENT '关联捐献者ID',
    consent_form_id VARCHAR(50) NOT NULL COMMENT '关联同意书ID',
    collection_group_id VARCHAR(50) NOT NULL COMMENT '关联采集组ID',
    code_rule_id VARCHAR(50) NOT NULL COMMENT '关联编码规则ID',
    basic_info JSON COMMENT '基本信息(JSON格式)',
    processing_status VARCHAR(20) NOT NULL COMMENT '处理状态',
    storage_info_id VARCHAR(50) COMMENT '关联存储信息ID',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (donor_id) REFERENCES donor_info(donor_id),
    FOREIGN KEY (consent_form_id) REFERENCES consent_form(form_id),
    FOREIGN KEY (collection_group_id) REFERENCES collection_group(group_id),
    FOREIGN KEY (code_rule_id) REFERENCES code_rule(rule_id),
    FOREIGN KEY (storage_info_id) REFERENCES sample_storage(storage_id)
);

-- 添加外键约束
ALTER TABLE consent_form
ADD CONSTRAINT fk_consent_form_sample
FOREIGN KEY (sample_id) REFERENCES sample_info(sample_id);

ALTER TABLE collection_process
ADD CONSTRAINT fk_collection_process_sample
FOREIGN KEY (sample_id) REFERENCES sample_info(sample_id);

ALTER TABLE sample_storage
ADD CONSTRAINT fk_sample_storage_sample
FOREIGN KEY (sample_id) REFERENCES sample_info(sample_id);