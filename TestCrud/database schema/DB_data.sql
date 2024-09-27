--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11
-- Dumped by pg_dump version 15.2

-- Started on 2024-06-05 22:23:45

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
-- TOC entry 4395 (class 0 OID 430018)
-- Dependencies: 353
-- Data for Name: cities_master; Type: TABLE DATA; Schema: Public; Owner: pgiwstagadmin
--

INSERT INTO "Public".cities_master VALUES (1, 1, 'Mumbai');
INSERT INTO "Public".cities_master VALUES (2, 1, 'Pune');
INSERT INTO "Public".cities_master VALUES (3, 1, 'Nagpur');
INSERT INTO "Public".cities_master VALUES (4, 1, 'Nashik');
INSERT INTO "Public".cities_master VALUES (5, 1, 'Thane');
INSERT INTO "Public".cities_master VALUES (6, 2, 'Bangalore');
INSERT INTO "Public".cities_master VALUES (7, 2, 'Mysore');
INSERT INTO "Public".cities_master VALUES (8, 2, 'Mangalore');
INSERT INTO "Public".cities_master VALUES (9, 2, 'Hubli');
INSERT INTO "Public".cities_master VALUES (10, 2, 'Belgaum');
INSERT INTO "Public".cities_master VALUES (11, 3, 'Chennai');
INSERT INTO "Public".cities_master VALUES (12, 3, 'Coimbatore');
INSERT INTO "Public".cities_master VALUES (13, 3, 'Madurai');
INSERT INTO "Public".cities_master VALUES (14, 3, 'Tiruchirappalli');
INSERT INTO "Public".cities_master VALUES (15, 3, 'Salem');
INSERT INTO "Public".cities_master VALUES (16, 4, 'Ahmedabad');
INSERT INTO "Public".cities_master VALUES (17, 4, 'Surat');
INSERT INTO "Public".cities_master VALUES (18, 4, 'Vadodara');
INSERT INTO "Public".cities_master VALUES (19, 4, 'Rajkot');
INSERT INTO "Public".cities_master VALUES (20, 4, 'Bhavnagar');
INSERT INTO "Public".cities_master VALUES (21, 5, 'Jaipur');
INSERT INTO "Public".cities_master VALUES (22, 5, 'Jodhpur');
INSERT INTO "Public".cities_master VALUES (23, 5, 'Udaipur');
INSERT INTO "Public".cities_master VALUES (24, 5, 'Kota');
INSERT INTO "Public".cities_master VALUES (25, 5, 'Ajmer');
INSERT INTO "Public".cities_master VALUES (26, 6, 'Los Angeles');
INSERT INTO "Public".cities_master VALUES (27, 6, 'San Francisco');
INSERT INTO "Public".cities_master VALUES (28, 6, 'San Diego');
INSERT INTO "Public".cities_master VALUES (29, 6, 'San Jose');
INSERT INTO "Public".cities_master VALUES (30, 6, 'Sacramento');
INSERT INTO "Public".cities_master VALUES (31, 7, 'Houston');
INSERT INTO "Public".cities_master VALUES (32, 7, 'Austin');
INSERT INTO "Public".cities_master VALUES (33, 7, 'Dallas');
INSERT INTO "Public".cities_master VALUES (34, 7, 'San Antonio');
INSERT INTO "Public".cities_master VALUES (35, 7, 'Fort Worth');
INSERT INTO "Public".cities_master VALUES (36, 8, 'New York City');
INSERT INTO "Public".cities_master VALUES (37, 8, 'Buffalo');
INSERT INTO "Public".cities_master VALUES (38, 8, 'Rochester');
INSERT INTO "Public".cities_master VALUES (39, 8, 'Syracuse');
INSERT INTO "Public".cities_master VALUES (40, 8, 'Albany');
INSERT INTO "Public".cities_master VALUES (41, 9, 'Miami');
INSERT INTO "Public".cities_master VALUES (42, 9, 'Orlando');
INSERT INTO "Public".cities_master VALUES (43, 9, 'Tampa');
INSERT INTO "Public".cities_master VALUES (44, 9, 'Jacksonville');
INSERT INTO "Public".cities_master VALUES (45, 9, 'Fort Lauderdale');
INSERT INTO "Public".cities_master VALUES (46, 10, 'Chicago');
INSERT INTO "Public".cities_master VALUES (47, 10, 'Springfield');
INSERT INTO "Public".cities_master VALUES (48, 10, 'Peoria');
INSERT INTO "Public".cities_master VALUES (49, 10, 'Rockford');
INSERT INTO "Public".cities_master VALUES (50, 10, 'Aurora');


