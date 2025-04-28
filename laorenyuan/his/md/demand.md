# 灵医智惠CDSS标准版API开发指南v2——HIS/EMR系统[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#cdssapiv2hisemr "Permanent link")

| 产品功能     | API                     | method               |
| ------------ | ----------------------- | -------------------- |
| 医嘱质控     | 医嘱质控API             | cdss-reminder-emr    |
|              | 强制通过理由提交API     | cdss-action-emr      |
| 疑似诊断推荐 | 疑似诊断推荐API         | cdss-diagnose        |
|              | 疑似诊断推荐理由详情API | cdss-detail-diagnose |
|              | 鉴别诊断推荐API         | cdss-ddx             |
| 治疗方案推荐 | 治疗方案推荐API         | cdss-treat           |
|              | 检查结果治疗方案推荐API | cdss-treat-ris       |
| 知识库       | 知识库检索API           | cdss-kb-search       |
|              | 知识库详情API           | cdss-kb-detail-new   |
| 相似病历     | 相似病历推荐API         | cdss-emr-similar     |
|              | 病历检索API             | cdss-emr-search      |
|              | 病历详情API             | cdss-detail-emr      |

## 患者数据规范[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_1 "Permanent link")

医嘱可以和门诊记录/入院记录支持同时提交，也支持分开提交。

### 门诊记录[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_2 "Permanent link")

```
{
"场景":["门诊记录"],
"trigger":"保存/提交/CDSS",// 触发CDSS的方式
//  1) 保存：点击保存时自动触发；
//  2) 提交：点击提交时自动触发；
//  3) CDSS：点击单独新增的CDSS按钮触发。
"工作人员信息":{
"医院":"",// [必填]医院名称
"科室":"",// [必填]科室名称
"姓名":"",// [必填]工作人员姓名
"账号ID":"",// [必填]医疗信息系统账号
"角色":"医生/护士/药师/等",
"职称":""
},
"患者信息":{
"就诊类型":"门诊/急诊/体检",// [必填]
"就诊次数":"",// "1":初诊，大于1表示复诊
"就诊ID":"",// [必填] 门诊号(一次就诊有唯一ID)
"患者ID":"",// [必填] (一个患者有唯一ID)
"年龄":"28岁",// [必填] xx岁/xx月/xx天/xx小时
"性别":"男/女",// [必填] 
"出生日期":"",// yyyy-MM-dd
"职业":"",
"民族":"",
"出生地":"",
"现住地":"",
"费用类型":"医保/商保/自费/公费/等",
"身高":"180cm",
"体重":"70kg",
"ABO血型":"A/B/AB/O",
"Rh血型":"阴/阳",
"婚姻状态":"未婚/已婚/离异/丧偶",
"特殊人群":[""],
"生理状态":"月经期/妊娠期/哺乳期/孕早期/孕中期/孕晚期/卵泡期/黄体期/排卵期"
},
"门诊记录":{
"是否复诊":"",//是/否
"科室":"",// 门诊科室
"记录ID":"",// 门诊记录ID
"记录内容":"",// 无结构化纯文本内容, 仅用于无法提供结构化数据的厂商使用
"记录时间":"yyyy-MM-dd HH:mm:ss",// 门诊记录书写时间
"就诊时间":"yyyy-MM-dd HH:mm:ss",// 患者就诊时间
"怀孕状态":"未孕/已孕/已育",
"主诉":"",
"现病史":"",
"既往史":"",
"个人史":"",
"月经史":"",
"婚育史":"",
"家族史":"",
"过敏史":"",
"接种史":"",
"体格检查":"",
"辅助检查":"",
"专科检查":"",
"嘱咐":"",// 医生对患者建议的注意事项
"诊断":[
{
"诊断类型":"初步诊断/补充诊断/确诊诊断/其他诊断/门诊诊断",
"诊断项":"",
"主要诊断":"是/否",
"诊断ICD编码":""
}
],
"中医诊断":[
{
"诊断类型":"初步诊断/补充诊断/确诊诊断/其他诊断/门诊诊断",
"主要诊断":"是/否",
"中医疾病":{
"名称":"",
"代码":""
},
"中医证型":[
{
"名称":"",
"代码":""
}
]
}
]
}
}
```

