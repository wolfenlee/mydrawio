# 灵医智惠CDSS标准版API开发指南v2——LIS系统[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-lis/#cdssapiv2lis "Permanent link")

| 产品功能     | API             | method            |
| ------------ | --------------- | ----------------- |
| 检验项目质控 | 检验项目质控API | cdss-reminder-lis |
| 检验结果解读 | 检验结果解读API | cdss-analysis-lis |

## 患者数据规范[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-lis/#_1 "Permanent link")

```
{
"场景":["检验标本签收","检验报告审核","查看检验报告"],
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
"婚姻状态":"未婚/已婚/离异/丧偶"
},
"检验报告":[
{
"科室":"",// 检验科室
"检验报告ID":"",
"医嘱ID":"",// 医嘱申请单ID
"标本类型":"",// [必填] 标本类型，比如血清、尿等
"标本号":"",
"申请时间":"yyyy-MM-dd HH:mm:ss",
"预约时间":"yyyy-MM-dd HH:mm:ss",
"采样时间":"yyyy-MM-dd HH:mm:ss",// [必填] 检验采样时间
"收样时间":"yyyy-MM-dd HH:mm:ss",
"检验时间":"yyyy-MM-dd HH:mm:ss",
"报告时间":"yyyy-MM-dd HH:mm:ss",
"检验项目":"",// [必填] 检验项目（大项）
"检验结果":[
{
"检验指标项":"",// [必填] 检验指标项目（小项）
"检验指标缩写":"",
"结果":"",// [必填] 检验指标结果
"单位":"",// [必填] 检验指标结果单位
"结果提示":"",// [必填] 检验指标结果状态，枚举值：偏高(↑)、偏低(↓)、正常、异常
// 结果明确的填具体值，不明确留空
"最大值":"",// [必填] 检验指标最大值
"最小值":"",// [必填] 检验指标最小值
"正常值":""// [必填] 检验指标正常值
}
]
}
]
}
```

## 检验项目质控功能[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-lis/#_2 "Permanent link")

### 检验项目质控API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-lis/#api "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-reminder-lis)"

```
> **[warning] 注意**
  >
  > 此处emr格式只有部分字段，仅用于示例，不是完整定义，emr的详细定义请严格遵守《患者数据规范》

  ```json
  {
    "method": "cdss-reminder-lis",
    "emr": {
      "场景": ["检验标本签收","检验报告审核","查看检验报告"],
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
      "检验报告": [
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
        "level": "notice/warning/error",  // 提醒级别
        "type": "检验",                    // 提醒类型
        "message": ""                     // 提醒详细内容
      }
    ]
  }
```

```


## 检验结果解读功能[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-lis/#_3 "Permanent link")

### 检验结果解读API[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-lis/#api_1 "Permanent link")

* API Protocol: `HTTP`
* HTTP Server: `http://01cdss.baidu.com`
* Request Path: `/cdss/standard/api/v2`
* Request Headers: `Authorization: 按照文档生成的签名` [《API接口认证指南》](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-auth/)
* Request Method: `POST`
* Content-Type: `application/json; charset=utf-8`
* Request Body

??? note "请点击箭头查看内容 (method = cdss-analysis-lis)"

```

> **[warning] 注意**
>
> 此处emr格式只有部分字段，仅用于示例，不是完整定义，emr的详细定义请严格遵守《患者数据规范》

```json
  {
    "method": "cdss-analysis-lis",
    "emr": {
      "场景": ["检验报告"],
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
      "检验报告": [
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
        "name": "白细胞计数",                // 检验指标项
        "message": "白细胞计数偏高，可能xxx"   // 解读结果
      }
    ]
  }
```

```


## 错误码定义[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-lis/#_4 "Permanent link")

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



## 注意事项[¶](https://01cdss.baidu.com/doc/cdss/standard/v2/develop/api/api-lis/#_5 "Permanent link")

> 1.code不为0时表示接口异常，对接时可做好日志记录，无需在系统中弹出错误信息，影响就诊流程。 2.调用CDSS系统时，无论是否请求成功，做好异常处理（设置请求超时时间，建议3秒），保证医院就诊业务正常运行。
```
