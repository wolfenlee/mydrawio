-- 创建捐献者信息表
CREATE TABLE donor_info (
    donor_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    medical_history TEXT,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建知情同意书表
CREATE TABLE consent_form (
    form_id VARCHAR(50) PRIMARY KEY,
    sample_id VARCHAR(50) NOT NULL,
    form_file LONGBLOB,
    upload_date DATETIME NOT NULL,
    description TEXT,
    scan_status VARCHAR(20),
    verification_result BOOLEAN,
    form_type VARCHAR(50),
    signature_info JSON,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建采集管分组表
CREATE TABLE collection_group (
    group_id VARCHAR(50) PRIMARY KEY,
    group_name VARCHAR(100) NOT NULL,
    group_type VARCHAR(50) NOT NULL,
    tube_list JSON,
    group_status VARCHAR(20) NOT NULL,
    last_update_time DATETIME NOT NULL,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建采集流程表
CREATE TABLE collection_process (
    process_id VARCHAR(50) PRIMARY KEY,
    sample_id VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建样本存储表
CREATE TABLE sample_storage (
    storage_id VARCHAR(50) PRIMARY KEY,
    sample_id VARCHAR(50) NOT NULL,
    location VARCHAR(200) NOT NULL,
    status VARCHAR(20) NOT NULL,
    operation_log JSON,
    outbound_type VARCHAR(20),
    outbound_time DATETIME,
    outbound_operator VARCHAR(50),
    inbound_time DATETIME,
    inbound_operator VARCHAR(50),
    storage_status VARCHAR(20) NOT NULL,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建编码规则表
CREATE TABLE code_rule (
    rule_id VARCHAR(50) PRIMARY KEY,
    prefix VARCHAR(50) NOT NULL,
    format VARCHAR(200) NOT NULL,
    auto_numbering_rule VARCHAR(200),
    desensitization_enabled BOOLEAN DEFAULT FALSE,
    rule_version VARCHAR(20),
    effective_date DATETIME,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建数据脱敏规则表
CREATE TABLE desensitization_rule (
    rule_id VARCHAR(50) PRIMARY KEY,
    code_rule_id VARCHAR(50) NOT NULL,
    field_name VARCHAR(100) NOT NULL,
    masking_type VARCHAR(50) NOT NULL,
    masking_pattern VARCHAR(200) NOT NULL,
    test_data TEXT,
    last_test_result BOOLEAN,
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (code_rule_id) REFERENCES code_rule(rule_id)
);

-- 创建样本信息表（包含所有关联关系）
CREATE TABLE sample_info (
    sample_id VARCHAR(50) PRIMARY KEY,
    sample_type VARCHAR(50) NOT NULL,
    sample_code VARCHAR(100) NOT NULL,
    donor_id VARCHAR(50) NOT NULL,
    consent_form_id VARCHAR(50) NOT NULL,
    collection_group_id VARCHAR(50) NOT NULL,
    code_rule_id VARCHAR(50) NOT NULL,
    basic_info JSON,
    processing_status VARCHAR(20) NOT NULL,
    storage_info_id VARCHAR(50),
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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