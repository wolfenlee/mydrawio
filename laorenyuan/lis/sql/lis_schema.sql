-- 工作人员表
CREATE TABLE staff (
    staff_id VARCHAR(36) PRIMARY KEY COMMENT '工作人员ID',
    hospital VARCHAR(100) NOT NULL COMMENT '医院名称',
    department VARCHAR(100) NOT NULL COMMENT '科室名称',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    account_id VARCHAR(50) NOT NULL UNIQUE COMMENT '账号ID',
    role VARCHAR(50) COMMENT '角色',
    title VARCHAR(50) COMMENT '职称',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT '工作人员信息表';

-- 患者信息表
CREATE TABLE patient (
    patient_id VARCHAR(36) PRIMARY KEY COMMENT '患者ID',
    visit_id VARCHAR(36) NOT NULL UNIQUE COMMENT '就诊ID',
    visit_type ENUM('门诊','住院','急诊','体检') NOT NULL COMMENT '就诊类型',
    age INT NOT NULL COMMENT '年龄',
    gender ENUM('男','女') NOT NULL COMMENT '性别',
    birthdate DATE COMMENT '出生日期',
    occupation VARCHAR(100) COMMENT '职业',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT '患者基本信息表';

-- 检验报告表
CREATE TABLE report (
    report_id VARCHAR(36) PRIMARY KEY COMMENT '报告ID',
    patient_id VARCHAR(36) NOT NULL COMMENT '患者ID',
    staff_id VARCHAR(36) NOT NULL COMMENT '检验人员ID',
    specimen_type VARCHAR(50) NOT NULL COMMENT '标本类型',
    specimen_no VARCHAR(50) UNIQUE COMMENT '标本号',
    sampling_time DATETIME NOT NULL COMMENT '采样时间',
    test_items VARCHAR(200) NOT NULL COMMENT '检验项目',
    report_status ENUM('待审核','已审核','已发布') DEFAULT '待审核',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
) COMMENT '检验报告主表';

-- 检验结果明细表
CREATE TABLE test_item (
    item_id VARCHAR(36) PRIMARY KEY,
    report_id VARCHAR(36) NOT NULL,
    item_name VARCHAR(100) NOT NULL COMMENT '检验指标项',
    abbreviation VARCHAR(20) COMMENT '指标缩写',
    result DECIMAL(10,2) NOT NULL COMMENT '检验结果',
    unit VARCHAR(20) NOT NULL COMMENT '单位',
    reference_range VARCHAR(50) NOT NULL COMMENT '正常值范围',
    abnormal_flag ENUM('正常','偏高(↑)','偏低(↓)') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (report_id) REFERENCES report(report_id)
) COMMENT '检验结果明细表';

-- 质控记录表
CREATE TABLE quality_control (
    qc_id VARCHAR(36) PRIMARY KEY,
    report_id VARCHAR(36) NOT NULL,
    qc_level ENUM('notice','warning','error') NOT NULL,
    qc_rules JSON NOT NULL COMMENT '质控规则',
    qc_result TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (report_id) REFERENCES report(report_id)
) COMMENT '质控记录表';

-- 报告解读记录表
CREATE TABLE report_analysis (
    analysis_id VARCHAR(36) PRIMARY KEY,
    report_id VARCHAR(36) NOT NULL,
    abnormal_items JSON NOT NULL COMMENT '异常指标',
    suggestions TEXT NOT NULL COMMENT '解读建议',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (report_id) REFERENCES report(report_id)
) COMMENT '报告解读记录表';

-- 操作审计表
CREATE TABLE audit_log (
    log_id VARCHAR(36) PRIMARY KEY,
    staff_id VARCHAR(36) NOT NULL,
    action_type ENUM('签收','审核','查看','修改') NOT NULL,
    target_id VARCHAR(36) NOT NULL COMMENT '操作对象ID',
    action_result ENUM('成功','失败') NOT NULL,
    error_code INT COMMENT '错误码',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
) COMMENT '系统操作日志表';

-- API请求记录表
CREATE TABLE api_request (
    request_id VARCHAR(36) PRIMARY KEY,
    api_method ENUM('cdss-reminder-lis','cdss-analysis-lis') NOT NULL,
    request_data JSON NOT NULL,
    response_data JSON NOT NULL,
    status_code INT NOT NULL,
    error_message TEXT,
    duration INT NOT NULL COMMENT '请求耗时(ms)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) COMMENT 'CDSS接口调用记录表';