### 入院记录[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_3 "Permanent link")

```
{
"场景":["入院记录"],
"trigger":"保存/提交/CDSS",// 触发CDSS的方式
//  1) 保存：点击保存时自动触发；
//  2) 提交：点击提交时自动触发；
//  3) CDSS：点击单独新增的CDSS按钮触发。
"工作人员信息":{
"医院":"",// [必填]医院名称
"科室":"",// [必填]科室名称
"姓名":"",// [必填]工作人员姓名
"账号ID":"",// [必填]医疗信息系统账号
"角色":"医生/护士/药师/等",
"职称":""
},
"患者信息":{
"就诊类型":"住院",// [必填]
"就诊次数":"",// "1":初诊，大于1表示复诊
"就诊ID":"",// [必填] 住院号(一次就诊有唯一ID)
"患者ID":"",// [必填] (一个患者有唯一ID)
"年龄":"28岁",// [必填] xx岁/xx月/xx天/xx小时
"性别":"男/女",// [必填]
"出生日期":"",// yyyy-MM-dd
"职业":"",
"民族":"",
"出生地":"",
"现住地":"",
"费用类型":"医保/商保/自费/公费/等",
"身高":"180cm",
"体重":"70kg",
"ABO血型":"A/B/AB/O",
"Rh血型":"阴/阳",
"婚姻状态":"未婚/已婚/离异/丧偶",
"特殊人群":[""],
"生理状态":"月经期/妊娠期/哺乳期/孕早期/孕中期/孕晚期/卵泡期/黄体期/排卵期"
},
"入院记录":{
"科室":"",// 入院科室
"记录ID":"",// 入院记录ID
"记录内容":"",// 无结构化纯文本内容, 仅用于无法提供结构化数据的厂商使用
"记录时间":"yyyy-MM-dd HH:mm:ss",// 入院记录书写时间
"入院时间":"yyyy-MM-dd HH:mm:ss",// 患者入院时间
"怀孕状态":"未孕/已孕/已育",
"病史陈述者":"",
"主诉":"",
"现病史":"",
"既往史":"",
"个人史":"",
"月经史":"",
"婚育史":"",
"家族史":"",
"过敏史":"",
"接种史":"",
"体格检查":"",
"辅助检查":"",
"专科检查":"",
"诊断":[
{
"诊断类型":"初步诊断/入院诊断/补充诊断/确诊诊断/其他诊断/鉴别诊断",
"诊断项":"",
"主要诊断":"是/否",
"诊断ICD编码":""
}
],
"中医诊断":[
{
"诊断类型":"初步诊断/入院诊断/补充诊断/确诊诊断/其他诊断/鉴别诊断",
"主要诊断":"是/否",
"中医疾病":{
"名称":"",
"代码":""
},
"中医证型":[
{
"名称":"",
"代码":""
}
]
}
]
}
}
```

### 医嘱[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_4 "Permanent link")

