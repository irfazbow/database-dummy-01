-- public.buyer definition

-- Drop table

-- DROP TABLE public.buyer;

CREATE TABLE public.buyer (
	buyerid serial4 NOT NULL,
	buyername varchar(100) NULL,
	contactinfo varchar(100) NULL,
	deliveryaddress varchar(255) NULL,
	CONSTRAINT buyer_pkey PRIMARY KEY (buyerid)
);


-- public.courier definition

-- Drop table

-- DROP TABLE public.courier;

CREATE TABLE public.courier (
	courierid serial4 NOT NULL,
	couriername varchar(100) NULL,
	CONSTRAINT courier_pkey PRIMARY KEY (courierid)
);


-- public.seller definition

-- Drop table

-- DROP TABLE public.seller;

CREATE TABLE public.seller (
	sellerid serial4 NOT NULL,
	sellername varchar(100) NULL,
	contactinfo varchar(255) NULL,
	CONSTRAINT seller_pkey PRIMARY KEY (sellerid)
);


-- public.orders definition

-- Drop table

-- DROP TABLE public.orders;

CREATE TABLE public.orders (
	orderid serial4 NOT NULL,
	buyerid int4 NULL,
	orderdate date NULL,
	deliveryfee numeric(10, 2) NULL,
	insurancefee numeric(10, 2) NULL,
	servicefee numeric(10, 2) NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (orderid),
	CONSTRAINT orders_buyerid_fkey FOREIGN KEY (buyerid) REFERENCES public.buyer(buyerid)
);


-- public.payment definition

-- Drop table

-- DROP TABLE public.payment;

CREATE TABLE public.payment (
	paymentid serial4 NOT NULL,
	orderid int4 NULL,
	paymentmethod varchar(50) NULL,
	CONSTRAINT payment_orderid_key UNIQUE (orderid),
	CONSTRAINT payment_pkey PRIMARY KEY (paymentid),
	CONSTRAINT payment_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid)
);


-- public.product definition

-- Drop table

-- DROP TABLE public.product;

CREATE TABLE public.product (
	productid serial4 NOT NULL,
	sellerid int4 NULL,
	productname varchar(100) NULL,
	productdescription text NULL,
	price numeric(10, 2) NULL,
	CONSTRAINT product_pkey PRIMARY KEY (productid),
	CONSTRAINT product_sellerid_fkey FOREIGN KEY (sellerid) REFERENCES public.seller(sellerid)
);


-- public.delivery definition

-- Drop table

-- DROP TABLE public.delivery;

CREATE TABLE public.delivery (
	deliveryid serial4 NOT NULL,
	orderid int4 NULL,
	courierid int4 NULL,
	deliverydate date NULL,
	CONSTRAINT delivery_orderid_key UNIQUE (orderid),
	CONSTRAINT delivery_pkey PRIMARY KEY (deliveryid),
	CONSTRAINT delivery_courierid_fkey FOREIGN KEY (courierid) REFERENCES public.courier(courierid),
	CONSTRAINT delivery_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid)
);


-- public.invoice definition

-- Drop table

-- DROP TABLE public.invoice;

CREATE TABLE public.invoice (
	invoiceid serial4 NOT NULL,
	orderid int4 NULL,
	totalproductprice numeric(10, 2) NULL,
	totalprice numeric(10, 2) NULL,
	invoicedate date NULL,
	CONSTRAINT invoice_orderid_key UNIQUE (orderid),
	CONSTRAINT invoice_pkey PRIMARY KEY (invoiceid),
	CONSTRAINT invoice_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid)
);


-- public.orderitem definition

-- Drop table

-- DROP TABLE public.orderitem;

CREATE TABLE public.orderitem (
	orderitemid serial4 NOT NULL,
	orderid int4 NULL,
	productid int4 NULL,
	quantity int4 NULL,
	priceperorderitem numeric(10, 2) NULL,
	CONSTRAINT orderitem_pkey PRIMARY KEY (orderitemid),
	CONSTRAINT orderitem_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid),
	CONSTRAINT orderitem_productid_fkey FOREIGN KEY (productid) REFERENCES public.product(productid)
);