--
-- TOC entry 4391 (class 0 OID 430000)
-- Dependencies: 349
-- Data for Name: countrie_master; Type: TABLE DATA; Schema: Public; Owner: pgiwstagadmin
--

INSERT INTO "Public".countrie_master VALUES (1, 'India');
INSERT INTO "Public".countrie_master VALUES (2, 'United States');


--
-- TOC entry 4393 (class 0 OID 430009)
-- Dependencies: 351
-- Data for Name: state_master; Type: TABLE DATA; Schema: Public; Owner: pgiwstagadmin
--

INSERT INTO "Public".state_master VALUES (1, 1, 'Maharashtra');
INSERT INTO "Public".state_master VALUES (2, 1, 'Karnataka');
INSERT INTO "Public".state_master VALUES (3, 1, 'Tamil Nadu');
INSERT INTO "Public".state_master VALUES (4, 1, 'Gujarat');
INSERT INTO "Public".state_master VALUES (5, 1, 'Rajasthan');
INSERT INTO "Public".state_master VALUES (6, 2, 'California');
INSERT INTO "Public".state_master VALUES (7, 2, 'Texas');
INSERT INTO "Public".state_master VALUES (8, 2, 'New York');
INSERT INTO "Public".state_master VALUES (9, 2, 'Florida');
INSERT INTO "Public".state_master VALUES (10, 2, 'Illinois');


--
-- TOC entry 4389 (class 0 OID 429988)
-- Dependencies: 347
-- Data for Name: users; Type: TABLE DATA; Schema: Public; Owner: pgiwstagadmin
--

INSERT INTO "Public".users VALUES (1, 'User@123', 'user test one', '2024-09-01', '31 B new York town', 36, 'Reading, Cricket', true, '2024-06-06 06:13:38.170116', 'Male', 'user1@gmail.com');
INSERT INTO "Public".users VALUES (2, 'Test2@123', 'user test two', '2015-03-03', 'A1 block pune', 2, 'Reading, Dancing, Painting, Surfing, Cricket', false, '2024-06-06 06:17:12.85126', 'Female', 'test2@gmail.com');


--
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 352
-- Name: cities_master_id_seq; Type: SEQUENCE SET; Schema: Public; Owner: pgiwstagadmin
--

SELECT pg_catalog.setval('"Public".cities_master_id_seq', 50, true);


--
-- TOC entry 4402 (class 0 OID 0)
-- Dependencies: 348
-- Name: countrie_master_id_seq; Type: SEQUENCE SET; Schema: Public; Owner: pgiwstagadmin
--

SELECT pg_catalog.setval('"Public".countrie_master_id_seq', 2, true);


--
-- TOC entry 4403 (class 0 OID 0)
-- Dependencies: 350
-- Name: state_master_id_seq; Type: SEQUENCE SET; Schema: Public; Owner: pgiwstagadmin
--

SELECT pg_catalog.setval('"Public".state_master_id_seq', 10, true);


--
-- TOC entry 4404 (class 0 OID 0)
-- Dependencies: 346
-- Name: usersmater_id_seq; Type: SEQUENCE SET; Schema: Public; Owner: pgiwstagadmin
--

SELECT pg_catalog.setval('"Public".usersmater_id_seq', 2, true);


-- Completed on 2024-06-05 22:23:47

--
-- PostgreSQL database dump complete
--