```
{
"场景":["医嘱"],
"trigger":"保存/提交/CDSS",// 触发CDSS的方式
//  1) 保存：点击保存时自动触发；
//  2) 提交：点击提交时自动触发；
//  3) CDSS：点击单独新增的CDSS按钮触发。
"工作人员信息":{
"医院":"",// [必填]医院名称
"科室":"",// [必填]科室名称
"姓名":"",// [必填]工作人员姓名
"账号ID":"",// [必填]医疗信息系统账号
"角色":"医生/护士/药师/等",
"职称":""
},
"患者信息":{
"就诊类型":"门诊/住院/急诊/体检",// [必填]
"就诊次数":"",// "1":初诊，大于1表示复诊
"就诊ID":"",// [必填] 住院号 或者 门诊号(一次就诊有唯一ID)
"患者ID":"",// [必填] (一个患者有唯一ID)
"年龄":"28岁",// [必填] xx岁/xx月/xx天/xx小时
"性别":"男/女",// [必填] 
"出生日期":"",// yyyy-MM-dd
"职业":"",
"出生地":"",
"现住地":"",
"费用类型":"医保/商保/自费/公费/等",
"身高":"180cm",
"体重":"70kg",
"ABO血型":"A/B/AB/O",
"Rh血型":"阴/阳",
"婚姻状态":"未婚/已婚/离异/丧偶",
"特殊人群":[""],
"生理状态":"月经期/妊娠期/哺乳期/孕早期/孕中期/孕晚期/卵泡期/黄体期/排卵期"
},
"医嘱":[
{
"处方ID":"",// 处方号
"医嘱ID":"",// [必填] 医嘱项目的唯一ID，一个门诊处方下的药品之间医嘱ID不同，处方ID相同，请注意：医嘱ID是全局唯一的，不是医嘱项目院内编码
"医嘱分组":"",// 可以代表医嘱分组的信息即可，比如父医嘱名、父医嘱序号、父医嘱ID
"医嘱类型":"用药/检验/检查/诊疗/手术/护理/出院带药/材料",// [必填] 
"医嘱项目":"",// [必填] 
"长期或临时":"长期/临时",// [必填] 
"医嘱状态":"新开/执行/停止/取消",// [必填] 
"录入时间":"yyyy-MM-dd HH:mm:ss",// 医嘱开立时间
"审核时间":"yyyy-MM-dd HH:mm:ss",// 医嘱审核时间
"开始时间":"yyyy-MM-dd HH:mm:ss",// 医嘱下达的预期开始时间
"结束时间":"yyyy-MM-dd HH:mm:ss",// 医嘱下达的预期结束时间
"医嘱开立科室":"",
"医嘱开立者":"",
"医嘱审核科室":"",
"医嘱审核者":"",

//以下为检验医嘱独有字段
"标本":"",

// 以下为用药医嘱独有字段
"用药天数":"",
"药物商品名":"",// 医嘱类型=用药时 [必填]
"药物通用名":"",
"国药准字号":"",// 医嘱类型=用药时 [必填] 
"药物编码":"",
"药物类别":"电解质平衡调节药",
"药物剂型":"注射剂/片剂/胶囊剂/丸剂/散剂/气雾剂/等",// 医嘱类型=用药时 [必填]
"用药途径":"口服/皮下注射/肌肉注射/静脉注射/外用/雾化吸入/等",// 医嘱类型=用药时 [必填]
"使用频率":"",// 医嘱类型=用药时 [必填]
"单次剂量":"",// 医嘱类型=用药时 [必填]
"总剂量":"",// 医嘱类型=用药时 [必填]
"剂量单位":"",// 医嘱类型=用药时 [必填]
// 皮试医嘱有2种常见方式: 1)用药医嘱之外单独开一项皮试医嘱；2)开用药医嘱，标记"需要皮试"，护士做完皮试后填写"皮试结果"
"需要皮试":"是/否",

// 以下为护理医嘱、诊疗医嘱独有字段
"执行频率":"",
"护理级别":"",

// 以下为检查医嘱、检验医嘱独有字段
"报告ID":"",// 检验报告ID或者检查报告ID

// 以下为手术医嘱独有字段
"麻醉方式":"",

// 以下为检查
"检查部位":["胸部","腹部"],
"检查方法":["平扫","正位"]
}
]
}
```

## 医嘱质控功能[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_5 "Permanent link")

### 医嘱质控API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api "Permanent link")

Warning

01cdss.baidu.com仅用于开发、测试和联调，禁止用于真实线上/线下诊疗服务。
临床真实环境请使用医院内网私有化部署的正式服务。

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-reminder-emr)"

