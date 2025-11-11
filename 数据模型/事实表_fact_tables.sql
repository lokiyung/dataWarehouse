-- 陕西文旅集团新渠道电商项目 - 事实表设计

-- 1. 流量与访客行为事实表
CREATE TABLE fact_page_view_log (
    log_id VARCHAR(50) PRIMARY KEY COMMENT '日志ID',
    date_id DATE COMMENT '日期维度ID',
    user_id VARCHAR(50) COMMENT '用户ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    source_id VARCHAR(2) COMMENT '流量来源ID',
    page_url VARCHAR(500) COMMENT '页面URL',
    page_title VARCHAR(200) COMMENT '页面标题',
    page_type VARCHAR(50) COMMENT '页面类型',
    stay_duration INT COMMENT '停留时长(秒)',
    device_type VARCHAR(50) COMMENT '设备类型',
    ip_address VARCHAR(50) COMMENT 'IP地址',
    region_id VARCHAR(20) COMMENT '地区ID',
    session_id VARCHAR(100) COMMENT '会话ID',
    entry_page VARCHAR(500) COMMENT '入口页面',
    exit_page VARCHAR(500) COMMENT '退出页面',
    view_count INT COMMENT '浏览次数',
    create_time DATETIME COMMENT '创建时间',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间',
    -- 外键关系
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id),
    FOREIGN KEY (source_id) REFERENCES dim_traffic_source(source_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id)
) COMMENT '流量与访客行为事实表';

-- 2. 用户互动事实表
CREATE TABLE fact_user_action_log (
    action_id VARCHAR(50) PRIMARY KEY COMMENT '行为ID',
    date_id DATE COMMENT '日期维度ID',
    user_id VARCHAR(50) COMMENT '用户ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    action_type VARCHAR(50) COMMENT '行为类型',
    action_detail VARCHAR(200) COMMENT '行为详情',
    action_time DATETIME COMMENT '行为时间',
    device_type VARCHAR(50) COMMENT '设备类型',
    ip_address VARCHAR(50) COMMENT 'IP地址',
    session_id VARCHAR(100) COMMENT '会话ID',
    related_id VARCHAR(50) COMMENT '相关ID',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间',
    -- 外键关系
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id)
) COMMENT '用户互动事实表';

-- 3. 订单事实明细表
CREATE TABLE fact_order_detail (
    order_item_id VARCHAR(50) PRIMARY KEY COMMENT '订单项ID',
    order_id VARCHAR(50) COMMENT '订单ID',
    date_id DATE COMMENT '日期维度ID',
    user_id VARCHAR(50) COMMENT '用户ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    activity_id VARCHAR(50) COMMENT '营销活动ID',
    coupon_id VARCHAR(50) COMMENT '优惠券ID',
    region_id VARCHAR(20) COMMENT '地区ID',
    warehouse_id VARCHAR(50) COMMENT '仓库ID',
    supplier_id VARCHAR(50) COMMENT '供应商ID',
    business_line_code VARCHAR(3) COMMENT '业务线编码',
    model_id VARCHAR(1) COMMENT '合作模式ID',
    source_id VARCHAR(2) COMMENT '流量来源ID',
    type_id VARCHAR(1) COMMENT '订单类型ID',
    order_time DATETIME COMMENT '下单时间',
    payment_time DATETIME COMMENT '支付时间',
    delivery_time DATETIME COMMENT '发货时间',
    receipt_time DATETIME COMMENT '收货时间',
    order_status VARCHAR(50) COMMENT '订单状态',
    quantity INT COMMENT '数量',
    unit_price DECIMAL(10,2) COMMENT '单价',
    original_amount DECIMAL(10,2) COMMENT '原始金额',
    discount_amount DECIMAL(10,2) COMMENT '优惠金额',
    actual_amount DECIMAL(10,2) COMMENT '实际金额',
    cost_amount DECIMAL(10,2) COMMENT '成本金额',
    profit_amount DECIMAL(10,2) COMMENT '利润金额',
    shipping_fee DECIMAL(10,2) COMMENT '运费',
    tracking_number VARCHAR(100) COMMENT '物流单号',
    payment_method VARCHAR(50) COMMENT '支付方式',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间',
    -- 外键关系
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id),
    FOREIGN KEY (activity_id) REFERENCES dim_marketing_activity(activity_id),
    FOREIGN KEY (coupon_id) REFERENCES dim_coupon(coupon_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id),
    FOREIGN KEY (warehouse_id) REFERENCES dim_warehouse(warehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES dim_supplier(supplier_id),
    FOREIGN KEY (model_id) REFERENCES dim_coop_model(model_id),
    FOREIGN KEY (source_id) REFERENCES dim_traffic_source(source_id),
    FOREIGN KEY (type_id) REFERENCES dim_order_type(type_id)
) COMMENT '订单事实明细表';

