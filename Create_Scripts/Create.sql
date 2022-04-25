-- Table: public.Order_table

-- DROP TABLE IF EXISTS public."Order_table";

CREATE TABLE IF NOT EXISTS public."Order_table"
(
    ord_id character varying COLLATE pg_catalog."default",
    prod_id character varying COLLATE pg_catalog."default",
    ship_id character varying COLLATE pg_catalog."default",
    customer_id character varying COLLATE pg_catalog."default",
    sales real,
    discount real,
    order_quantity integer NOT NULL,
    profit real NOT NULL,
    shipping_cost real NOT NULL,
    product_base_margin real,
    CONSTRAINT "Order_table_ord_id_fkey" FOREIGN KEY (ord_id)
        REFERENCES public.order_details (ord_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Order_table"
    OWNER to postgres;


-- Table: public.customers

-- DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    customer_name character varying COLLATE pg_catalog."default" NOT NULL,
    customer_id character varying COLLATE pg_catalog."default" NOT NULL,
    province character varying COLLATE pg_catalog."default" NOT NULL,
    region character varying COLLATE pg_catalog."default" NOT NULL,
    customer_segment character varying COLLATE pg_catalog."default",
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;

-- Table: public.order_details

-- DROP TABLE IF EXISTS public.order_details;

CREATE TABLE IF NOT EXISTS public.order_details
(
    processing_id integer NOT NULL,
    order_date date,
    order_priority character varying COLLATE pg_catalog."default",
    ord_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT order_details_pkey PRIMARY KEY (ord_id),
    CONSTRAINT order_details_processing_id_key UNIQUE (processing_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_details
    OWNER to postgres;

-- Table: public.product

-- DROP TABLE IF EXISTS public.product;

CREATE TABLE IF NOT EXISTS public.product
(
    product_category character varying COLLATE pg_catalog."default" NOT NULL,
    product_sub_category character varying COLLATE pg_catalog."default",
    prod_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (prod_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product
    OWNER to postgres;

-- Table: public.shipping_details

-- DROP TABLE IF EXISTS public.shipping_details;

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
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.shipping_details
    OWNER to postgres;