```
> **[warning] 注意**
  >
  > 此处emr格式只有部分字段，仅用于示例，不是完整定义，emr的详细定义请严格遵守《患者数据规范》中的医嘱

  ```json
  {
    "method": "cdss-reminder-emr",
    "emr": {
      "场景": ["医嘱"],
      "trigger": "保存/提交/CDSS",
      "工作人员信息": {
        "医院": "",
        "科室": "",
        ...   // 完整定义请严格遵守《患者数据规范》
      },
      "患者信息": {
        "就诊类型": "门诊/住院/急诊/体检",
        "就诊ID": "",
        "患者ID": "",
        "年龄": "28岁",
        "性别": "男/女",
        ...   // 完整定义请严格遵守《患者数据规范》
      },
      "医嘱": [
        {
          ...   // 完整定义请严格遵守《患者数据规范》
        }
      ]
    }
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "level": "notice/warning/error",  //提醒级别
        "type": "文书/用药/检验/检查/手术/用血/治疗/血液透析/护理",  // 提醒类型
        "message": "提醒详细内容"
      }
    ]
  }
```

```


### 强制通过理由提交API

Warning

01cdss.baidu.com仅用于开发、测试和联调，禁止用于真实线上/线下诊疗服务。
临床真实环境请使用医院内网私有化部署的正式服务。


* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-action-emr)"

```

> **[warning] 注意**
>
> 此处emr格式只有部分字段，仅用于示例，不是完整定义，emr的详细定义请严格遵守《患者数据规范》中的医嘱

```json
  {
    "method": "cdss-action-emr",
    "params": [{
        "pid": "",            //患者id
        "rid": "",            //就诊id
        "advice_id": "",      //医嘱id
        "type": "",           //质控点类型
        "subtype": "",        //质控点子类型
        "level": "",  
        "message": "",        //质控提醒
        "pass_reason": ""     //通过理由
    }],
    "emr": {
        "工作人员信息": {
        "医院": "",
        "科室": "",
        ...   // 完整定义请严格遵守《患者数据规范》
      },
      "患者信息": {
        "就诊类型": "门诊/住院/急诊/体检",
        "就诊ID": "",
        "患者ID": "",
        "年龄": "28岁",
        "性别": "男/女",
        ...   // 完整定义请严格遵守《患者数据规范》
      }
    }
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,   
    "message": "",
  }
```

```


## 疑似诊断推荐功能[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_6 "Permanent link")

### 疑似诊断推荐API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_1 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-diagnose)"

```

> **[warning] 注意**
>
> 此处emr格式只有部分字段，仅用于示例，不是完整定义，emr的详细定义请严格遵守《患者数据规范》中的门诊记录或入院记录

```json
  {
    "method": "cdss-diagnose",
    "emr": {
      "场景": ["门诊记录/入院记录"],
      "trigger": "保存/提交/CDSS",
      "工作人员信息": {
        "医院": "",
        "科室": "",
        ...   // 完整定义请严格遵守《患者数据规范》
      },
      "患者信息": {
        "就诊类型": "门诊/住院/急诊/体检",
        "就诊ID": "",
        "患者ID": "",
        "年龄": "28岁",
        "性别": "男/女",
        ...   // 完整定义请严格遵守《患者数据规范》
      },
      "门诊记录": {
        ...   // 完整定义请严格遵守《患者数据规范》
      },
      "入院记录": {
        ...   // 完整定义请严格遵守《患者数据规范》
      }
    }
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "kgid": "013",         // CDSS内部诊断id，用于请求治疗方案推荐和鉴别诊断推荐API
        "name": "支气管哮喘",    // 诊断疾病名
        "tag": [""],           // 诊断标签：甲类传染病、甲类传染病、乙类传染病、待查
        "selected": 1,         // 勾选状态
                               // 0: 未勾选
                               // 1: 勾选，医生写的诊断默认处于勾选状态
        "hospital_code": "",   // 医院诊断编码，完成术语对照后才会返回该字段
        "detail": 1,           // 1: 该诊断有知识库详情数据，可通过kgid请求“知识库详情API”
                               // 0: 该诊断没有知识库详情数据
        "expand": 1,           // 1: 该诊断有疑似诊断推荐理由数据，可通过kgid请求“疑似诊断推荐理由API”
                               // 0: 该诊断没有疑似诊断推荐理由数据
      }
    ]
  }
