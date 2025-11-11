-- 陕西文旅集团新渠道电商项目 - DWD层表设计
-- DWD层：数据仓库明细层，对ODS层数据进行清洗、整合，建立规范化关联

-- 设置分区格式
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

-- 1. 用户维度表 - DWD层
CREATE TABLE dwd.dim_user (
    user_id STRING COMMENT '用户唯一标识',
    user_name STRING COMMENT '用户昵称',
    phone_number STRING COMMENT '手机号',
    registration_date TIMESTAMP COMMENT '注册日期',
    registration_channel STRING COMMENT '注册渠道',
    user_level STRING COMMENT '用户等级',
    member_status STRING COMMENT '会员状态',
    last_login_date TIMESTAMP COMMENT '最后登录日期',
    gender STRING COMMENT '性别',
    age_group STRING COMMENT '年龄组',
    city STRING COMMENT '城市',
    province STRING COMMENT '省份',
    active_status STRING COMMENT '活跃状态',
    avatar_url STRING COMMENT '头像URL',
    device_info STRING COMMENT '设备信息',
    app_version STRING COMMENT 'APP版本',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '用户维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_user';

-- 2. 商品维度表 - DWD层
CREATE TABLE dwd.dim_product (
    product_id STRING COMMENT '商品唯一标识',
    product_name STRING COMMENT '商品名称',
    product_code STRING COMMENT '商品编码',
    business_line_code STRING COMMENT '业务线编码',
    business_line_name STRING COMMENT '业务线名称',
    category_id STRING COMMENT '分类ID',
    category_name STRING COMMENT '分类名称',
    brand_id STRING COMMENT '品牌ID',
    brand_name STRING COMMENT '品牌名称',
    original_price DECIMAL(10,2) COMMENT '原价',
    cost_price DECIMAL(10,2) COMMENT '成本价',
    product_status STRING COMMENT '商品状态',
    launch_date STRING COMMENT '上架日期',
    weight DECIMAL(10,3) COMMENT '重量(kg)',
    package_size STRING COMMENT '包装尺寸',
    description STRING COMMENT '商品描述',
    main_image_url STRING COMMENT '主图URL',
    sales_count INT COMMENT '销量',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '商品维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_product';

-- 3. 渠道维度表 - DWD层
CREATE TABLE dwd.dim_channel (
    channel_id STRING COMMENT '渠道编码',
    channel_name STRING COMMENT '渠道名称',
    channel_type STRING COMMENT '渠道类型',
    platform STRING COMMENT '所属平台',
    channel_manager STRING COMMENT '渠道负责人',
    start_date STRING COMMENT '启用日期',
    end_date STRING COMMENT '停用日期',
    status STRING COMMENT '状态',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '渠道维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_channel';

-- 4. 合作模式维度表 - DWD层
CREATE TABLE dwd.dim_coop_model (
    model_id STRING COMMENT '合作模式编码',
    model_name STRING COMMENT '合作模式名称',
    description STRING COMMENT '合作模式描述',
    profit_ratio DECIMAL(5,2) COMMENT '默认利润率(%)',
    status STRING COMMENT '状态',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '合作模式维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_coop_model';

-- 5. 流量来源维度表 - DWD层
CREATE TABLE dwd.dim_traffic_source (
    source_id STRING COMMENT '流量来源编码',
    source_name STRING COMMENT '流量来源名称',
    source_type STRING COMMENT '来源类型',
    description STRING COMMENT '描述',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '流量来源维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_traffic_source';

-- 6. 订单类型维度表 - DWD层
CREATE TABLE dwd.dim_order_type (
    type_id STRING COMMENT '订单类型编码',
    type_name STRING COMMENT '订单类型名称',
    description STRING COMMENT '描述',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '订单类型维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_order_type';

-- 7. 营销活动维度表 - DWD层
CREATE TABLE dwd.dim_marketing_activity (
    activity_id STRING COMMENT '活动ID',
    activity_name STRING COMMENT '活动名称',
    activity_type STRING COMMENT '活动类型',
    start_date TIMESTAMP COMMENT '开始时间',
    end_date TIMESTAMP COMMENT '结束时间',
    budget DECIMAL(12,2) COMMENT '活动预算',
    channel_ids STRING COMMENT '适用渠道',
    product_ids STRING COMMENT '适用商品',
    status STRING COMMENT '活动状态',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '营销活动维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_marketing_activity';

-- 8. 优惠券维度表 - DWD层
CREATE TABLE dwd.dim_coupon (
    coupon_id STRING COMMENT '优惠券ID',
    coupon_code STRING COMMENT '优惠券编码',
    coupon_name STRING COMMENT '优惠券名称',
    coupon_type STRING COMMENT '优惠券类型',
    discount_value DECIMAL(10,2) COMMENT '优惠金额',
    min_spend DECIMAL(10,2) COMMENT '最低消费',
    start_date TIMESTAMP COMMENT '有效期开始',
    end_date TIMESTAMP COMMENT '有效期结束',
    usage_scope STRING COMMENT '使用范围',
    status STRING COMMENT '状态',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '优惠券维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_coupon';

-- 9. 地区维度表 - DWD层
CREATE TABLE dwd.dim_region (
    region_id STRING COMMENT '地区ID',
    province STRING COMMENT '省份',
    city STRING COMMENT '城市',
    district STRING COMMENT '区县',
    region_level STRING COMMENT '地区级别',
    zip_code STRING COMMENT '邮政编码',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '地区维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_region';

-- 10. 仓库维度表 - DWD层
CREATE TABLE dwd.dim_warehouse (
    warehouse_id STRING COMMENT '仓库ID',
    warehouse_name STRING COMMENT '仓库名称',
    location STRING COMMENT '仓库位置',
    manager STRING COMMENT '仓库负责人',
    capacity INT COMMENT '仓库容量',
    status STRING COMMENT '状态',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '仓库维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_warehouse';

-- 11. 供应商维度表 - DWD层
CREATE TABLE dwd.dim_supplier (
    supplier_id STRING COMMENT '供应商ID',
    supplier_name STRING COMMENT '供应商名称',
    contact_person STRING COMMENT '联系人',
    contact_phone STRING COMMENT '联系电话',
    address STRING COMMENT '地址',
    business_scope STRING COMMENT '经营范围',
    cooperation_start_date STRING COMMENT '合作开始日期',
    supplier_level STRING COMMENT '供应商等级',
    status STRING COMMENT '状态',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '供应商维度表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/dim_supplier';

-- 12. 日期维度表 - DWD层
CREATE TABLE dwd.dim_date (
    date_id STRING COMMENT '日期ID',
    year INT COMMENT '年份',
    quarter INT COMMENT '季度',
    month INT COMMENT '月份',
    week INT COMMENT '周数',
    day INT COMMENT '日期',
    day_of_week INT COMMENT '星期几',
    is_weekend STRING COMMENT '是否周末',
    is_holiday STRING COMMENT '是否节假日',
    holiday_name STRING COMMENT '节假日名称',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间'
) 
COMMENT '日期维度表(DWD)' 
STORED AS PARQUET
LOCATION '/warehouse/dwd/dim_date';

-- 13. 流量与访客行为事实表 - DWD层
CREATE TABLE dwd.fact_page_view_log (
    log_id STRING COMMENT '日志ID',
    date_id STRING COMMENT '日期维度ID',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
    source_id STRING COMMENT '流量来源ID',
    page_url STRING COMMENT '页面URL',
    page_title STRING COMMENT '页面标题',
    page_type STRING COMMENT '页面类型',
    stay_duration INT COMMENT '停留时长(秒)',
    device_type STRING COMMENT '设备类型',
    ip_address STRING COMMENT 'IP地址',
    region_id STRING COMMENT '地区ID',
    session_id STRING COMMENT '会话ID',
    entry_page STRING COMMENT '入口页面',
    exit_page STRING COMMENT '退出页面',
    view_count INT COMMENT '浏览次数',
    create_time TIMESTAMP COMMENT '创建时间',
    browser STRING COMMENT '浏览器',
    os STRING COMMENT '操作系统',
    network_type STRING COMMENT '网络类型',
    -- UBI编码
    ubi_code STRING COMMENT '业务统一标识编码',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区',
    hour STRING COMMENT '小时分区'
) 
COMMENT '流量与访客行为事实表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt, hour)
LOCATION '/warehouse/dwd/fact_page_view_log';

-- 14. 用户互动事实表 - DWD层
CREATE TABLE dwd.fact_user_action_log (
    action_id STRING COMMENT '行为ID',
    date_id STRING COMMENT '日期维度ID',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
    action_type STRING COMMENT '行为类型',
    action_detail STRING COMMENT '行为详情',
    action_time TIMESTAMP COMMENT '行为时间',
    device_type STRING COMMENT '设备类型',
    ip_address STRING COMMENT 'IP地址',
    session_id STRING COMMENT '会话ID',
    related_id STRING COMMENT '相关ID',
    -- UBI编码
    ubi_code STRING COMMENT '业务统一标识编码',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '用户互动事实表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/fact_user_action_log';

-- 15. 订单事实明细表 - DWD层
CREATE TABLE dwd.fact_order_detail (
    order_item_id STRING COMMENT '订单项ID',
    order_id STRING COMMENT '订单ID',
    date_id STRING COMMENT '日期维度ID',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
    activity_id STRING COMMENT '营销活动ID',
    coupon_id STRING COMMENT '优惠券ID',
    region_id STRING COMMENT '地区ID',
    warehouse_id STRING COMMENT '仓库ID',
    supplier_id STRING COMMENT '供应商ID',
    business_line_code STRING COMMENT '业务线编码',
    model_id STRING COMMENT '合作模式ID',
    source_id STRING COMMENT '流量来源ID',
    type_id STRING COMMENT '订单类型ID',
    order_time TIMESTAMP COMMENT '下单时间',
    payment_time TIMESTAMP COMMENT '支付时间',
    delivery_time TIMESTAMP COMMENT '发货时间',
    receipt_time TIMESTAMP COMMENT '收货时间',
    order_status STRING COMMENT '订单状态',
    quantity INT COMMENT '数量',
    unit_price DECIMAL(10,2) COMMENT '单价',
    original_amount DECIMAL(10,2) COMMENT '原始金额',
    discount_amount DECIMAL(10,2) COMMENT '优惠金额',
    actual_amount DECIMAL(10,2) COMMENT '实际金额',
    cost_amount DECIMAL(10,2) COMMENT '成本金额',
    profit_amount DECIMAL(10,2) COMMENT '利润金额',
    shipping_fee DECIMAL(10,2) COMMENT '运费',
    tracking_number STRING COMMENT '物流单号',
    payment_method STRING COMMENT '支付方式',
    transaction_id STRING COMMENT '交易ID',
    delivery_address STRING COMMENT '收货地址',
    delivery_person STRING COMMENT '收货人',
    delivery_phone STRING COMMENT '收货电话',
    -- UBI编码
    ubi_code STRING COMMENT '业务统一标识编码',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '订单事实明细表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/fact_order_detail';

-- 16. 支付事实明细表 - DWD层
CREATE TABLE dwd.fact_payment_detail (
    payment_id STRING COMMENT '支付ID',
    order_id STRING COMMENT '订单ID',
    date_id STRING COMMENT '日期维度ID',
    user_id STRING COMMENT '用户ID',
    channel_id STRING COMMENT '渠道ID',
    region_id STRING COMMENT '地区ID',
    payment_time TIMESTAMP COMMENT '支付时间',
    payment_method STRING COMMENT '支付方式',
    transaction_id STRING COMMENT '交易流水号',
    payment_amount DECIMAL(10,2) COMMENT '支付金额',
    currency STRING COMMENT '货币类型',
    payment_status STRING COMMENT '支付状态',
    refund_amount DECIMAL(10,2) COMMENT '退款金额',
    payment_success_flag STRING COMMENT '支付成功标志',
    payment_gateway STRING COMMENT '支付网关',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '支付事实明细表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/fact_payment_detail';

-- 17. 物流事实明细表 - DWD层
CREATE TABLE dwd.fact_logistics_detail (
    logistics_id STRING COMMENT '物流ID',
    order_id STRING COMMENT '订单ID',
    order_item_id STRING COMMENT '订单项ID',
    date_id STRING COMMENT '日期维度ID',
    product_id STRING COMMENT '商品ID',
    warehouse_id STRING COMMENT '仓库ID',
    region_id STRING COMMENT '地区ID',
    shipping_time TIMESTAMP COMMENT '发货时间',
    receipt_time TIMESTAMP COMMENT '收货时间',
    logistics_company STRING COMMENT '物流公司',
    tracking_number STRING COMMENT '物流单号',
    logistics_status STRING COMMENT '物流状态',
    quantity INT COMMENT '数量',
    shipping_fee DECIMAL(10,2) COMMENT '运费',
    delivery_address STRING COMMENT '收货地址',
    delivery_person STRING COMMENT '收货人',
    delivery_phone STRING COMMENT '收货电话',
    sender_address STRING COMMENT '发货地址',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '物流事实明细表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/fact_logistics_detail';

-- 18. 营销活动事实表 - DWD层
CREATE TABLE dwd.fact_marketing_activity (
    activity_log_id STRING COMMENT '活动日志ID',
    date_id STRING COMMENT '日期维度ID',
    activity_id STRING COMMENT '营销活动ID',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
    supplier_id STRING COMMENT '供应商ID',
    event_time TIMESTAMP COMMENT '事件时间',
    event_type STRING COMMENT '事件类型',
    click_count INT COMMENT '点击次数',
    exposure_count INT COMMENT '曝光次数',
    conversion_count INT COMMENT '转化次数',
    order_amount DECIMAL(12,2) COMMENT '订单金额',
    cost_amount DECIMAL(12,2) COMMENT '投入成本',
    roi DECIMAL(10,4) COMMENT '投资回报率',
    campaign_id STRING COMMENT '推广活动ID',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '营销活动事实表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/fact_marketing_activity';

-- 19. 库存事实表 - DWD层
CREATE TABLE dwd.fact_inventory (
    inventory_id STRING COMMENT '库存ID',
    date_id STRING COMMENT '日期维度ID',
    product_id STRING COMMENT '商品ID',
    warehouse_id STRING COMMENT '仓库ID',
    supplier_id STRING COMMENT '供应商ID',
    business_date STRING COMMENT '业务日期',
    opening_stock INT COMMENT '期初库存',
    inbound_quantity INT COMMENT '入库数量',
    outbound_quantity INT COMMENT '出库数量',
    adjustment_quantity INT COMMENT '调整数量',
    closing_stock INT COMMENT '期末库存',
    unit_cost DECIMAL(10,2) COMMENT '单位成本',
    total_cost DECIMAL(12,2) COMMENT '总成本',
    safety_stock INT COMMENT '安全库存',
    stock_status STRING COMMENT '库存状态',
    inventory_type STRING COMMENT '库存类型',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '库存事实表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/fact_inventory';

-- 20. 用户会员事实表 - DWD层
CREATE TABLE dwd.fact_user_membership (
    membership_id STRING COMMENT '会员记录ID',
    date_id STRING COMMENT '日期维度ID',
    user_id STRING COMMENT '用户ID',
    member_level STRING COMMENT '会员等级',
    membership_status STRING COMMENT '会员状态',
    points_balance INT COMMENT '积分余额',
    points_earned INT COMMENT '新增积分',
    points_used INT COMMENT '使用积分',
    total_spend DECIMAL(12,2) COMMENT '累计消费',
    membership_start_date TIMESTAMP COMMENT '会员开始日期',
    membership_end_date TIMESTAMP COMMENT '会员结束日期',
    last_update_time TIMESTAMP COMMENT '最后更新时间',
    -- 元数据字段
    etl_create_time TIMESTAMP COMMENT 'ETL创建时间',
    etl_update_time TIMESTAMP COMMENT 'ETL更新时间',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '用户会员事实表(DWD)' 
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/dwd/fact_user_membership';