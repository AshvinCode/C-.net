--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11
-- Dumped by pg_dump version 15.2

-- Started on 2024-06-05 22:19:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4397 (class 1262 OID 14342)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: azure_pg_admin
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO azure_pg_admin;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4398 (class 0 OID 0)
-- Dependencies: 4397
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: azure_pg_admin
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 41 (class 2615 OID 429983)
-- Name: Public; Type: SCHEMA; Schema: -; Owner: pgiwstagadmin
--

CREATE SCHEMA "Public";


ALTER SCHEMA "Public" OWNER TO pgiwstagadmin;

--
-- TOC entry 574 (class 1255 OID 430036)
-- Name: get_statecitybyid_ref(refcursor, character varying, integer); Type: FUNCTION; Schema: Public; Owner: pgiwstagadmin
--

CREATE FUNCTION "Public".get_statecitybyid_ref(cursordata refcursor DEFAULT NULL::refcursor, actiontype character varying DEFAULT NULL::character varying, _id integer DEFAULT NULL::integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
BEGIN
   
       IF actiontype = 'getall_country' THEN
			OPEN cursordata FOR
			   select * from "Public".countrie_master;
			RETURN cursordata;
 		END IF;	
		 IF actiontype = 'get_statebycountryid' THEN
			OPEN cursordata FOR
			   select * from "Public".state_master where country_id=_id;
			RETURN cursordata;
 		END IF;	
		 IF actiontype = 'get_citybystateid' THEN
			OPEN cursordata FOR
			   select * from "Public".cities_master where state_id=_id;
			RETURN cursordata;
 		END IF;	
	
END;
$$;


ALTER FUNCTION "Public".get_statecitybyid_ref(cursordata refcursor, actiontype character varying, _id integer) OWNER TO pgiwstagadmin;

--
-- TOC entry 576 (class 1255 OID 430052)
-- Name: get_user_ref(refcursor, character varying, integer); Type: FUNCTION; Schema: Public; Owner: pgiwstagadmin
--

CREATE FUNCTION "Public".get_user_ref(cursordata refcursor DEFAULT NULL::refcursor, actiontype character varying DEFAULT NULL::character varying, _id integer DEFAULT NULL::integer) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
    IF actiontype = 'getuserbyid' THEN
        OPEN cursordata FOR 
		 select  usr.id,usr.email,usr.full_name,usr.date_of_birth,usr.address,
		 ct.name as city,
		 ct.id as city_id,
		 st.name as state,
		 st.id as state_id,
		 cnt.name as country,
		 cnt.id as country_id,
		 usr.hobby,usr.password,usr.gender  
		from "Public".users as usr 
		join "Public".cities_master as ct on ct.id=usr.city_id
		join "Public".state_master as st on st.id=ct.state_id
		join "Public".countrie_master as cnt on cnt.id=st.country_id
		where usr.id=_id and usr.isdelete is false;
    	RETURN cursordata;
    END IF;
	
	 IF actiontype = 'getAlluser' THEN
        OPEN cursordata FOR 
		 select  usr.id,usr.email,usr.full_name,usr.date_of_birth,usr.address,
		 ct.name as city,
		 ct.id as city_id,
		 st.name as state,
		 st.id as state_id,
		 cnt.name as country,
		 cnt.id as country_id,
		 usr.hobby,usr.password,usr.gender  
		from "Public".users as usr 
		join "Public".cities_master as ct on ct.id=usr.city_id
		join "Public".state_master as st on st.id=ct.state_id
		join "Public".countrie_master as cnt on cnt.id=st.country_id where usr.isdelete is false;
    	RETURN cursordata;
    END IF;

    
END;
$$;


ALTER FUNCTION "Public".get_user_ref(cursordata refcursor, actiontype character varying, _id integer) OWNER TO pgiwstagadmin;

--
-- TOC entry 575 (class 1255 OID 430037)
-- Name: user_createupdate_delete_ref(refcursor, character varying, integer, character varying, character varying, character varying, character varying, date, character varying, integer, character varying); Type: FUNCTION; Schema: Public; Owner: pgiwstagadmin
--

CREATE FUNCTION "Public".user_createupdate_delete_ref(cursordata refcursor DEFAULT NULL::refcursor, actiontype character varying DEFAULT NULL::character varying, _id integer DEFAULT NULL::integer, _email character varying DEFAULT NULL::character varying, _password character varying DEFAULT NULL::character varying, _full_name character varying DEFAULT NULL::character varying, _gender character varying DEFAULT NULL::character varying, _date_of_birth date DEFAULT NULL::date, _address character varying DEFAULT NULL::character varying, _city_id integer DEFAULT NULL::integer, _hobby character varying DEFAULT NULL::character varying) RETURNS refcursor
    LANGUAGE plpgsql
    AS $$
DECLARE
    result_message text;
    new_id integer;
    status_code integer;
    status text;
    operation text;
BEGIN
    IF actiontype = 'insertupdateuser' THEN
        IF _id IS NOT NULL AND _id > 0 THEN
            UPDATE "Public".users
            SET email = _email, 
                password = _password, 
                full_name = _full_name, 
                gender = _gender, 
                date_of_birth = _date_of_birth, 
                address = _address, 
                city_id = _city_id, 
                hobby = _hobby
            WHERE id = _id;

            result_message := 'Update successful';
            new_id := _id;
            status_code := 2;
            status := 'success';
            operation := 'update';
        ELSE
            INSERT INTO "Public".users(
                email, password, full_name, gender, date_of_birth, address, city_id, hobby, isdelete, createdat)
            VALUES (_email, _password, _full_name, _gender, _date_of_birth, _address, _city_id, _hobby, false, NOW())
            RETURNING id INTO new_id;

            result_message := 'Insert successful';
            status_code := 1;
            status := 'success';
            operation := 'insert';
        END IF;
    ELSIF actiontype = 'deleteuser' THEN
        --DELETE FROM "Public".users WHERE id = _id;
        update "Public".users set isdelete='true' where id=_id;
        
        IF FOUND THEN
            result_message := 'Delete successful';
            status_code := 3;
            status := 'success';
            operation := 'delete';
            new_id := _id;
        ELSE
            result_message := 'Delete failed: user not found';
            status_code := 4;
            status := 'error';
            operation := 'delete';
            new_id := NULL;
        END IF;
    ELSE
        result_message := 'Invalid action type';
        status_code := 4;
        status := 'error';
        operation := 'invalid';
        new_id := NULL;
    END IF;

    OPEN cursordata FOR 
    SELECT status_code, status, result_message, new_id AS insert_update_id, operation;

    RETURN cursordata;
END;
$$;


ALTER FUNCTION "Public".user_createupdate_delete_ref(cursordata refcursor, actiontype character varying, _id integer, _email character varying, _password character varying, _full_name character varying, _gender character varying, _date_of_birth date, _address character varying, _city_id integer, _hobby character varying) OWNER TO pgiwstagadmin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 353 (class 1259 OID 430018)
-- Name: cities_master; Type: TABLE; Schema: Public; Owner: pgiwstagadmin
--

CREATE TABLE "Public".cities_master (
    id integer NOT NULL,
    state_id integer,
    name character varying(255) NOT NULL
);


ALTER TABLE "Public".cities_master OWNER TO pgiwstagadmin;

--
-- TOC entry 352 (class 1259 OID 430017)
-- Name: cities_master_id_seq; Type: SEQUENCE; Schema: Public; Owner: pgiwstagadmin
--

CREATE SEQUENCE "Public".cities_master_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Public".cities_master_id_seq OWNER TO pgiwstagadmin;

--
-- TOC entry 4399 (class 0 OID 0)
-- Dependencies: 352
-- Name: cities_master_id_seq; Type: SEQUENCE OWNED BY; Schema: Public; Owner: pgiwstagadmin
--

ALTER SEQUENCE "Public".cities_master_id_seq OWNED BY "Public".cities_master.id;


--
-- TOC entry 349 (class 1259 OID 430000)
-- Name: countrie_master; Type: TABLE; Schema: Public; Owner: pgiwstagadmin
--

CREATE TABLE "Public".countrie_master (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE "Public".countrie_master OWNER TO pgiwstagadmin;

--
-- TOC entry 348 (class 1259 OID 429999)
-- Name: countrie_master_id_seq; Type: SEQUENCE; Schema: Public; Owner: pgiwstagadmin
--

CREATE SEQUENCE "Public".countrie_master_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Public".countrie_master_id_seq OWNER TO pgiwstagadmin;

--
-- TOC entry 4400 (class 0 OID 0)
-- Dependencies: 348
-- Name: countrie_master_id_seq; Type: SEQUENCE OWNED BY; Schema: Public; Owner: pgiwstagadmin
--

ALTER SEQUENCE "Public".countrie_master_id_seq OWNED BY "Public".countrie_master.id;


--
-- TOC entry 351 (class 1259 OID 430009)
-- Name: state_master; Type: TABLE; Schema: Public; Owner: pgiwstagadmin
--

CREATE TABLE "Public".state_master (
    id integer NOT NULL,
    country_id integer,
    name character varying(255) NOT NULL
);


ALTER TABLE "Public".state_master OWNER TO pgiwstagadmin;

--
-- TOC entry 350 (class 1259 OID 430008)
-- Name: state_master_id_seq; Type: SEQUENCE; Schema: Public; Owner: pgiwstagadmin
--

CREATE SEQUENCE "Public".state_master_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Public".state_master_id_seq OWNER TO pgiwstagadmin;

--
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 350
-- Name: state_master_id_seq; Type: SEQUENCE OWNED BY; Schema: Public; Owner: pgiwstagadmin
--

ALTER SEQUENCE "Public".state_master_id_seq OWNED BY "Public".state_master.id;


--
-- TOC entry 347 (class 1259 OID 429988)
-- Name: users; Type: TABLE; Schema: Public; Owner: pgiwstagadmin
--

CREATE TABLE "Public".users (
    id integer NOT NULL,
    password character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    address text NOT NULL,
    city_id integer,
    hobby character varying(255),
    isdelete boolean,
    createdat timestamp without time zone,
    gender character varying(6),
    email character varying(50)
);


ALTER TABLE "Public".users OWNER TO pgiwstagadmin;

--
-- TOC entry 346 (class 1259 OID 429987)
-- Name: usersmater_id_seq; Type: SEQUENCE; Schema: Public; Owner: pgiwstagadmin
--

CREATE SEQUENCE "Public".usersmater_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Public".usersmater_id_seq OWNER TO pgiwstagadmin;

--
-- TOC entry 4402 (class 0 OID 0)
-- Dependencies: 346
-- Name: usersmater_id_seq; Type: SEQUENCE OWNED BY; Schema: Public; Owner: pgiwstagadmin
--

ALTER SEQUENCE "Public".usersmater_id_seq OWNED BY "Public".users.id;


--
-- TOC entry 4236 (class 2604 OID 430021)
-- Name: cities_master id; Type: DEFAULT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".cities_master ALTER COLUMN id SET DEFAULT nextval('"Public".cities_master_id_seq'::regclass);


--
-- TOC entry 4234 (class 2604 OID 430003)
-- Name: countrie_master id; Type: DEFAULT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".countrie_master ALTER COLUMN id SET DEFAULT nextval('"Public".countrie_master_id_seq'::regclass);


--
-- TOC entry 4235 (class 2604 OID 430012)
-- Name: state_master id; Type: DEFAULT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".state_master ALTER COLUMN id SET DEFAULT nextval('"Public".state_master_id_seq'::regclass);


--
-- TOC entry 4233 (class 2604 OID 429991)
-- Name: users id; Type: DEFAULT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".users ALTER COLUMN id SET DEFAULT nextval('"Public".usersmater_id_seq'::regclass);


--
-- TOC entry 4248 (class 2606 OID 430025)
-- Name: cities_master cities_master_name_key; Type: CONSTRAINT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".cities_master
    ADD CONSTRAINT cities_master_name_key UNIQUE (name);


--
-- TOC entry 4250 (class 2606 OID 430023)
-- Name: cities_master cities_master_pkey; Type: CONSTRAINT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".cities_master
    ADD CONSTRAINT cities_master_pkey PRIMARY KEY (id);


--
-- TOC entry 4240 (class 2606 OID 430007)
-- Name: countrie_master countrie_master_name_key; Type: CONSTRAINT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".countrie_master
    ADD CONSTRAINT countrie_master_name_key UNIQUE (name);


--
-- TOC entry 4242 (class 2606 OID 430005)
-- Name: countrie_master countrie_master_pkey; Type: CONSTRAINT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".countrie_master
    ADD CONSTRAINT countrie_master_pkey PRIMARY KEY (id);


--
-- TOC entry 4244 (class 2606 OID 430016)
-- Name: state_master state_master_name_key; Type: CONSTRAINT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".state_master
    ADD CONSTRAINT state_master_name_key UNIQUE (name);


--
-- TOC entry 4246 (class 2606 OID 430014)
-- Name: state_master state_master_pkey; Type: CONSTRAINT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".state_master
    ADD CONSTRAINT state_master_pkey PRIMARY KEY (id);


--
-- TOC entry 4238 (class 2606 OID 429996)
-- Name: users usersmater_pkey; Type: CONSTRAINT; Schema: Public; Owner: pgiwstagadmin
--

ALTER TABLE ONLY "Public".users
    ADD CONSTRAINT usersmater_pkey PRIMARY KEY (id);


-- Completed on 2024-06-05 22:19:42

--
-- PostgreSQL database dump complete
--