```

```


### 疑似诊断推荐理由详情API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_2 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-detail-diagnose)"

```

```json
  {
    "method": "cdss-detail-diagnose",
    "emr": {},   // emr可选，格式同疑似诊断推荐API
                 // 传入emr可以支持诊断理由高亮
                 // 不传emr字段无法高亮与患者病历内容匹配的诊断理由
    "id": ["疑似诊断推荐API结果中的kgid"]
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "fields": ["症状", "体征", "诱因", "检查", "检验", "家族史", "个人史", "病史"],       // fields中字段是动态展现的，并不是所有诊断的推荐理由都有上述字段
        "症状": [
          {
            "name": "",
            "highlight": 1      // 高亮标记，代表患者病历中有该症状
          }
        ],
        "体征": [
          {
            "name": "",
            "highlight": 1
          }
        ],
        "诱因": [
          {
            "name": "",
            "highlight": 1
          }
        ],
        "检查": [
          {
            "name": "",
            "highlight": 1
          }
        ],
        "检验": [
          {
            "name": "",
            "highlight": 1
          }
        ],
        "家族史": [
          {
            "name": "",
            "highlight": 1
            }
        ],
        "个人史": [
          {
            "name": "",
            "highlight": 1
          }
        ]
      }
    ]
  }
```

```


### 鉴别诊断推荐API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_3 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-ddx)"

```

```json
  {
    "method": "cdss-ddx",
    "id": ["疑似诊断推荐API结果中的kgid"], // 医生已下达诊断时id字段可省略，将医生下达的诊断放在"emr"中即可
    "emr": {}   // emr格式同疑似诊断推荐API
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "诊断": "支气管哮喘",            // request中id对应的诊断名称
        "鉴别诊断": [
          {
            "name": "",               // 鉴别诊断名称
            "kgid": "",               // CDSS内部鉴别诊断id
            "reason": "",             // 推荐理由
            "hospital_code": ""       // 医院鉴别诊断编码
          }
        ]
      }
    ]
  }
```

```


## 治疗方案推荐功能[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_7 "Permanent link")

### 西医治疗方案推荐API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_4 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-treat)"

```

```json
  {
    "method": "cdss-treat",
    "id": ["疑似诊断推荐API结果中的kgid"], // 医生已下达诊断时id字段可省略，将医生下达的诊断放在"emr"中即可
    "emr": {}   // emr格式同疑似诊断推荐API
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "fields": ["检查", "检验", "药物", "手术", "量表"],   // 推荐类型有序列表
        "检查": [
          {
            "name": "",               // 检查项目名称
            "kgid": "",               // CDSS内部检查项目id
            "type": "检查",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "selected": 0,            // 勾选状态
            "hospital_code": ""       // 医院检查项目编码
          }
        ],
        "检验": [
          {
            "name": "",               // 检验项目名称
            "kgid": "",               // CDSS内部检验项目id
            "type": "检验",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "selected": 0,            // 勾选状态
            "hospital_code": ""       // 医院检验项目编码
          }
        ],
        "药物": [
          {
            "name": "",               // 药物名称
            "kgid": "",               // CDSS内部药物id
            "type": "药物",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "selected": 0,            // 勾选状态
            "hospital_code": ""       // 医院药物编码
          }
        ],
        "手术": [
          {
            "name": "",               // 手术名称
            "kgid": "",               // CDSS内部手术id
            "type": "手术",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "selected": 0,            // 勾选状态
            "hospital_code": ""       // 医院手术编码
          }
        ],
        "量表": [
          {
            "name": "",               // 量表名称
            "kgid": "",               // CDSS内部量表id
            "type": "检查",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "table_url": ""           // 量表网页地址
          }
        ]
      }
    ]
  }
