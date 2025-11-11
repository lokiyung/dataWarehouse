-- 陕西文旅集团新渠道电商项目 - 维度表设计

-- 1. 用户维度表
CREATE TABLE dim_user (
    user_id VARCHAR(50) PRIMARY KEY COMMENT '用户唯一标识',
    user_name VARCHAR(100) COMMENT '用户昵称',
    phone_number VARCHAR(20) COMMENT '手机号',
    registration_date DATETIME COMMENT '注册日期',
    registration_channel VARCHAR(20) COMMENT '注册渠道',
    user_level VARCHAR(20) COMMENT '用户等级',
    member_status VARCHAR(20) COMMENT '会员状态',
    last_login_date DATETIME COMMENT '最后登录日期',
    gender VARCHAR(10) COMMENT '性别',
    age_group VARCHAR(20) COMMENT '年龄组',
    city VARCHAR(50) COMMENT '城市',
    province VARCHAR(50) COMMENT '省份',
    active_status VARCHAR(20) COMMENT '活跃状态',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '用户维度表';

-- 2. 商品维度表
CREATE TABLE dim_product (
    product_id VARCHAR(50) PRIMARY KEY COMMENT '商品唯一标识',
    product_name VARCHAR(200) COMMENT '商品名称',
    product_code VARCHAR(50) COMMENT '商品编码',
    business_line_code VARCHAR(3) COMMENT '业务线编码',
    business_line_name VARCHAR(100) COMMENT '业务线名称',
    category_id VARCHAR(50) COMMENT '分类ID',
    category_name VARCHAR(100) COMMENT '分类名称',
    brand_id VARCHAR(50) COMMENT '品牌ID',
    brand_name VARCHAR(100) COMMENT '品牌名称',
    original_price DECIMAL(10,2) COMMENT '原价',
    cost_price DECIMAL(10,2) COMMENT '成本价',
    product_status VARCHAR(20) COMMENT '商品状态',
    launch_date DATE COMMENT '上架日期',
    weight DECIMAL(10,3) COMMENT '重量(kg)',
    package_size VARCHAR(100) COMMENT '包装尺寸',
    description TEXT COMMENT '商品描述',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '商品维度表';

-- 3. 渠道维度表
CREATE TABLE dim_channel (
    channel_id VARCHAR(2) PRIMARY KEY COMMENT '渠道编码',
    channel_name VARCHAR(100) COMMENT '渠道名称',
    channel_type VARCHAR(50) COMMENT '渠道类型',
    platform VARCHAR(50) COMMENT '所属平台',
    channel_manager VARCHAR(50) COMMENT '渠道负责人',
    start_date DATE COMMENT '启用日期',
    end_date DATE COMMENT '停用日期',
    status VARCHAR(20) COMMENT '状态',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '渠道维度表';

-- 4. 合作模式维度表
CREATE TABLE dim_coop_model (
    model_id VARCHAR(1) PRIMARY KEY COMMENT '合作模式编码',
    model_name VARCHAR(100) COMMENT '合作模式名称',
    description VARCHAR(200) COMMENT '合作模式描述',
    profit_ratio DECIMAL(5,2) COMMENT '默认利润率(%)',
    status VARCHAR(20) COMMENT '状态',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '合作模式维度表';

-- 5. 流量来源维度表
CREATE TABLE dim_traffic_source (
    source_id VARCHAR(2) PRIMARY KEY COMMENT '流量来源编码',
    source_name VARCHAR(100) COMMENT '流量来源名称',
    source_type VARCHAR(50) COMMENT '来源类型',
    description VARCHAR(200) COMMENT '描述',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '流量来源维度表';

-- 6. 订单类型维度表
CREATE TABLE dim_order_type (
    type_id VARCHAR(1) PRIMARY KEY COMMENT '订单类型编码',
    type_name VARCHAR(100) COMMENT '订单类型名称',
    description VARCHAR(200) COMMENT '描述',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '订单类型维度表';

-- 7. 营销活动维度表
CREATE TABLE dim_marketing_activity (
    activity_id VARCHAR(50) PRIMARY KEY COMMENT '活动ID',
    activity_name VARCHAR(200) COMMENT '活动名称',
    activity_type VARCHAR(100) COMMENT '活动类型',
    start_date DATETIME COMMENT '开始时间',
    end_date DATETIME COMMENT '结束时间',
    budget DECIMAL(12,2) COMMENT '活动预算',
    channel_ids VARCHAR(200) COMMENT '适用渠道',
    product_ids VARCHAR(500) COMMENT '适用商品',
    status VARCHAR(20) COMMENT '活动状态',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '营销活动维度表';

-- 8. 优惠券维度表
CREATE TABLE dim_coupon (
    coupon_id VARCHAR(50) PRIMARY KEY COMMENT '优惠券ID',
    coupon_code VARCHAR(50) COMMENT '优惠券编码',
    coupon_name VARCHAR(100) COMMENT '优惠券名称',
    coupon_type VARCHAR(50) COMMENT '优惠券类型',
    discount_value DECIMAL(10,2) COMMENT '优惠金额',
    min_spend DECIMAL(10,2) COMMENT '最低消费',
    start_date DATETIME COMMENT '有效期开始',
    end_date DATETIME COMMENT '有效期结束',
    usage_scope VARCHAR(100) COMMENT '使用范围',
    status VARCHAR(20) COMMENT '状态',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '优惠券维度表';

-- 9. 地区维度表
CREATE TABLE dim_region (
    region_id VARCHAR(20) PRIMARY KEY COMMENT '地区ID',
    province VARCHAR(50) COMMENT '省份',
    city VARCHAR(50) COMMENT '城市',
    district VARCHAR(50) COMMENT '区县',
    region_level VARCHAR(20) COMMENT '地区级别',
    zip_code VARCHAR(20) COMMENT '邮政编码',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '地区维度表';

-- 10. 仓库维度表
CREATE TABLE dim_warehouse (
    warehouse_id VARCHAR(50) PRIMARY KEY COMMENT '仓库ID',
    warehouse_name VARCHAR(100) COMMENT '仓库名称',
    location VARCHAR(200) COMMENT '仓库位置',
    manager VARCHAR(50) COMMENT '仓库负责人',
    capacity INT COMMENT '仓库容量',
    status VARCHAR(20) COMMENT '状态',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '仓库维度表';

-- 11. 供应商维度表
CREATE TABLE dim_supplier (
    supplier_id VARCHAR(50) PRIMARY KEY COMMENT '供应商ID',
    supplier_name VARCHAR(200) COMMENT '供应商名称',
    contact_person VARCHAR(50) COMMENT '联系人',
    contact_phone VARCHAR(20) COMMENT '联系电话',
    address VARCHAR(200) COMMENT '地址',
    business_scope VARCHAR(200) COMMENT '经营范围',
    cooperation_start_date DATE COMMENT '合作开始日期',
    supplier_level VARCHAR(20) COMMENT '供应商等级',
    status VARCHAR(20) COMMENT '状态',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '供应商维度表';

-- 12. 日期维度表
CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY COMMENT '日期ID',
    year INT COMMENT '年份',
    quarter INT COMMENT '季度',
    month INT COMMENT '月份',
    week INT COMMENT '周数',
    day INT COMMENT '日期',
    day_of_week INT COMMENT '星期几',
    is_weekend VARCHAR(1) COMMENT '是否周末',
    is_holiday VARCHAR(1) COMMENT '是否节假日',
    holiday_name VARCHAR(50) COMMENT '节假日名称',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间'
) COMMENT '日期维度表';