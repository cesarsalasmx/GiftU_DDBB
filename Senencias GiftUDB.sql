--***************TABLE************************-- 

--CREACOIN TABLA social_network
CREATE TABLE public.social_network (id_social_network serial, name character varying(30), 
CONSTRAINT social_network_pkey PRIMARY KEY (id_social_network));
ALTER TABLE public.social_network ALTER COLUMN id_social_network NOT NULL;

--CREACION TABLA DE ROLES
CREATE TABLE public.roles (id_rol serial, name character varying(50), CONSTRAINT roles_pkey PRIMARY KEY (id_rol));
ALTER TABLE public.roles ALTER COLUMN id_rol NOT NULL;

--CREACION TABLA DE GENEROS
CREATE TABLE public.genders (id_gender serial, name character varying(50), CONSTRAINT genders_pkey PRIMARY KEY (id_gender));
ALTER TABLE public.genders ALTER COLUMN id_gender NOT NULL;

--CREACION TABLA DE pv_social_network
CREATE TABLE public.pv_social_network (id_pv_social_network serial, id_receiver integer, id_social_network integer, 
url_social_network character varying(255), CONSTRAINT pv_social_network_pkey PRIMARY KEY (id_pv_social_network));
ALTER TABLE public.pv_social_network ALTER COLUMN id_pv_social_network NOT NULL;

--CREACION TABLA DE USUARIOS
CREATE TABLE public.users (id_user serial, first_name character varying(50), last_name character varying(50), 
email character varying(100), password character varying(100), date_registration date, birthday date, status boolean, 
id_genders integer, id_roles integer, id_country integer, CONSTRAINT user_pkey PRIMARY KEY (id_user));
ALTER TABLE public.users ALTER COLUMN id_user NOT NULL;

--CREACION TABLA DE REGALADOS
CREATE TABLE public.receivers (id_receiver serial, name character varying(50), birthday date, id_gender integer, id_country integer,
CONSTRAINT receivers_pkey PRIMARY KEY (id_receiver));
ALTER TABLE public.receivers ALTER COLUMN id_receiver NOT NULL;

--CREA TABLA HISOTORICO DE REGALOS
CREATE TABLE public.gift_history (id_gift_history serial, date_gift timestamp, id_user integer, id_receiver integer
id_pv_search_user integer, id_ocasion integer, CONSTRAINT gift_history_pkey PRIMARY KEY (id_gift_history));
ALTER TABLE public.gift_history ALTER COLUMN id_gift_history NOT NULL;

--CREACION TABLA DE PAIESES
CREATE TABLE public.countries (id_country serial, countryID character varying(2), countryName character varying(50),
CONSTRAINT countries_pkey PRIMARY KEY (id_country));
ALTER TABLE public.countries ALTER COLUMN id_country NOT NULL;

--CREACION PIVOT DE BUSQUEDAS USUARIO
CREATE TABLE public.pv_search_user (id_search_user serial, id_url integer, id_product integer, 
CONSTRAINT pv_search_user_pkey PRIMARY KEY (id_search_user));
ALTER TABLE public.pv_search_user ALTER COLUMN id_search_user NOT NULL;

--CREA TABLA BUSQUEDAS DE USUARIOS
CREATE TABLE public.search_url (id_url serial, url character varying(255), status boolean,
CONSTRAINT search_url_pkey PRIMARY KEY (id_url));
ALTER TABLE public.search_url ALTER COLUMN id_url NOT NULL;

--CREA TABLA PRODUCTOS
CREATE TABLE public.products (id_product serial, name character varying(100), description character varying(255), 
price numeric(9,2), rating character varying(5), popularity integer, id_category int, status boolean, 
CONSTRAINT products_pkey PRIMARY KEY (id_product));
ALTER TABLE public.products ALTER COLUMN id_product NOT NULL;

--CREA TABLA DE OCACIONES
CREATE TABLE public.occasions (id_occasion serial, name character varying(60), id_country integer, status boolean, 
CONSTRAINT occasions_pkey PRIMARY KEY (id_occasion));
ALTER TABLE public.occasions ALTER COLUMN id_occasion NOT NULL;

--CREA TABLA CATEGORIAS
CREATE TABLE public.categories (id_category serial, name character varying(100), status boolean, 
CONSTRAINT categories_pkey PRIMARY KEY (id_category));
ALTER TABLE public.categories ALTER COLUMN id_category NOT NULL;

--***************CONSTRAINT************************--

--pv_social_network--
ALTER TABLE public.pv_social_network ADD CONSTRAINT pv_social_network_receivers_fkey FOREIGN KEY (id_receiver) 
REFERENCES public.receivers (id_receiver) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.pv_social_network ADD CONSTRAINT pv_social_network_social_network_fkey
FOREIGN KEY (id_social_network) REFERENCES public.social_network (id_social_network) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

--users--
ALTER TABLE public.users ADD CONSTRAINT users_genders_fkey FOREIGN KEY (id_genders)
REFERENCES public.genders (id_gender) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.users ADD CONSTRAINT users_roles_fkey FOREIGN KEY (id_roles)
REFERENCES public.roles (id_rol) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.users ADD CONSTRAINT users_countries_fkey FOREIGN KEY (id_country)
REFERENCES public.countries (id_country) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

--receivers--
ALTER TABLE public.receivers ADD CONSTRAINT receivers_countries_fkey FOREIGN KEY (id_country)
REFERENCES public.countries (id_country) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.receivers ADD CONSTRAINT receivers_genders_fkey FOREIGN KEY (id_gender)
REFERENCES public.genders (id_gender) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

--gift_history--
ALTER TABLE public.gift_history ADD CONSTRAINT gift_history_users_fkey FOREIGN KEY (id_user)
REFERENCES public.users (id_user) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.gift_history ADD CONSTRAINT gift_history_receivers_fkey FOREIGN KEY (id_receiver)
REFERENCES public.receivers (id_receiver) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.gift_history ADD CONSTRAINT gift_history_occasions_fkey FOREIGN KEY (id_occasion)
REFERENCES public.occasions (id_occasion) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.gift_history ADD CONSTRAINT gift_history_pv_search_user_fkey  
FOREIGN KEY (id_search_user) REFERENCES public.pv_search_user (id_search_user) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

--pv_search_user--
ALTER TABLE public.pv_search_user ADD CONSTRAINT pv_search_user_search_url_fkey FOREIGN KEY (id_url) 
REFERENCES public.search_url (id_url) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE public.pv_search_user ADD CONSTRAINT pv_search_user_products_fkey FOREIGN KEY (id_product) 
REFERENCES public.products (id_product) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

--products--
ALTER TABLE public.products ADD CONSTRAINT products_categories_fkey FOREIGN KEY (id_category) 
REFERENCES public.categories (id_category) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

--occasions--
ALTER TABLE public.occasions ADD CONSTRAINT occasions_countries_fkey FOREIGN KEY (id_country)
REFERENCES public.countries (id_country) MATCH SIMPLE
ON UPDATE CASCADE ON DELETE CASCADE;