```

```


### 检查结果治疗方案推荐API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_5 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-treat-ris)"

```

```json
  {
    "method": "cdss-treat-ris",
    "emr": {
      "场景": ["检查报告"],
      "trigger": "保存/提交/CDSS",
      "工作人员信息": {
        "医院": "",
        "科室": "",
        ...   // 完整定义请严格遵守《患者数据规范》
      },
      "患者信息": {
        "就诊类型": "住院",
        "就诊ID": "",
        "患者ID": "",
        "年龄": "28岁",
        "性别": "男/女",
        ...   // 完整定义请严格遵守《患者数据规范》
      },
      "检查报告": [
        {
          ...   // 完整定义请严格遵守《患者数据规范》
        }
      ]
    }
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "fields": ["检查", "检验", "药物", "手术", "量表"],   // 推荐类型有序列表
        "检查": [
          {
            "name": "",               // 检查项目名称
            "kgid": "",               // CDSS内部检查项目id
            "type": "检查",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "selected": 0,            // 勾选状态
            "hospital_code": ""       // 医院检查项目编码
          }
        ],
        "检验": [
          {
            "name": "",               // 检验项目名称
            "kgid": "",               // CDSS内部检验项目id
            "type": "检验",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "selected": 0,            // 勾选状态
            "hospital_code": ""       // 医院检验项目编码
          }
        ],
        "药物": [
          {
            "name": "",               // 药物名称
            "kgid": "",               // CDSS内部药物id
            "type": "药物",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "selected": 0,            // 勾选状态
            "hospital_code": ""       // 医院药物编码
          }
        ],
        "手术": [
          {
            "name": "",               // 手术名称
            "kgid": "",               // CDSS内部手术id
            "type": "手术",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "selected": 0,            // 勾选状态
            "hospital_code": ""       // 医院手术编码
          }
        ],
        "量表": [
          {
            "name": "",               // 量表名称
            "kgid": "",               // CDSS内部量表id
            "type": "检查",            // 推荐类型，冗余字段
            "reason": "",             // 推荐理由
            "table_url": ""           // 量表网页地址
          }
        ]
      }
    ]
  }
```

```


### 中医治疗方案推荐API

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-tcm)"

```

```json
  {
    "method": "cdss-tcm",
    "emr": {}                  // emr格式同疑似诊断推荐API
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
        {
            "doctor_diagnose" : {  
                "diagonsis":[
                    {
                        "诊断类型": "初步诊断/入院诊断/补充诊断/确诊诊断/其他诊断",
                        "诊断项": "",                             // 原始诊断文本
                        "主要诊断": "是/否"
                    }
                ],
                "tcm_diagonsis":[
                    {
                        "诊断类型": "初步诊断/入院诊断/补充诊断/确诊诊断/其他诊断/鉴别诊断",
                        "主要诊断": "是/否",                      // 其他诊断按照诊断先后顺序1、2、3显示
                        "中医疾病" : {                            // 病和证是一体的,一个病可以有多个证，一个证可以对应多个病
                            "名称": "",
                            "代码": ""
                        },
                        "中医证型": [
                          {
                            "名称": "",
                            "代码": ""
                          }
                        ]
                    }
                ]
            },
            "tcm_treatment": {                                 //中医治疗方案推荐
                "field":["辨证论治", "特色疗法", "护理调摄"],
                "辨证论治":[{                                   //可能有多个，但是治法一定相同
                    "治法": [],
                    "方药": [
                        {
                            "name": "",                        // 方剂名称
                            "expand": 1,
                            "details": [
                                {
                                    "medicine":{
                                        "name":"",             // 中药名
                                        "hospital_id":"",
                                        "hospital_code":"",    //本地化字段
                                        "kgid":""
                                    },
                                    "value":"",                // 数量
                                    "unit":"",                 // 单位
                                    "decoction":{
                                        "name":"",             // 煎制法
                                        "hospital_id":"",
                                        "hospital_code":"",    //本地化字段
                                        "kgid":""
                                    }
                                }
                            ]
                         },
                        {}
                     ]
                }],
                "特色疗法":[
                    {
                        "name":"",
                        "reason": ""
                    }
                ],
                "护理调摄": ""
            }
        }
    ]
}
```

```