-- 4. 支付事实明细表
CREATE TABLE fact_payment_detail (
    payment_id VARCHAR(50) PRIMARY KEY COMMENT '支付ID',
    order_id VARCHAR(50) COMMENT '订单ID',
    date_id DATE COMMENT '日期维度ID',
    user_id VARCHAR(50) COMMENT '用户ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    region_id VARCHAR(20) COMMENT '地区ID',
    payment_time DATETIME COMMENT '支付时间',
    payment_method VARCHAR(50) COMMENT '支付方式',
    transaction_id VARCHAR(100) COMMENT '交易流水号',
    payment_amount DECIMAL(10,2) COMMENT '支付金额',
    currency VARCHAR(20) COMMENT '货币类型',
    payment_status VARCHAR(50) COMMENT '支付状态',
    refund_amount DECIMAL(10,2) COMMENT '退款金额',
    payment_success_flag VARCHAR(1) COMMENT '支付成功标志',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间',
    -- 外键关系
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id),
    FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id)
) COMMENT '支付事实明细表';

-- 5. 物流事实明细表
CREATE TABLE fact_logistics_detail (
    logistics_id VARCHAR(50) PRIMARY KEY COMMENT '物流ID',
    order_id VARCHAR(50) COMMENT '订单ID',
    order_item_id VARCHAR(50) COMMENT '订单项ID',
    date_id DATE COMMENT '日期维度ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    warehouse_id VARCHAR(50) COMMENT '仓库ID',
    region_id VARCHAR(20) COMMENT '地区ID',
    shipping_time DATETIME COMMENT '发货时间',
    receipt_time DATETIME COMMENT '收货时间',
    logistics_company VARCHAR(100) COMMENT '物流公司',
    tracking_number VARCHAR(100) COMMENT '物流单号',
    logistics_status VARCHAR(50) COMMENT '物流状态',
    quantity INT COMMENT '数量',
    shipping_fee DECIMAL(10,2) COMMENT '运费',
    delivery_address VARCHAR(300) COMMENT '收货地址',
    delivery_person VARCHAR(50) COMMENT '收货人',
    delivery_phone VARCHAR(20) COMMENT '收货电话',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间',
    -- 外键关系
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES dim_warehouse(warehouse_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id)
) COMMENT '物流事实明细表';

-- 6. 营销活动事实表
CREATE TABLE fact_marketing_activity (
    activity_log_id VARCHAR(50) PRIMARY KEY COMMENT '活动日志ID',
    date_id DATE COMMENT '日期维度ID',
    activity_id VARCHAR(50) COMMENT '营销活动ID',
    user_id VARCHAR(50) COMMENT '用户ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    supplier_id VARCHAR(50) COMMENT '供应商ID',
    event_time DATETIME COMMENT '事件时间',
    event_type VARCHAR(50) COMMENT '事件类型',
    click_count INT COMMENT '点击次数',
    exposure_count INT COMMENT '曝光次数',
    conversion_count INT COMMENT '转化次数',
    order_amount DECIMAL(12,2) COMMENT '订单金额',
    cost_amount DECIMAL(12,2) COMMENT '投入成本',
    roi DECIMAL(10,4) COMMENT '投资回报率',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间',
    -- 外键关系
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (activity_id) REFERENCES dim_marketing_activity(activity_id),
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id),
    FOREIGN KEY (supplier_id) REFERENCES dim_supplier(supplier_id)
) COMMENT '营销活动事实表';

-- 7. 库存事实表
CREATE TABLE fact_inventory (
    inventory_id VARCHAR(50) PRIMARY KEY COMMENT '库存ID',
    date_id DATE COMMENT '日期维度ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    warehouse_id VARCHAR(50) COMMENT '仓库ID',
    supplier_id VARCHAR(50) COMMENT '供应商ID',
    business_date DATE COMMENT '业务日期',
    opening_stock INT COMMENT '期初库存',
    inbound_quantity INT COMMENT '入库数量',
    outbound_quantity INT COMMENT '出库数量',
    adjustment_quantity INT COMMENT '调整数量',
    closing_stock INT COMMENT '期末库存',
    unit_cost DECIMAL(10,2) COMMENT '单位成本',
    total_cost DECIMAL(12,2) COMMENT '总成本',
    safety_stock INT COMMENT '安全库存',
    stock_status VARCHAR(50) COMMENT '库存状态',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间',
    -- 外键关系
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES dim_warehouse(warehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES dim_supplier(supplier_id)
) COMMENT '库存事实表';

-- 8. 用户会员事实表
CREATE TABLE fact_user_membership (
    membership_id VARCHAR(50) PRIMARY KEY COMMENT '会员记录ID',
    date_id DATE COMMENT '日期维度ID',
    user_id VARCHAR(50) COMMENT '用户ID',
    member_level VARCHAR(20) COMMENT '会员等级',
    membership_status VARCHAR(20) COMMENT '会员状态',
    points_balance INT COMMENT '积分余额',
    points_earned INT COMMENT '新增积分',
    points_used INT COMMENT '使用积分',
    total_spend DECIMAL(12,2) COMMENT '累计消费',
    membership_start_date DATETIME COMMENT '会员开始日期',
    membership_end_date DATETIME COMMENT '会员结束日期',
    last_update_time DATETIME COMMENT '最后更新时间',
    etl_create_time DATETIME COMMENT 'ETL创建时间',
    etl_update_time DATETIME COMMENT 'ETL更新时间',
    -- 外键关系
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (user_id) REFERENCES dim_user(user_id)
) COMMENT '用户会员事实表';