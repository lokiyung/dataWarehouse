-- 陕西文旅集团新渠道电商项目 - PostgreSQL业务数据库模型
-- 基于项目需求设计的业务数据库表结构

-- 创建schema（如果需要）
-- CREATE SCHEMA IF NOT EXISTS shanxi_travel_ecommerce;
-- SET search_path = shanxi_travel_ecommerce, public;

-- 1. 用户表
CREATE TABLE IF NOT EXISTS user_info (
    user_id VARCHAR(50) PRIMARY KEY COMMENT '用户唯一标识',
    user_name VARCHAR(100) COMMENT '用户昵称',
    phone_number VARCHAR(20) UNIQUE COMMENT '手机号',
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '注册日期',
    registration_channel VARCHAR(20) COMMENT '注册渠道',
    user_level VARCHAR(20) DEFAULT '普通用户' COMMENT '用户等级',
    member_status VARCHAR(20) DEFAULT '非会员' COMMENT '会员状态',
    last_login_date TIMESTAMP COMMENT '最后登录日期',
    gender VARCHAR(10) COMMENT '性别',
    age_group VARCHAR(20) COMMENT '年龄组',
    city VARCHAR(50) COMMENT '城市',
    province VARCHAR(50) COMMENT '省份',
    active_status VARCHAR(20) DEFAULT '活跃' COMMENT '活跃状态',
    avatar_url VARCHAR(255) COMMENT '头像URL',
    device_info TEXT COMMENT '设备信息',
    app_version VARCHAR(50) COMMENT 'APP版本',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 2. 商品表
CREATE TABLE IF NOT EXISTS product (
    product_id VARCHAR(50) PRIMARY KEY COMMENT '商品唯一标识',
    product_name VARCHAR(200) NOT NULL COMMENT '商品名称',
    product_code VARCHAR(50) UNIQUE NOT NULL COMMENT '商品编码',
    business_line_code VARCHAR(3) NOT NULL COMMENT '业务线编码',
    business_line_name VARCHAR(100) NOT NULL COMMENT '业务线名称',
    category_id VARCHAR(50) COMMENT '分类ID',
    category_name VARCHAR(100) COMMENT '分类名称',
    brand_id VARCHAR(50) COMMENT '品牌ID',
    brand_name VARCHAR(100) COMMENT '品牌名称',
    original_price DECIMAL(10,2) NOT NULL COMMENT '原价',
    cost_price DECIMAL(10,2) NOT NULL COMMENT '成本价',
    product_status VARCHAR(20) DEFAULT '下架' COMMENT '商品状态',
    launch_date DATE COMMENT '上架日期',
    weight DECIMAL(10,3) COMMENT '重量(kg)',
    package_size VARCHAR(100) COMMENT '包装尺寸',
    description TEXT COMMENT '商品描述',
    main_image_url VARCHAR(255) COMMENT '主图URL',
    image_urls TEXT COMMENT '图片URL列表，JSON格式',
    video_url VARCHAR(255) COMMENT '视频URL',
    sales_count INT DEFAULT 0 COMMENT '销量',
    product_details JSONB COMMENT '商品详情JSON',
    sku_info JSONB COMMENT 'SKU信息JSON',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 3. 渠道表
CREATE TABLE IF NOT EXISTS channel (
    channel_id VARCHAR(2) PRIMARY KEY COMMENT '渠道编码',
    channel_name VARCHAR(100) NOT NULL COMMENT '渠道名称',
    channel_type VARCHAR(50) COMMENT '渠道类型',
    platform VARCHAR(50) COMMENT '所属平台',
    channel_manager VARCHAR(50) COMMENT '渠道负责人',
    start_date DATE COMMENT '启用日期',
    end_date DATE COMMENT '停用日期',
    status VARCHAR(20) DEFAULT '启用' COMMENT '状态',
    api_endpoint VARCHAR(255) COMMENT 'API端点',
    channel_config JSONB COMMENT '渠道配置信息',
    channel_extend_info JSONB COMMENT '渠道扩展信息',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 4. 合作模式表
CREATE TABLE IF NOT EXISTS coop_model (
    model_id VARCHAR(1) PRIMARY KEY COMMENT '合作模式编码',
    model_name VARCHAR(100) NOT NULL COMMENT '合作模式名称',
    description VARCHAR(200) COMMENT '合作模式描述',
    profit_ratio DECIMAL(5,2) COMMENT '默认利润率(%)',
    status VARCHAR(20) DEFAULT '启用' COMMENT '状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 5. 流量来源表
CREATE TABLE IF NOT EXISTS traffic_source (
    source_id VARCHAR(2) PRIMARY KEY COMMENT '流量来源编码',
    source_name VARCHAR(100) NOT NULL COMMENT '流量来源名称',
    source_type VARCHAR(50) COMMENT '来源类型',
    description VARCHAR(200) COMMENT '描述',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 6. 订单类型表
CREATE TABLE IF NOT EXISTS order_type (
    type_id VARCHAR(1) PRIMARY KEY COMMENT '订单类型编码',
    type_name VARCHAR(100) NOT NULL COMMENT '订单类型名称',
    description VARCHAR(200) COMMENT '描述',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 7. 营销活动表
CREATE TABLE IF NOT EXISTS marketing_activity (
    activity_id VARCHAR(50) PRIMARY KEY COMMENT '活动ID',
    activity_name VARCHAR(200) NOT NULL COMMENT '活动名称',
    activity_type VARCHAR(100) COMMENT '活动类型',
    start_date TIMESTAMP NOT NULL COMMENT '开始时间',
    end_date TIMESTAMP NOT NULL COMMENT '结束时间',
    budget DECIMAL(12,2) DEFAULT 0 COMMENT '活动预算',
    channel_ids TEXT COMMENT '适用渠道，逗号分隔',
    product_ids TEXT COMMENT '适用商品，逗号分隔',
    status VARCHAR(20) DEFAULT '未开始' COMMENT '活动状态',
    activity_rules JSONB COMMENT '活动规则JSON',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 8. 优惠券表
CREATE TABLE IF NOT EXISTS coupon (
    coupon_id VARCHAR(50) PRIMARY KEY COMMENT '优惠券ID',
    coupon_code VARCHAR(50) UNIQUE NOT NULL COMMENT '优惠券编码',
    coupon_name VARCHAR(100) NOT NULL COMMENT '优惠券名称',
    coupon_type VARCHAR(50) COMMENT '优惠券类型',
    discount_value DECIMAL(10,2) NOT NULL COMMENT '优惠金额',
    min_spend DECIMAL(10,2) DEFAULT 0 COMMENT '最低消费',
    start_date TIMESTAMP NOT NULL COMMENT '有效期开始',
    end_date TIMESTAMP NOT NULL COMMENT '有效期结束',
    usage_scope VARCHAR(100) COMMENT '使用范围',
    status VARCHAR(20) DEFAULT '有效' COMMENT '状态',
    issue_count INT DEFAULT 0 COMMENT '发放数量',
    used_count INT DEFAULT 0 COMMENT '已使用数量',
    remaining_count INT DEFAULT 0 COMMENT '剩余数量',
    coupon_rules JSONB COMMENT '优惠券规则JSON',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 9. 地区表
CREATE TABLE IF NOT EXISTS region (
    region_id VARCHAR(20) PRIMARY KEY COMMENT '地区ID',
    province VARCHAR(50) NOT NULL COMMENT '省份',
    city VARCHAR(50) COMMENT '城市',
    district VARCHAR(50) COMMENT '区县',
    region_level VARCHAR(20) COMMENT '地区级别',
    zip_code VARCHAR(20) COMMENT '邮政编码',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 10. 仓库表
CREATE TABLE IF NOT EXISTS warehouse (
    warehouse_id VARCHAR(50) PRIMARY KEY COMMENT '仓库ID',
    warehouse_name VARCHAR(100) NOT NULL COMMENT '仓库名称',
    location VARCHAR(200) COMMENT '仓库位置',
    manager VARCHAR(50) COMMENT '仓库负责人',
    capacity INT COMMENT '仓库容量',
    status VARCHAR(20) DEFAULT '启用' COMMENT '状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 11. 供应商表
CREATE TABLE IF NOT EXISTS supplier (
    supplier_id VARCHAR(50) PRIMARY KEY COMMENT '供应商ID',
    supplier_name VARCHAR(200) NOT NULL COMMENT '供应商名称',
    contact_person VARCHAR(50) COMMENT '联系人',
    contact_phone VARCHAR(20) COMMENT '联系电话',
    address VARCHAR(200) COMMENT '地址',
    business_scope VARCHAR(200) COMMENT '经营范围',
    cooperation_start_date DATE COMMENT '合作开始日期',
    supplier_level VARCHAR(20) DEFAULT '普通' COMMENT '供应商等级',
    status VARCHAR(20) DEFAULT '合作中' COMMENT '状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- 12. 订单主表
CREATE TABLE IF NOT EXISTS order_main (
    order_id VARCHAR(50) PRIMARY KEY COMMENT '订单ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    channel_id VARCHAR(2) NOT NULL COMMENT '渠道ID',
    order_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
    payment_time TIMESTAMP COMMENT '支付时间',
    delivery_time TIMESTAMP COMMENT '发货时间',
    receipt_time TIMESTAMP COMMENT '收货时间',
    order_status VARCHAR(20) DEFAULT '待支付' COMMENT '订单状态',
    original_amount DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '原始金额',
    discount_amount DECIMAL(10,2) DEFAULT 0 COMMENT '优惠金额',
    actual_amount DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '实际金额',
    shipping_fee DECIMAL(10,2) DEFAULT 0 COMMENT '运费',
    tracking_number VARCHAR(100) COMMENT '物流单号',
    payment_method VARCHAR(50) COMMENT '支付方式',
    transaction_id VARCHAR(100) COMMENT '交易ID',
    delivery_address TEXT NOT NULL COMMENT '收货地址',
    delivery_person VARCHAR(50) NOT NULL COMMENT '收货人',
    delivery_phone VARCHAR(20) NOT NULL COMMENT '收货电话',
    business_line_code VARCHAR(3) COMMENT '业务线编码',
    model_id VARCHAR(1) COMMENT '合作模式ID',
    source_id VARCHAR(2) COMMENT '流量来源ID',
    type_id VARCHAR(1) COMMENT '订单类型ID',
    activity_id VARCHAR(50) COMMENT '营销活动ID',
    coupon_id VARCHAR(50) COMMENT '优惠券ID',
    warehouse_id VARCHAR(50) COMMENT '仓库ID',
    supplier_id VARCHAR(50) COMMENT '供应商ID',
    ubi_code VARCHAR(50) COMMENT '业务统一标识编码',
    remark TEXT COMMENT '备注',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (channel_id) REFERENCES channel(channel_id),
    FOREIGN KEY (model_id) REFERENCES coop_model(model_id),
    FOREIGN KEY (source_id) REFERENCES traffic_source(source_id),
    FOREIGN KEY (type_id) REFERENCES order_type(type_id),
    FOREIGN KEY (activity_id) REFERENCES marketing_activity(activity_id),
    FOREIGN KEY (coupon_id) REFERENCES coupon(coupon_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

-- 13. 订单项表
CREATE TABLE IF NOT EXISTS order_item (
    order_item_id VARCHAR(50) PRIMARY KEY COMMENT '订单项ID',
    order_id VARCHAR(50) NOT NULL COMMENT '订单ID',
    product_id VARCHAR(50) NOT NULL COMMENT '商品ID',
    quantity INT NOT NULL DEFAULT 1 COMMENT '数量',
    unit_price DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '单价',
    item_amount DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '商品金额',
    item_discount DECIMAL(10,2) DEFAULT 0 COMMENT '商品优惠',
    item_actual_amount DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '商品实际金额',
    product_name VARCHAR(200) NOT NULL COMMENT '商品名称',
    product_code VARCHAR(50) COMMENT '商品编码',
    sku_info JSONB COMMENT 'SKU信息',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (order_id) REFERENCES order_main(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 14. 支付记录表
CREATE TABLE IF NOT EXISTS payment_record (
    payment_id VARCHAR(50) PRIMARY KEY COMMENT '支付ID',
    order_id VARCHAR(50) NOT NULL COMMENT '订单ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    payment_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '支付时间',
    payment_method VARCHAR(50) NOT NULL COMMENT '支付方式',
    transaction_id VARCHAR(100) UNIQUE NOT NULL COMMENT '交易流水号',
    payment_amount DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '支付金额',
    currency VARCHAR(10) DEFAULT 'CNY' COMMENT '货币类型',
    payment_status VARCHAR(20) DEFAULT '支付中' COMMENT '支付状态',
    refund_amount DECIMAL(10,2) DEFAULT 0 COMMENT '退款金额',
    payment_gateway VARCHAR(50) COMMENT '支付网关',
    payment_ip VARCHAR(50) COMMENT '支付IP',
    terminal_info TEXT COMMENT '终端信息',
    payment_details JSONB COMMENT '支付详情',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (order_id) REFERENCES order_main(order_id),
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (channel_id) REFERENCES channel(channel_id)
);

-- 15. 物流信息表
CREATE TABLE IF NOT EXISTS logistics_info (
    logistics_id VARCHAR(50) PRIMARY KEY COMMENT '物流ID',
    order_id VARCHAR(50) NOT NULL COMMENT '订单ID',
    order_item_id VARCHAR(50) COMMENT '订单项ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    warehouse_id VARCHAR(50) COMMENT '仓库ID',
    shipping_time TIMESTAMP COMMENT '发货时间',
    receipt_time TIMESTAMP COMMENT '收货时间',
    logistics_company VARCHAR(100) COMMENT '物流公司',
    tracking_number VARCHAR(100) UNIQUE COMMENT '物流单号',
    logistics_status VARCHAR(20) DEFAULT '待发货' COMMENT '物流状态',
    quantity INT DEFAULT 1 COMMENT '数量',
    shipping_fee DECIMAL(10,2) DEFAULT 0 COMMENT '运费',
    delivery_address TEXT COMMENT '收货地址',
    delivery_person VARCHAR(50) COMMENT '收货人',
    delivery_phone VARCHAR(20) COMMENT '收货电话',
    sender_address TEXT COMMENT '发货地址',
    sender_person VARCHAR(50) COMMENT '发货人',
    sender_phone VARCHAR(20) COMMENT '发货电话',
    logistics_trace JSONB COMMENT '物流轨迹',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (order_id) REFERENCES order_main(order_id),
    FOREIGN KEY (order_item_id) REFERENCES order_item(order_item_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
);

-- 16. 用户行为日志表
CREATE TABLE IF NOT EXISTS user_behavior_log (
    log_id VARCHAR(50) PRIMARY KEY COMMENT '日志ID',
    user_id VARCHAR(50) COMMENT '用户ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    action_type VARCHAR(50) NOT NULL COMMENT '行为类型',
    action_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '行为时间',
    page_url TEXT COMMENT '页面URL',
    page_title VARCHAR(255) COMMENT '页面标题',
    page_type VARCHAR(50) COMMENT '页面类型',
    stay_duration INT COMMENT '停留时长(秒)',
    device_type VARCHAR(50) COMMENT '设备类型',
    ip_address VARCHAR(50) COMMENT 'IP地址',
    session_id VARCHAR(100) NOT NULL COMMENT '会话ID',
    browser VARCHAR(100) COMMENT '浏览器',
    os VARCHAR(100) COMMENT '操作系统',
    network_type VARCHAR(50) COMMENT '网络类型',
    screen_resolution VARCHAR(50) COMMENT '屏幕分辨率',
    source_id VARCHAR(2) COMMENT '流量来源ID',
    activity_id VARCHAR(50) COMMENT '活动ID',
    event_params JSONB COMMENT '事件参数',
    user_agent TEXT COMMENT '用户代理信息',
    ubi_code VARCHAR(50) COMMENT '业务统一标识编码',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    -- 外键约束
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (channel_id) REFERENCES channel(channel_id),
    FOREIGN KEY (source_id) REFERENCES traffic_source(source_id),
    FOREIGN KEY (activity_id) REFERENCES marketing_activity(activity_id)
);

-- 17. 库存表
CREATE TABLE IF NOT EXISTS inventory (
    inventory_id VARCHAR(50) PRIMARY KEY COMMENT '库存ID',
    product_id VARCHAR(50) NOT NULL COMMENT '商品ID',
    warehouse_id VARCHAR(50) NOT NULL COMMENT '仓库ID',
    supplier_id VARCHAR(50) COMMENT '供应商ID',
    current_stock INT NOT NULL DEFAULT 0 COMMENT '当前库存',
    safety_stock INT DEFAULT 0 COMMENT '安全库存',
    unit_cost DECIMAL(10,2) DEFAULT 0 COMMENT '单位成本',
    total_cost DECIMAL(12,2) DEFAULT 0 COMMENT '总成本',
    inventory_type VARCHAR(50) DEFAULT '普通库存' COMMENT '库存类型',
    lot_number VARCHAR(50) COMMENT '批次号',
    stock_status VARCHAR(20) DEFAULT '正常' COMMENT '库存状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

-- 18. 库存变动记录表
CREATE TABLE IF NOT EXISTS inventory_transaction (
    transaction_id VARCHAR(50) PRIMARY KEY COMMENT '交易ID',
    inventory_id VARCHAR(50) NOT NULL COMMENT '库存ID',
    product_id VARCHAR(50) NOT NULL COMMENT '商品ID',
    warehouse_id VARCHAR(50) NOT NULL COMMENT '仓库ID',
    transaction_type VARCHAR(50) NOT NULL COMMENT '交易类型',
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易时间',
    quantity INT NOT NULL COMMENT '变动数量',
    before_stock INT NOT NULL COMMENT '变动前库存',
    after_stock INT NOT NULL COMMENT '变动后库存',
    reference_id VARCHAR(50) COMMENT '关联ID',
    reference_type VARCHAR(50) COMMENT '关联类型',
    operator VARCHAR(50) COMMENT '操作人',
    remark TEXT COMMENT '备注',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    -- 外键约束
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
);

-- 19. 用户优惠券表
CREATE TABLE IF NOT EXISTS user_coupon (
    user_coupon_id VARCHAR(50) PRIMARY KEY COMMENT '用户优惠券ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    coupon_id VARCHAR(50) NOT NULL COMMENT '优惠券ID',
    receive_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
    use_time TIMESTAMP COMMENT '使用时间',
    order_id VARCHAR(50) COMMENT '使用订单ID',
    status VARCHAR(20) DEFAULT '未使用' COMMENT '状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (coupon_id) REFERENCES coupon(coupon_id),
    FOREIGN KEY (order_id) REFERENCES order_main(order_id)
);

-- 20. 营销活动参与记录表
CREATE TABLE IF NOT EXISTS marketing_activity_record (
    record_id VARCHAR(50) PRIMARY KEY COMMENT '记录ID',
    activity_id VARCHAR(50) NOT NULL COMMENT '活动ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    product_id VARCHAR(50) COMMENT '商品ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    event_type VARCHAR(50) NOT NULL COMMENT '事件类型',
    event_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '事件时间',
    click_count INT DEFAULT 0 COMMENT '点击次数',
    exposure_count INT DEFAULT 0 COMMENT '曝光次数',
    conversion_count INT DEFAULT 0 COMMENT '转化次数',
    order_amount DECIMAL(12,2) DEFAULT 0 COMMENT '订单金额',
    cost_amount DECIMAL(12,2) DEFAULT 0 COMMENT '投入成本',
    campaign_id VARCHAR(50) COMMENT '推广活动ID',
    creative_id VARCHAR(50) COMMENT '创意ID',
    performance_metrics JSONB COMMENT '效果指标',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (activity_id) REFERENCES marketing_activity(activity_id),
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (channel_id) REFERENCES channel(channel_id)
);

-- 21. 评价反馈表
CREATE TABLE IF NOT EXISTS product_review (
    review_id VARCHAR(50) PRIMARY KEY COMMENT '评价ID',
    order_id VARCHAR(50) NOT NULL COMMENT '订单ID',
    order_item_id VARCHAR(50) NOT NULL COMMENT '订单项ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    product_id VARCHAR(50) NOT NULL COMMENT '商品ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5) COMMENT '评分(1-5星)',
    review_content TEXT COMMENT '评价内容',
    review_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
    review_images TEXT COMMENT '评价图片',
    review_videos TEXT COMMENT '评价视频',
    likes_count INT DEFAULT 0 COMMENT '点赞数',
    replies_count INT DEFAULT 0 COMMENT '回复数',
    is_anonymous BOOLEAN DEFAULT FALSE COMMENT '是否匿名',
    review_status VARCHAR(20) DEFAULT '已发布' COMMENT '评价状态',
    product_score DECIMAL(2,1) COMMENT '商品评分',
    logistics_score DECIMAL(2,1) COMMENT '物流评分',
    service_score DECIMAL(2,1) COMMENT '服务评分',
    review_tags TEXT COMMENT '评价标签',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (order_id) REFERENCES order_main(order_id),
    FOREIGN KEY (order_item_id) REFERENCES order_item(order_item_id),
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (channel_id) REFERENCES channel(channel_id)
);

-- 22. 会员积分表
CREATE TABLE IF NOT EXISTS member_points (
    point_record_id VARCHAR(50) PRIMARY KEY COMMENT '积分记录ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    point_type VARCHAR(50) NOT NULL COMMENT '积分类型',
    point_change INT NOT NULL COMMENT '积分变动',
    total_points INT NOT NULL COMMENT '积分余额',
    change_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '变动时间',
    reference_id VARCHAR(50) COMMENT '关联ID',
    reference_type VARCHAR(50) COMMENT '关联类型',
    activity_id VARCHAR(50) COMMENT '营销活动ID',
    order_id VARCHAR(50) COMMENT '订单ID',
    remark TEXT COMMENT '备注',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    -- 外键约束
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (activity_id) REFERENCES marketing_activity(activity_id),
    FOREIGN KEY (order_id) REFERENCES order_main(order_id)
);

-- 23. 退款/售后表
CREATE TABLE IF NOT EXISTS refund_aftersales (
    refund_id VARCHAR(50) PRIMARY KEY COMMENT '退款/售后ID',
    order_id VARCHAR(50) NOT NULL COMMENT '订单ID',
    order_item_id VARCHAR(50) NOT NULL COMMENT '订单项ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    product_id VARCHAR(50) NOT NULL COMMENT '商品ID',
    channel_id VARCHAR(2) COMMENT '渠道ID',
    warehouse_id VARCHAR(50) COMMENT '仓库ID',
    refund_type VARCHAR(50) NOT NULL COMMENT '退款类型',
    refund_reason TEXT NOT NULL COMMENT '退款原因',
    apply_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    approve_time TIMESTAMP COMMENT '审核时间',
    refund_time TIMESTAMP COMMENT '退款时间',
    complete_time TIMESTAMP COMMENT '完成时间',
    refund_status VARCHAR(20) DEFAULT '待审核' COMMENT '退款状态',
    refund_amount DECIMAL(10,2) NOT NULL COMMENT '退款金额',
    quantity INT NOT NULL COMMENT '退款数量',
    refund_reason_detail TEXT COMMENT '退款原因详情',
    refund_images TEXT COMMENT '退款图片',
    refund_videos TEXT COMMENT '退款视频',
    operator_id VARCHAR(50) COMMENT '操作人ID',
    approval_opinion TEXT COMMENT '审批意见',
    tracking_number VARCHAR(100) COMMENT '退货物流单号',
    logistics_company VARCHAR(100) COMMENT '退货物流公司',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    -- 外键约束
    FOREIGN KEY (order_id) REFERENCES order_main(order_id),
    FOREIGN KEY (order_item_id) REFERENCES order_item(order_item_id),
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (channel_id) REFERENCES channel(channel_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
);

-- 创建索引
-- 用户表索引
CREATE INDEX idx_user_phone ON user_info(phone_number);
CREATE INDEX idx_user_reg_date ON user_info(registration_date);
CREATE INDEX idx_user_status ON user_info(active_status);

-- 商品表索引
CREATE INDEX idx_product_code ON product(product_code);
CREATE INDEX idx_product_biz_line ON product(business_line_code);
CREATE INDEX idx_product_status ON product(product_status);

-- 订单表索引
CREATE INDEX idx_order_user ON order_main(user_id);
CREATE INDEX idx_order_channel ON order_main(channel_id);
CREATE INDEX idx_order_time ON order_main(order_time);
CREATE INDEX idx_order_status ON order_main(order_status);

-- 订单项索引
CREATE INDEX idx_order_item_order ON order_item(order_id);
CREATE INDEX idx_order_item_product ON order_item(product_id);

-- 支付表索引
CREATE INDEX idx_payment_order ON payment_record(order_id);
CREATE INDEX idx_payment_transaction ON payment_record(transaction_id);
CREATE INDEX idx_payment_time ON payment_record(payment_time);

-- 物流表索引
CREATE INDEX idx_logistics_order ON logistics_info(order_id);
CREATE INDEX idx_logistics_tracking ON logistics_info(tracking_number);

-- 用户行为日志索引
CREATE INDEX idx_behavior_user ON user_behavior_log(user_id);
CREATE INDEX idx_behavior_session ON user_behavior_log(session_id);
CREATE INDEX idx_behavior_time ON user_behavior_log(action_time);
CREATE INDEX idx_behavior_type ON user_behavior_log(action_type);

-- 库存表索引
CREATE INDEX idx_inventory_product_warehouse ON inventory(product_id, warehouse_id);

-- 用户优惠券索引
CREATE INDEX idx_user_coupon_user ON user_coupon(user_id);
CREATE INDEX idx_user_coupon_status ON user_coupon(status);

-- 营销活动记录索引
CREATE INDEX idx_activity_record_user ON marketing_activity_record(user_id);
CREATE INDEX idx_activity_record_activity ON marketing_activity_record(activity_id);

-- 评价反馈表索引
CREATE INDEX idx_review_user ON product_review(user_id);
CREATE INDEX idx_review_product ON product_review(product_id);
CREATE INDEX idx_review_order ON product_review(order_id);
CREATE INDEX idx_review_time ON product_review(review_time);

-- 会员积分表索引
CREATE INDEX idx_points_user ON member_points(user_id);
CREATE INDEX idx_points_time ON member_points(change_time);
CREATE INDEX idx_points_type ON member_points(point_type);

-- 退款/售后表索引
CREATE INDEX idx_refund_order ON refund_aftersales(order_id);
CREATE INDEX idx_refund_user ON refund_aftersales(user_id);
CREATE INDEX idx_refund_status ON refund_aftersales(refund_status);
CREATE INDEX idx_refund_apply_time ON refund_aftersales(apply_time);

-- 注释：
-- 1. 此SQL脚本创建了陕西文旅集团新渠道电商项目的业务数据库表结构
-- 2. 所有表都包含created_at和updated_at字段用于数据追踪
-- 3. 使用了PostgreSQL的JSONB类型存储复杂数据结构
-- 4. 添加了必要的外键约束和索引以提高查询性能
-- 5. 表结构设计遵循第三范式，减少数据冗余
-- 6. 支持从业务数据库到数据仓库的ETL同步需求