## 知识库功能[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_8 "Permanent link")

### 知识库检索API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_6 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-kb-search)"

```

```json
  {
    "method": "cdss-kb-search",
    "query": "gxy",
    "params": [
      {
        "type": ["疾病", "药品", "检查", "检验", "手术", "量表"]
      }
    ]
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "name": "高血压",
        "type": "疾病",
        "id": "疾病ID"
      },
      {
        "name": "阿司匹林",
        "type": "药品",
        "id": "药品ID"
      },
      {
        "name": "",
        "type": "量表",
        "id": "量表ID",
        "url": "量表网页地址"
      }
    ]
  }
```

```


### 知识库详情API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_7 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-kb-detail-new)"

```

```json
  {
    "method": "cdss-kb-detail-new",
    // id来源1: 知识库检索API结果中的id
    // id来源2: 治疗方案推荐API结果中的检查/检验/手术的kgid
    // id来源3: 疑似诊断推荐API结果中的疾病的kgid
    "id": [""]
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "name": "高血压",
        "type": "疾病",
        "url": "疾病知识网页地址"
      },
      {
        "name": "阿司匹林",
        "type": "药品",
        "url": "药品说明书网页地址"
      }
    ]
  }
```

```


### 药品说明书API（通过国药准字号获取药品说明书）[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_8 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-kb-detail-cfda)"

```

```json

  {
    "method": "cdss-kb-detail-cfda",
    "cfdaid": "国药准字号"
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "name": "阿司匹林",
        "type": "药品",
        "url": "药品说明书网页地址"
      }
    ]
  }
```

```


## 相似病历功能[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_9 "Permanent link")

### 相似病历推荐API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_9 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-emr-similar)"

```

```json
  {
    "method": "cdss-emr-similar",
    "emr": {},              // emr格式请严格遵守《患者数据规范》中的门诊记录或入院记录
    "params": [
      {
        "page": 1,          // 翻页参数，第几页
        "pageSize": 10      // 翻页参数，每页结果数量
      }
    ]
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "id": "00003",
        "date": "2018-01-12",
        "诊疗类型": "门诊/住院",
        "年龄": "67岁",
        "性别": "男",
        "科室": "呼吸内科",
        "fields": [       // 展现字段有序列表，根据病历类型动态调整
          "主诉",
          "现病史",
          "初步诊断/入院诊断/确诊诊断/出院诊断"
        ],
        "主诉": "",
        "现病史": "",
        "出院诊断": "",
        "检索诊断": ""      // 最后确诊的主要诊断，可以用作标题展现
      }
    ],
    "extra": {
      "totalNum": 100       // 符合条件的病历结果总数，用于计算翻页总页数
    }
  }
```

```


### 病历检索API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_10 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-emr-search)"

