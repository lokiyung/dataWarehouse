# 陕西文旅集团新渠道电商项目 - 数据仓库设计

## 项目概述
本文档定义了陕西文旅集团新渠道电商项目的数据仓库模型，基于项目介绍中的业务需求和核心业务矩阵设计。该数据仓库旨在支持多渠道电商业务的数据分析、报表生成和业务决策。

## 数据仓库架构

### 设计原则
- **星型模型设计**：围绕核心业务过程构建事实表，关联多个维度表
- **一致性维度**：确保各事实表使用统一的维度表，保证数据一致性
- **可扩展性**：预留扩展字段，支持业务未来发展需求
- **性能优化**：通过合理的索引设计和分区策略优化查询性能

### 表结构组织

#### 1. 维度表（Dim Tables）
维度表存储业务分析的角度，包含描述性信息。本项目设计了以下维度表：

| 表名 | 描述 | 主要关键字段 |
|------|------|------------|
| dim_user | 用户维度 | user_id, user_name, registration_channel, user_level |
| dim_product | 商品维度 | product_id, product_name, business_line_code, category_id |
| dim_channel | 渠道维度 | channel_id, channel_name, platform |
| dim_coop_model | 合作模式维度 | model_id, model_name, profit_ratio |
| dim_traffic_source | 流量来源维度 | source_id, source_name, source_type |
| dim_order_type | 订单类型维度 | type_id, type_name |
| dim_marketing_activity | 营销活动维度 | activity_id, activity_name, activity_type |
| dim_coupon | 优惠券维度 | coupon_id, coupon_name, coupon_type |
| dim_region | 地区维度 | region_id, province, city, district |
| dim_warehouse | 仓库维度 | warehouse_id, warehouse_name, location |
| dim_supplier | 供应商维度 | supplier_id, supplier_name, business_scope |
| dim_date | 日期维度 | date_id, year, quarter, month, is_holiday |

#### 2. 事实表（Fact Tables）
事实表存储业务过程的度量值和关联维度的外键。本项目设计了以下事实表：

| 表名 | 描述 | 关联维度 | 核心度量指标 |
|------|------|---------|------------|
| fact_page_view_log | 流量与访客行为 | date, user, product, channel, traffic_source, region | 浏览次数, 停留时长 |
| fact_user_action_log | 用户互动 | date, user, product, channel | 行为类型, 行为次数 |
| fact_order_detail | 订单明细 | date, user, product, channel, marketing_activity, coupon, region, warehouse, supplier, coop_model, traffic_source, order_type | 订单金额, 数量, 利润 |
| fact_payment_detail | 支付明细 | date, user, channel, region | 支付金额, 退款金额 |
| fact_logistics_detail | 物流明细 | date, product, warehouse, region | 发货时间, 收货时间 |
| fact_marketing_activity | 营销活动效果 | date, activity, user, product, channel, supplier | 点击量, 曝光量, 转化率, ROI |
| fact_inventory | 库存变动 | date, product, warehouse, supplier | 期初/期末库存, 入库/出库数量 |
| fact_user_membership | 会员数据 | date, user | 积分余额, 累计消费 |

## 核心业务数据流程

### 1. 数据采集层
- **多渠道数据源**：抖音、微信小程序、微信视频号、淘宝天猫、线下系统
- **数据类型**：用户行为日志、订单数据、支付数据、物流数据、商品数据
- **采集方式**：API接口对接、日志文件采集、数据库同步

### 2. 数据处理层
- **ETL流程**：
  - 抽取（Extract）：从各源系统获取数据
  - 转换（Transform）：数据清洗、标准化、维度关联
  - 加载（Load）：将处理后的数据加载到数据仓库
- **数据质量控制**：完整性检查、一致性校验、异常值处理

### 3. 数据存储层
- **维度表更新**：定期全量/增量更新
- **事实表更新**：实时/准实时增量更新
- **历史数据处理**：数据分区、数据归档策略

### 4. 数据应用层
- **报表体系**：销售报表、用户报表、营销报表、库存报表
- **分析主题**：渠道分析、用户分析、商品分析、营销效果分析
- **数据指标**：GMV、订单量、客单价、转化率、复购率、毛利率

## UBI编码规则实现

UBI（Universal Business Identifier）编码是项目中的核心业务标识，格式为：业务线-渠道-合作模式-流量来源-订单类型

在数据仓库中，通过以下方式实现UBI的生成和使用：

1. 各维度表中存储对应的编码：
   - 业务线：dim_product.business_line_code
   - 渠道：dim_channel.channel_id
   - 合作模式：dim_coop_model.model_id
   - 流量来源：dim_traffic_source.source_id
   - 订单类型：dim_order_type.type_id

2. 在fact_order_detail事实表中关联这些维度，并可通过视图或计算列生成完整UBI编码

## 表关系图

```
+----------------+     +----------------+     +----------------+
|    维度表      |     |    事实表      |     |    维度表      |
|                |     |                |     |                |
|  dim_date      |-----|  fact_*_detail |-----|  dim_product   |
|  dim_user      |-----|                |-----|  dim_channel   |
|  dim_region    |-----|                |-----|  dim_supplier  |
|  dim_warehouse |-----|                |-----|  其他维度表... |
+----------------+     +----------------+     +----------------+
```

## 使用说明

1. **建表顺序**：先创建维度表，再创建事实表（由于外键约束）
2. **数据初始化**：
   - 先初始化维度表基础数据
   - 再导入历史事实数据
3. **日常维护**：
   - 每日增量更新事实表
   - 定期更新维度表
   - 执行数据质量检查

## 扩展建议

1. **实时数据需求**：可考虑引入流处理框架，实现准实时数据分析
2. **预测分析**：基于历史数据构建预测模型，支持销售预测、库存预警
3. **个性化推荐**：基于用户行为数据，构建商品推荐系统
4. **多维度分析**：扩展维度表，支持更细粒度的业务分析

## 注意事项

1. 所有表都包含etl_create_time和etl_update_time字段，用于数据血缘追踪和问题排查
2. 外键关系主要用于数据一致性约束，在实际大数据环境中可能需要调整为逻辑外键
3. 表结构设计应根据实际业务需求和数据量大小进行适当优化

---

**版本信息**：
- 版本：1.0
- 创建日期：2024年
- 设计人员：数据分析师（实习）
