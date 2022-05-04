-- Customers Table
CREATE TABLE IF NOT EXISTS public.customers
(
    customer_name character varying COLLATE pg_catalog."default" NOT NULL,
    customer_id character varying COLLATE pg_catalog."default" NOT NULL,
    province character varying COLLATE pg_catalog."default" NOT NULL,
    region character varying COLLATE pg_catalog."default" NOT NULL,
    customer_segment character varying COLLATE pg_catalog."default",
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
);

-- Customer Order Details
CREATE TABLE IF NOT EXISTS public.customer_orders
(
    ord_id character varying COLLATE pg_catalog."default" NOT NULL,
    cust_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT customer_orders_pkey PRIMARY KEY (ord_id),
    CONSTRAINT fkey_cust_id FOREIGN KEY (cust_id)
        REFERENCES public.customers (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

-- Product Table 
CREATE TABLE IF NOT EXISTS public.product
(
    product_category character varying COLLATE pg_catalog."default" NOT NULL,
    product_base_margin real,
    prod_id character varying COLLATE pg_catalog."default" NOT NULL,
    product_sub_category character varying COLLATE pg_catalog."default",
    CONSTRAINT product_pkey PRIMARY KEY (prod_id)
);

-- Order Details Table
CREATE TABLE IF NOT EXISTS public.order_details
(
    processing_id integer NOT NULL,
    order_date date,
    order_priority character varying COLLATE pg_catalog."default",
    ord_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT order_details_pkey PRIMARY KEY (ord_id),
    CONSTRAINT order_details_processing_id_key UNIQUE (processing_id)
);

-- Shipping Table
CREATE TABLE IF NOT EXISTS public.shipping_details
(
    processing_id integer NOT NULL,
    ship_mode character varying COLLATE pg_catalog."default",
    ship_date date NOT NULL,
    ship_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT shipping_details_pkey PRIMARY KEY (ship_id),
    CONSTRAINT shipping_details_processing_id_fkey FOREIGN KEY (processing_id)
        REFERENCES public.order_details (processing_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Order Table
CREATE TABLE IF NOT EXISTS public."Order_table"
(
    ord_id character varying COLLATE pg_catalog."default" NOT NULL,
    prod_id character varying COLLATE pg_catalog."default" NOT NULL,
    ship_id character varying COLLATE pg_catalog."default" NOT NULL,
    sales real,
    discount real,
    order_quantity real NOT NULL,
    profit real NOT NULL,
    shipping_cost real NOT NULL,
    CONSTRAINT "Order_table_pkey" PRIMARY KEY (ord_id, prod_id, ship_id),
    CONSTRAINT "Order_table_cist_ord_fkey" FOREIGN KEY (ord_id)
        REFERENCES public.customer_orders (ord_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Order_table_ord_id_fkey" FOREIGN KEY (ord_id)
        REFERENCES public.order_details (ord_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Order_table_prd_id_fkey" FOREIGN KEY (prod_id)
        REFERENCES public.product (prod_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT "Order_table_ship_id_fkey" FOREIGN KEY (ship_id)
        REFERENCES public.shipping_details (ship_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