```

```json
  {
    "method": "cdss-emr-search",
    "query": "咳嗽，胸闷3个月",
    "params": [
      {
        "page": 1,          // 翻页参数，第几页
        "pageSize": 10,     // 翻页参数，每页结果数量
        "date": ["2015-01-01", "2018-12-01"],   // 指定时间范围检索病历
        "age": ["20", "50"],    // 指定年龄范围检索病历
        "department": "呼吸内科",   // 指定科室检索病历
        "sex": "女"   // 指定性别检索病历
      }
    ]
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "id": "00003",
        "date": "2018-01-12",
        "cdr_url": "",
        "诊疗类型": "门诊/住院",
        "年龄": "67岁",
        "性别": "男",
        "科室": "呼吸内科",
        "fields": [       // 展现字段有序列表，根据病历类型动态调整
          "主诉",
          "现病史"
        ],
        "主诉": "",
        "现病史": "",
        "检索诊断": ""      // 最后确诊的主要诊断，可以用作标题展现
      }
    ],
    "extra": {
      "totalNum": 100       // 符合条件的病历结果总数，用于计算翻页总页数
    }
  }
```

```


### 病历详情API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#api_11 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-detail-emr)"

```

```json
  {
    "method": "cdss-detail-emr",
    "id": ["相似病历推荐API和病历检索API结果中的id"]
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,
    "message": "",
    "result": [
      {
        "id": "00003",
        "诊疗类型": "门诊/住院",
        "年龄": "67岁",
        "性别": "男",
        "科室": "呼吸内科",
        "emr": [
          {
            "type": "入院记录",
            "date": "2018-01-12",
            "fields": [     // 展现字段有序列表，根据病历类型动态调整
              "主诉",
              "现病史",
              "体格检查"
            ],
            "主诉": "",
            "现病史": "",
            "体格检查": ""
          }
        ]
      }
    ]
  }
```

```


## 伴随症状API

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = symptom-generate)"

```

```json
  {
    "method": "symptom-generate",  
    "query": "",                     //[必填]入参
    "sex": "男/女",                  //性别
    "age": "18岁",                   //年龄  
    "dep": ""                        //科室
  }
```

```


* Response

??? note "请点击箭头查看内容"

```

```json
  {
    "code": 0,  
    "message": "symptom_generate-success", 
    "result": [                            //结果
        "头晕",
        "咽痛",
        "腹痛",
        "呕吐",
        "恶心",
        "咳痰",
        "发热",
        "腹泻",
        "流涕",
        "咳嗽",
        ... ...
    ]
  }
```

```


## 错误码定义[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_10 "Permanent link")

| code  | 错误类别 | 含义                                 |
| ------- | ---------- | -------------------------------------- |
| 0     | 正常     | 正常                                 |
| 1xxxx | 语法错误 | 请求URI错误、参数缺失、参数格式错误  |
| 2xxxx | 权限错误 | 鉴权失败、流量超过限制等             |
| 3xxxx | 网络错误 | 某个网络服务出现连接失败、请求超时等 |
| 4xxxx | 内部错误 | 内部异常、数据异常等                 |



| code  | 含义                                            |
| ------- | ------------------------------------------------- |
| 0     | 正常（返回结果可能为空）                        |
| 10100 | method不存在                                    |
| 10200 | 请求参数异常，请仔细对照文档检查请求数据格式    |
| 20100 | license过期，请联系灵医智惠CDSS商务人员重新申请 |
| 20200 | 权限异常，无权访问该资源                        |
| 20300 | 异常流量                                        |
| 30100 | 服务连接异常，一般是某个依赖服务连接失败        |
| 30200 | 服务超时，请重试或者减少单次检索的数据量        |
| 40100 | 服务数据异常，内部错误                          |
| 40200 | 代码抛异常                                      |
| 40300 | 未知异常                                        |
| 40400 | 初始化异常，启动失败                            |
| 40500 | 配置异常，请检查配置文件                        |
| 40600 | 不支持的资源                                    |



## 注意事项[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-his/#_11 "Permanent link")

> 1.code不为0时表示接口异常，对接时可做好日志记录，无需在系统中弹出错误信息，影响就诊流程。 2.调用CDSS系统时，无论是否请求成功，做好异常处理（设置请求超时时间，建议3秒），保证医院就诊业务正常运行。
```
