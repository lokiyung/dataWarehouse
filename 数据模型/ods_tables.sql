-- 陕西文旅集团新渠道电商项目 - ODS层表设计
-- ODS层：操作数据存储层，保留原始数据特征，用于数据同步和问题追溯

-- 设置分区格式
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

-- 1. 用户表 - ODS层
CREATE TABLE ods.user (
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
    -- 扩展字段
    avatar_url STRING COMMENT '头像URL',
    device_info STRING COMMENT '设备信息',
    app_version STRING COMMENT 'APP版本',
    -- JSON字段，存储原始复杂数据
    original_user_data STRING COMMENT '原始用户数据JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '用户ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/user';

-- 2. 商品表 - ODS层
CREATE TABLE ods.product (
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
    -- 扩展字段
    main_image_url STRING COMMENT '主图URL',
    image_urls STRING COMMENT '图片URL列表',
    video_url STRING COMMENT '视频URL',
    sales_count INT COMMENT '销量',
    -- JSON字段
    product_details_json STRING COMMENT '商品详情JSON',
    sku_json STRING COMMENT 'SKU信息JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '商品ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/product';

-- 3. 渠道表 - ODS层
CREATE TABLE ods.channel (
    channel_id STRING COMMENT '渠道编码',
    channel_name STRING COMMENT '渠道名称',
    channel_type STRING COMMENT '渠道类型',
    platform STRING COMMENT '所属平台',
    channel_manager STRING COMMENT '渠道负责人',
    start_date STRING COMMENT '启用日期',
    end_date STRING COMMENT '停用日期',
    status STRING COMMENT '状态',
    -- 扩展字段
    api_endpoint STRING COMMENT 'API端点',
    channel_config STRING COMMENT '渠道配置信息',
    -- JSON字段
    channel_extend_json STRING COMMENT '渠道扩展信息JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '渠道ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/channel';

-- 4. 订单表 - ODS层
CREATE TABLE ods.order (
    order_id STRING COMMENT '订单ID',
    order_item_id STRING COMMENT '订单项ID',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
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
    shipping_fee DECIMAL(10,2) COMMENT '运费',
    tracking_number STRING COMMENT '物流单号',
    payment_method STRING COMMENT '支付方式',
    -- 扩展字段
    transaction_id STRING COMMENT '交易ID',
    delivery_address STRING COMMENT '收货地址',
    delivery_person STRING COMMENT '收货人',
    delivery_phone STRING COMMENT '收货电话',
    -- 业务标识字段
    business_line_code STRING COMMENT '业务线编码',
    model_id STRING COMMENT '合作模式ID',
    source_id STRING COMMENT '流量来源ID',
    type_id STRING COMMENT '订单类型ID',
    activity_id STRING COMMENT '营销活动ID',
    coupon_id STRING COMMENT '优惠券ID',
    warehouse_id STRING COMMENT '仓库ID',
    supplier_id STRING COMMENT '供应商ID',
    -- JSON字段
    order_details_json STRING COMMENT '订单详情JSON',
    payment_info_json STRING COMMENT '支付信息JSON',
    logistics_info_json STRING COMMENT '物流信息JSON',
    -- UBI编码
    ubi_code STRING COMMENT '业务统一标识编码',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '订单ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/order';

-- 5. 支付表 - ODS层
CREATE TABLE ods.payment (
    payment_id STRING COMMENT '支付ID',
    order_id STRING COMMENT '订单ID',
    user_id STRING COMMENT '用户ID',
    channel_id STRING COMMENT '渠道ID',
    payment_time TIMESTAMP COMMENT '支付时间',
    payment_method STRING COMMENT '支付方式',
    transaction_id STRING COMMENT '交易流水号',
    payment_amount DECIMAL(10,2) COMMENT '支付金额',
    currency STRING COMMENT '货币类型',
    payment_status STRING COMMENT '支付状态',
    refund_amount DECIMAL(10,2) COMMENT '退款金额',
    -- 扩展字段
    payment_gateway STRING COMMENT '支付网关',
    payment_ip STRING COMMENT '支付IP',
    terminal_info STRING COMMENT '终端信息',
    -- JSON字段
    payment_details_json STRING COMMENT '支付详情JSON',
    refund_details_json STRING COMMENT '退款详情JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '支付ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/payment';

-- 6. 物流表 - ODS层
CREATE TABLE ods.logistics (
    logistics_id STRING COMMENT '物流ID',
    order_id STRING COMMENT '订单ID',
    order_item_id STRING COMMENT '订单项ID',
    product_id STRING COMMENT '商品ID',
    warehouse_id STRING COMMENT '仓库ID',
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
    -- 扩展字段
    sender_address STRING COMMENT '发货地址',
    sender_person STRING COMMENT '发货人',
    sender_phone STRING COMMENT '发货电话',
    -- JSON字段
    logistics_trace_json STRING COMMENT '物流轨迹JSON',
    package_info_json STRING COMMENT '包裹信息JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '物流ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/logistics';

-- 7. 用户行为日志表 - ODS层
CREATE TABLE ods.user_behavior_log (
    log_id STRING COMMENT '日志ID',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
    action_type STRING COMMENT '行为类型',
    action_time TIMESTAMP COMMENT '行为时间',
    page_url STRING COMMENT '页面URL',
    page_title STRING COMMENT '页面标题',
    page_type STRING COMMENT '页面类型',
    stay_duration INT COMMENT '停留时长(秒)',
    device_type STRING COMMENT '设备类型',
    ip_address STRING COMMENT 'IP地址',
    session_id STRING COMMENT '会话ID',
    -- 扩展字段
    browser STRING COMMENT '浏览器',
    os STRING COMMENT '操作系统',
    network_type STRING COMMENT '网络类型',
    screen_resolution STRING COMMENT '屏幕分辨率',
    -- 业务标识字段
    source_id STRING COMMENT '流量来源ID',
    activity_id STRING COMMENT '活动ID',
    -- JSON字段
    event_params_json STRING COMMENT '事件参数JSON',
    user_agent_json STRING COMMENT '用户代理信息JSON',
    -- UBI编码
    ubi_code STRING COMMENT '业务统一标识编码',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区',
    hour STRING COMMENT '小时分区'
) 
COMMENT '用户行为日志ODS表'
STORED AS PARQUET
PARTITIONED BY (dt, hour)
LOCATION '/warehouse/ods/user_behavior_log';

-- 8. 营销活动表 - ODS层
CREATE TABLE ods.marketing_activity (
    activity_id STRING COMMENT '活动ID',
    activity_log_id STRING COMMENT '活动日志ID',
    activity_name STRING COMMENT '活动名称',
    activity_type STRING COMMENT '活动类型',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
    supplier_id STRING COMMENT '供应商ID',
    start_date TIMESTAMP COMMENT '开始时间',
    end_date TIMESTAMP COMMENT '结束时间',
    budget DECIMAL(12,2) COMMENT '活动预算',
    channel_ids STRING COMMENT '适用渠道',
    product_ids STRING COMMENT '适用商品',
    status STRING COMMENT '活动状态',
    event_time TIMESTAMP COMMENT '事件时间',
    event_type STRING COMMENT '事件类型',
    click_count INT COMMENT '点击次数',
    exposure_count INT COMMENT '曝光次数',
    conversion_count INT COMMENT '转化次数',
    order_amount DECIMAL(12,2) COMMENT '订单金额',
    cost_amount DECIMAL(12,2) COMMENT '投入成本',
    -- 扩展字段
    campaign_id STRING COMMENT '推广活动ID',
    creative_id STRING COMMENT '创意ID',
    -- JSON字段
    activity_rules_json STRING COMMENT '活动规则JSON',
    performance_metrics_json STRING COMMENT '效果指标JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '营销活动ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/marketing_activity';

-- 9. 库存表 - ODS层
CREATE TABLE ods.inventory (
    inventory_id STRING COMMENT '库存ID',
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
    -- 扩展字段
    inventory_type STRING COMMENT '库存类型',
    lot_number STRING COMMENT '批次号',
    -- JSON字段
    inventory_details_json STRING COMMENT '库存详情JSON',
    transaction_history_json STRING COMMENT '交易历史JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '库存ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/inventory';

-- 10. 优惠券表 - ODS层
CREATE TABLE ods.coupon (
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
    -- 扩展字段
    issue_count INT COMMENT '发放数量',
    used_count INT COMMENT '已使用数量',
    remaining_count INT COMMENT '剩余数量',
    -- JSON字段
    coupon_rules_json STRING COMMENT '优惠券规则JSON',
    usage_details_json STRING COMMENT '使用详情JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '优惠券ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/coupon';

-- 11. 评价反馈表 - ODS层
CREATE TABLE ods.product_review (
    review_id STRING COMMENT '评价ID',
    order_id STRING COMMENT '订单ID',
    order_item_id STRING COMMENT '订单项ID',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
    rating INT COMMENT '评分(1-5星)',
    review_content STRING COMMENT '评价内容',
    review_time TIMESTAMP COMMENT '评价时间',
    -- 扩展字段
    review_images STRING COMMENT '评价图片',
    review_videos STRING COMMENT '评价视频',
    likes_count INT COMMENT '点赞数',
    replies_count INT COMMENT '回复数',
    is_anonymous STRING COMMENT '是否匿名',
    review_status STRING COMMENT '评价状态',
    product_score DECIMAL(2,1) COMMENT '商品评分',
    logistics_score DECIMAL(2,1) COMMENT '物流评分',
    service_score DECIMAL(2,1) COMMENT '服务评分',
    review_tags STRING COMMENT '评价标签',
    -- JSON字段
    review_details_json STRING COMMENT '评价详情JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '评价反馈ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/product_review';

-- 12. 会员积分表 - ODS层
CREATE TABLE ods.member_points (
    point_record_id STRING COMMENT '积分记录ID',
    user_id STRING COMMENT '用户ID',
    point_type STRING COMMENT '积分类型',
    point_change INT COMMENT '积分变动',
    total_points INT COMMENT '积分余额',
    change_time TIMESTAMP COMMENT '变动时间',
    -- 扩展字段
    reference_id STRING COMMENT '关联ID',
    reference_type STRING COMMENT '关联类型',
    activity_id STRING COMMENT '营销活动ID',
    order_id STRING COMMENT '订单ID',
    remark STRING COMMENT '备注',
    -- JSON字段
    points_details_json STRING COMMENT '积分详情JSON',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '会员积分ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/member_points';

-- 13. 退款/售后表 - ODS层
CREATE TABLE ods.refund_aftersales (
    refund_id STRING COMMENT '退款/售后ID',
    order_id STRING COMMENT '订单ID',
    order_item_id STRING COMMENT '订单项ID',
    user_id STRING COMMENT '用户ID',
    product_id STRING COMMENT '商品ID',
    channel_id STRING COMMENT '渠道ID',
    warehouse_id STRING COMMENT '仓库ID',
    refund_type STRING COMMENT '退款类型',
    refund_reason STRING COMMENT '退款原因',
    apply_time TIMESTAMP COMMENT '申请时间',
    approve_time TIMESTAMP COMMENT '审核时间',
    refund_time TIMESTAMP COMMENT '退款时间',
    complete_time TIMESTAMP COMMENT '完成时间',
    refund_status STRING COMMENT '退款状态',
    refund_amount DECIMAL(10,2) COMMENT '退款金额',
    quantity INT COMMENT '退款数量',
    -- 扩展字段
    refund_reason_detail STRING COMMENT '退款原因详情',
    refund_images STRING COMMENT '退款图片',
    refund_videos STRING COMMENT '退款视频',
    operator_id STRING COMMENT '操作人ID',
    approval_opinion STRING COMMENT '审批意见',
    tracking_number STRING COMMENT '退货物流单号',
    logistics_company STRING COMMENT '退货物流公司',
    -- JSON字段
    refund_details_json STRING COMMENT '退款详情JSON',
    logistics_info_json STRING COMMENT '退货物流信息JSON',
    -- UBI编码
    ubi_code STRING COMMENT '业务统一标识编码',
    -- 元数据字段
    data_source STRING COMMENT '数据来源',
    import_time TIMESTAMP COMMENT '导入时间',
    is_valid STRING COMMENT '数据有效性标记',
    -- 分区字段
    dt STRING COMMENT '数据日期分区'
) 
COMMENT '退款/售后ODS表'
STORED AS PARQUET
PARTITIONED BY (dt)
LOCATION '/warehouse/ods/refund_aftersales';