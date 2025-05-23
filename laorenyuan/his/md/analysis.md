# CDSS医疗系统需求分析文档

## 1. 系统概述

CDSS(临床决策支持系统)标准版提供了一套完整的API接口，用于支持医疗机构的HIS/EMR系统集成。系统主要包含以下核心功能模块：

- 医嘱质控
- 疑似诊断推荐
- 治疗方案推荐
- 知识库管理
- 相似病历查询

## 2. 功能模块说明

### 2.1 医嘱质控

#### 2.1.1 功能描述
- 对医生开具的医嘱进行实时质控
- 支持强制通过并记录理由
- 包含用药、检验、检查、手术等多种医嘱类型的质控

#### 2.1.2 API接口
- 医嘱质控API (cdss-reminder-emr)
- 强制通过理由提交API (cdss-action-emr)

#### 2.1.3 质控级别
- notice: 提醒
- warning: 警告
- error: 错误

### 2.2 疑似诊断推荐

#### 2.2.1 功能描述
- 基于患者症状和检查结果推荐可能的诊断
- 提供诊断推荐理由
- 支持鉴别诊断推荐

#### 2.2.2 API接口
- 疑似诊断推荐API (cdss-diagnose)
- 疑似诊断推荐理由详情API (cdss-detail-diagnose)
- 鉴别诊断推荐API (cdss-ddx)

### 2.3 治疗方案推荐

#### 2.3.1 功能描述
- 提供西医治疗方案推荐
- 提供中医治疗方案推荐
- 基于检查结果推荐治疗方案

#### 2.3.2 API接口
- 治疗方案推荐API (cdss-treat)
- 检查结果治疗方案推荐API (cdss-treat-ris)

#### 2.3.3 推荐内容
- 检查项目
- 检验项目
- 药物使用
- 手术方案
- 量表使用
- 中医治疗（含方药、特色疗法、护理调摄）

### 2.4 知识库管理

#### 2.4.1 功能描述
- 提供医学知识检索
- 支持查看详细知识内容
- 支持药品说明书查询

#### 2.4.2 API接口
- 知识库检索API (cdss-kb-search)
- 知识库详情API (cdss-kb-detail-new)

#### 2.4.3 知识类型
- 疾病
- 药品
- 检查
- 检验
- 手术
- 量表

### 2.5 相似病历查询

#### 2.5.1 功能描述
- 支持相似病历推荐
- 支持病历检索
- 提供病历详情查看

#### 2.5.2 API接口
- 相似病历推荐API (cdss-emr-similar)
- 病历检索API (cdss-emr-search)
- 病历详情API (cdss-detail-emr)

## 3. 数据规范

### 3.1 基础数据结构

#### 3.1.1 工作人员信息
- 医院名称（必填）
- 科室名称（必填）
- 工作人员姓名（必填）
- 账号ID（必填）
- 角色
- 职称

#### 3.1.2 患者基本信息
- 就诊类型（必填）：门诊/住院/急诊/体检
- 就诊ID（必填）
- 患者ID（必填）
- 年龄（必填）
- 性别（必填）
- 出生日期
- 身高体重
- 血型信息
- 婚姻状态
- 特殊人群标识
- 生理状态

### 3.2 医疗记录数据

#### 3.2.1 门诊记录
- 基本就诊信息
- 主诉
- 现病史
- 既往史
- 个人史
- 体格检查
- 诊断信息

#### 3.2.2 住院记录
- 入院信息
- 病史记录
- 体格检查
- 诊断信息
- 治疗计划

#### 3.2.3 医嘱信息
- 医嘱类型：用药/检验/检查/诊疗/手术/护理等
- 执行状态
- 时间信息
- 具体医嘱内容

## 4. 系统集成建议

### 4.1 触发方式
系统支持三种触发方式：
1. 保存触发：点击保存时自动触发
2. 提交触发：点击提交时自动触发
3. 手动触发：点击CDSS按钮触发

### 4.2 数据同步
- 医嘱可以和门诊记录/入院记录同时提交
- 也支持分开提交处理

### 4.3 接口认证
所有API请求需要进行签名认证，详细认证方式参考API接口认证指南

### 4.4 错误处理
系统统一使用code和message返回处理结果：
- code=0 表示成功
- code≠0 表示失败，具体错误信息在message中说明

## 5. 注意事项

1. 所有时间格式统一使用：yyyy-MM-dd HH:mm:ss
2. 必填字段必须严格按照规范提供
3. 编码使用UTF-8字符集
4. API调用需要进行签名认证
5. 建议在测试环境充分测试后再上线