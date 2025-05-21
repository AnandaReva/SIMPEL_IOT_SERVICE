--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Ubuntu 14.17-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.17 (Ubuntu 14.17-0ubuntu0.22.04.1)

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
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data (Community Edition)';


--
-- Name: device; Type: SCHEMA; Schema: -; Owner: revaananda
--

CREATE SCHEMA device;


ALTER SCHEMA device OWNER TO revaananda;

--
-- Name: sysfile; Type: SCHEMA; Schema: -; Owner: revaananda
--

CREATE SCHEMA sysfile;


ALTER SCHEMA sysfile OWNER TO revaananda;

--
-- Name: sysuser; Type: SCHEMA; Schema: -; Owner: revaananda
--

CREATE SCHEMA sysuser;


ALTER SCHEMA sysuser OWNER TO revaananda;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: data; Type: TABLE; Schema: device; Owner: revaananda
--

CREATE TABLE device.data (
    id bigint NOT NULL,
    unit_id bigint NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    voltage double precision NOT NULL,
    current double precision NOT NULL,
    power double precision NOT NULL,
    energy double precision NOT NULL,
    frequency double precision NOT NULL,
    power_factor double precision NOT NULL
);


ALTER TABLE device.data OWNER TO revaananda;

--
-- Name: _hyper_5_471_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_471_chunk (
    CONSTRAINT constraint_471 CHECK ((("timestamp" >= '2024-12-26 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-01-02 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_471_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_472_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_472_chunk (
    CONSTRAINT constraint_472 CHECK ((("timestamp" >= '2025-01-02 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-01-09 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_472_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_473_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_473_chunk (
    CONSTRAINT constraint_473 CHECK ((("timestamp" >= '2025-01-09 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-01-16 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_473_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_474_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_474_chunk (
    CONSTRAINT constraint_474 CHECK ((("timestamp" >= '2025-01-16 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-01-23 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_474_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_475_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_475_chunk (
    CONSTRAINT constraint_475 CHECK ((("timestamp" >= '2025-01-23 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-01-30 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_475_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_476_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_476_chunk (
    CONSTRAINT constraint_476 CHECK ((("timestamp" >= '2025-01-30 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-02-06 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_476_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_477_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_477_chunk (
    CONSTRAINT constraint_477 CHECK ((("timestamp" >= '2025-02-06 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-02-13 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_477_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_478_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_478_chunk (
    CONSTRAINT constraint_478 CHECK ((("timestamp" >= '2025-02-13 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-02-20 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_478_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_479_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_479_chunk (
    CONSTRAINT constraint_479 CHECK ((("timestamp" >= '2025-02-20 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-02-27 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_479_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_480_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_480_chunk (
    CONSTRAINT constraint_480 CHECK ((("timestamp" >= '2025-02-27 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-03-06 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_480_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_481_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_481_chunk (
    CONSTRAINT constraint_481 CHECK ((("timestamp" >= '2025-03-06 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-03-13 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_481_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_482_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_482_chunk (
    CONSTRAINT constraint_482 CHECK ((("timestamp" >= '2025-03-13 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-03-20 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_482_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_483_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_483_chunk (
    CONSTRAINT constraint_483 CHECK ((("timestamp" >= '2025-03-20 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-03-27 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_483_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_484_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_484_chunk (
    CONSTRAINT constraint_484 CHECK ((("timestamp" >= '2025-03-27 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-04-03 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_484_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_485_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_485_chunk (
    CONSTRAINT constraint_485 CHECK ((("timestamp" >= '2025-04-03 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-04-10 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_485_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_486_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_486_chunk (
    CONSTRAINT constraint_486 CHECK ((("timestamp" >= '2025-04-10 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-04-17 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_486_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_487_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_487_chunk (
    CONSTRAINT constraint_487 CHECK ((("timestamp" >= '2025-04-17 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-04-24 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_487_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_488_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_488_chunk (
    CONSTRAINT constraint_488 CHECK ((("timestamp" >= '2025-04-24 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-05-01 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_488_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_489_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_489_chunk (
    CONSTRAINT constraint_489 CHECK ((("timestamp" >= '2025-05-01 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-05-08 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_489_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_490_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_490_chunk (
    CONSTRAINT constraint_490 CHECK ((("timestamp" >= '2025-05-08 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-05-15 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_490_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_491_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_491_chunk (
    CONSTRAINT constraint_491 CHECK ((("timestamp" >= '2025-05-15 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-05-22 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_491_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_492_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_492_chunk (
    CONSTRAINT constraint_492 CHECK ((("timestamp" >= '2025-05-22 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-05-29 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_492_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_493_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_493_chunk (
    CONSTRAINT constraint_493 CHECK ((("timestamp" >= '2025-05-29 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-06-05 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_493_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_494_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_494_chunk (
    CONSTRAINT constraint_494 CHECK ((("timestamp" >= '2025-06-05 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-06-12 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_494_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_495_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_495_chunk (
    CONSTRAINT constraint_495 CHECK ((("timestamp" >= '2025-06-12 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-06-19 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_495_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_496_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_496_chunk (
    CONSTRAINT constraint_496 CHECK ((("timestamp" >= '2025-06-19 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-06-26 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_496_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_497_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_497_chunk (
    CONSTRAINT constraint_497 CHECK ((("timestamp" >= '2025-06-26 00:00:00'::timestamp without time zone) AND ("timestamp" < '2025-07-03 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_497_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_498_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_498_chunk (
    CONSTRAINT constraint_498 CHECK ((("timestamp" >= '2023-12-28 00:00:00'::timestamp without time zone) AND ("timestamp" < '2024-01-04 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_498_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_499_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_499_chunk (
    CONSTRAINT constraint_499 CHECK ((("timestamp" >= '2022-12-29 00:00:00'::timestamp without time zone) AND ("timestamp" < '2023-01-05 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_499_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_500_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_500_chunk (
    CONSTRAINT constraint_500 CHECK ((("timestamp" >= '2021-12-30 00:00:00'::timestamp without time zone) AND ("timestamp" < '2022-01-06 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_500_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_501_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_501_chunk (
    CONSTRAINT constraint_501 CHECK ((("timestamp" >= '2020-12-31 00:00:00'::timestamp without time zone) AND ("timestamp" < '2021-01-07 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_501_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_502_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_502_chunk (
    CONSTRAINT constraint_502 CHECK ((("timestamp" >= '2019-12-26 00:00:00'::timestamp without time zone) AND ("timestamp" < '2020-01-02 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_502_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_503_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_503_chunk (
    CONSTRAINT constraint_503 CHECK ((("timestamp" >= '2018-12-27 00:00:00'::timestamp without time zone) AND ("timestamp" < '2019-01-03 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_503_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_504_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_504_chunk (
    CONSTRAINT constraint_504 CHECK ((("timestamp" >= '2017-12-28 00:00:00'::timestamp without time zone) AND ("timestamp" < '2018-01-04 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_504_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_505_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_505_chunk (
    CONSTRAINT constraint_505 CHECK ((("timestamp" >= '2016-12-29 00:00:00'::timestamp without time zone) AND ("timestamp" < '2017-01-05 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_505_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_506_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_506_chunk (
    CONSTRAINT constraint_506 CHECK ((("timestamp" >= '2015-12-31 00:00:00'::timestamp without time zone) AND ("timestamp" < '2016-01-07 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_506_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_507_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_507_chunk (
    CONSTRAINT constraint_507 CHECK ((("timestamp" >= '2015-01-01 00:00:00'::timestamp without time zone) AND ("timestamp" < '2015-01-08 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_507_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_508_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_508_chunk (
    CONSTRAINT constraint_508 CHECK ((("timestamp" >= '2013-12-26 00:00:00'::timestamp without time zone) AND ("timestamp" < '2014-01-02 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_508_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_509_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_509_chunk (
    CONSTRAINT constraint_509 CHECK ((("timestamp" >= '2012-12-27 00:00:00'::timestamp without time zone) AND ("timestamp" < '2013-01-03 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_509_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_510_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_510_chunk (
    CONSTRAINT constraint_510 CHECK ((("timestamp" >= '2011-12-29 00:00:00'::timestamp without time zone) AND ("timestamp" < '2012-01-05 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_510_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_511_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_511_chunk (
    CONSTRAINT constraint_511 CHECK ((("timestamp" >= '2010-12-30 00:00:00'::timestamp without time zone) AND ("timestamp" < '2011-01-06 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_511_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_512_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_512_chunk (
    CONSTRAINT constraint_512 CHECK ((("timestamp" >= '2009-12-31 00:00:00'::timestamp without time zone) AND ("timestamp" < '2010-01-07 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_512_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_513_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_513_chunk (
    CONSTRAINT constraint_513 CHECK ((("timestamp" >= '2009-01-01 00:00:00'::timestamp without time zone) AND ("timestamp" < '2009-01-08 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_513_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_514_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_514_chunk (
    CONSTRAINT constraint_514 CHECK ((("timestamp" >= '2007-12-27 00:00:00'::timestamp without time zone) AND ("timestamp" < '2008-01-03 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_514_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_515_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_515_chunk (
    CONSTRAINT constraint_515 CHECK ((("timestamp" >= '2006-12-28 00:00:00'::timestamp without time zone) AND ("timestamp" < '2007-01-04 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_515_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_516_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_516_chunk (
    CONSTRAINT constraint_516 CHECK ((("timestamp" >= '2005-12-29 00:00:00'::timestamp without time zone) AND ("timestamp" < '2006-01-05 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_516_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_517_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_517_chunk (
    CONSTRAINT constraint_517 CHECK ((("timestamp" >= '2004-12-30 00:00:00'::timestamp without time zone) AND ("timestamp" < '2005-01-06 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_517_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_518_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_518_chunk (
    CONSTRAINT constraint_518 CHECK ((("timestamp" >= '2004-01-01 00:00:00'::timestamp without time zone) AND ("timestamp" < '2004-01-08 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_518_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_519_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_519_chunk (
    CONSTRAINT constraint_519 CHECK ((("timestamp" >= '2002-12-26 00:00:00'::timestamp without time zone) AND ("timestamp" < '2003-01-02 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_519_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_520_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_520_chunk (
    CONSTRAINT constraint_520 CHECK ((("timestamp" >= '2001-12-27 00:00:00'::timestamp without time zone) AND ("timestamp" < '2002-01-03 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_520_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_521_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_521_chunk (
    CONSTRAINT constraint_521 CHECK ((("timestamp" >= '2000-12-28 00:00:00'::timestamp without time zone) AND ("timestamp" < '2001-01-04 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_521_chunk OWNER TO revaananda;

--
-- Name: _hyper_5_522_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE TABLE _timescaledb_internal._hyper_5_522_chunk (
    CONSTRAINT constraint_522 CHECK ((("timestamp" >= '1999-12-30 00:00:00'::timestamp without time zone) AND ("timestamp" < '2000-01-06 00:00:00'::timestamp without time zone)))
)
INHERITS (device.data);


ALTER TABLE _timescaledb_internal._hyper_5_522_chunk OWNER TO revaananda;

--
-- Name: device_activity; Type: TABLE; Schema: device; Owner: revaananda
--

CREATE TABLE device.device_activity (
    id bigint NOT NULL,
    unit_id bigint NOT NULL,
    actor bigint,
    activity text NOT NULL,
    "timestamp" bigint DEFAULT (EXTRACT(epoch FROM now()))::bigint NOT NULL,
    before jsonb,
    after jsonb
);


ALTER TABLE device.device_activity OWNER TO revaananda;

--
-- Name: activity_id_seq; Type: SEQUENCE; Schema: device; Owner: revaananda
--

CREATE SEQUENCE device.activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device.activity_id_seq OWNER TO revaananda;

--
-- Name: activity_id_seq; Type: SEQUENCE OWNED BY; Schema: device; Owner: revaananda
--

ALTER SEQUENCE device.activity_id_seq OWNED BY device.device_activity.id;


--
-- Name: data2_id_seq; Type: SEQUENCE; Schema: device; Owner: revaananda
--

CREATE SEQUENCE device.data2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device.data2_id_seq OWNER TO revaananda;

--
-- Name: data2_id_seq; Type: SEQUENCE OWNED BY; Schema: device; Owner: revaananda
--

ALTER SEQUENCE device.data2_id_seq OWNED BY device.data.id;


--
-- Name: device_id_sq; Type: SEQUENCE; Schema: public; Owner: revaananda
--

CREATE SEQUENCE public.device_id_sq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_id_sq OWNER TO revaananda;

--
-- Name: unit; Type: TABLE; Schema: device; Owner: revaananda
--

CREATE TABLE device.unit (
    id bigint DEFAULT nextval('public.device_id_sq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    st integer NOT NULL,
    data jsonb NOT NULL,
    create_timestamp bigint DEFAULT (EXTRACT(epoch FROM now()))::bigint,
    last_timestamp bigint DEFAULT (EXTRACT(epoch FROM now()))::bigint,
    image bigint,
    read_interval integer NOT NULL,
    salted_password character varying(128) NOT NULL,
    salt character varying(32) NOT NULL
);


ALTER TABLE device.unit OWNER TO revaananda;

--
-- Name: file; Type: TABLE; Schema: sysfile; Owner: revaananda
--

CREATE TABLE sysfile.file (
    id bigint NOT NULL,
    "timestamp" bigint DEFAULT (EXTRACT(epoch FROM now()))::bigint NOT NULL,
    data text NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE sysfile.file OWNER TO revaananda;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: sysfile; Owner: revaananda
--

CREATE SEQUENCE sysfile.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sysfile.image_id_seq OWNER TO revaananda;

--
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: sysfile; Owner: revaananda
--

ALTER SEQUENCE sysfile.image_id_seq OWNED BY sysfile.file.id;


--
-- Name: session; Type: TABLE; Schema: sysuser; Owner: revaananda
--

CREATE TABLE sysuser.session (
    session_id character varying(16) NOT NULL,
    user_id bigint NOT NULL,
    session_hash character varying(128) NOT NULL,
    tstamp bigint NOT NULL,
    st integer NOT NULL
);


ALTER TABLE sysuser.session OWNER TO revaananda;

--
-- Name: token; Type: TABLE; Schema: sysuser; Owner: revaananda
--

CREATE TABLE sysuser.token (
    user_id bigint NOT NULL,
    token character varying(128) NOT NULL,
    tstamp bigint NOT NULL
);


ALTER TABLE sysuser.token OWNER TO revaananda;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: sysuser; Owner: revaananda
--

CREATE SEQUENCE sysuser.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sysuser.user_id_seq OWNER TO revaananda;

--
-- Name: user; Type: TABLE; Schema: sysuser; Owner: revaananda
--

CREATE TABLE sysuser."user" (
    username character varying(225) NOT NULL,
    full_name character varying(255) NOT NULL,
    st integer NOT NULL,
    salt character varying(64) NOT NULL,
    saltedpassword character varying(128) NOT NULL,
    data jsonb NOT NULL,
    id bigint DEFAULT nextval('sysuser.user_id_seq'::regclass) NOT NULL,
    role character varying(128) NOT NULL,
    email character varying(255) NOT NULL,
    create_timestamp bigint DEFAULT (EXTRACT(epoch FROM now()))::bigint NOT NULL,
    last_timestamp bigint DEFAULT (EXTRACT(epoch FROM now()))::bigint NOT NULL
);


ALTER TABLE sysuser."user" OWNER TO revaananda;

--
-- Name: _hyper_5_471_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_471_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_471_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_471_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_472_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_472_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_472_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_472_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_473_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_473_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_473_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_473_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_474_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_474_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_474_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_474_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_475_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_475_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_475_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_475_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_476_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_476_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_476_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_476_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_477_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_477_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_477_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_477_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_478_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_478_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_478_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_478_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_479_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_479_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_479_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_479_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_480_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_480_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_480_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_480_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_481_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_481_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_481_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_481_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_482_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_482_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_482_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_482_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_483_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_483_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_483_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_483_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_484_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_484_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_484_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_484_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_485_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_485_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_485_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_485_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_486_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_486_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_486_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_486_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_487_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_487_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_487_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_487_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_488_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_488_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_488_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_488_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_489_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_489_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_489_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_489_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_490_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_490_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_490_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_490_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_491_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_491_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_491_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_491_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_492_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_492_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_492_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_492_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_493_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_493_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_493_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_493_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_494_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_494_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_494_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_494_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_495_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_495_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_495_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_495_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_496_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_496_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_496_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_496_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_497_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_497_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_497_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_497_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_498_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_498_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_498_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_498_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_499_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_499_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_499_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_499_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_500_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_500_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_500_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_500_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_501_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_501_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_501_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_501_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_502_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_502_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_502_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_502_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_503_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_503_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_503_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_503_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_504_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_504_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_504_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_504_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_505_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_505_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_505_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_505_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_506_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_506_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_506_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_506_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_507_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_507_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_507_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_507_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_508_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_508_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_508_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_508_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_509_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_509_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_509_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_509_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_510_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_510_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_510_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_510_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_511_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_511_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_511_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_511_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_512_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_512_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_512_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_512_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_513_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_513_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_513_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_513_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_514_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_514_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_514_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_514_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_515_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_515_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_515_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_515_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_516_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_516_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_516_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_516_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_517_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_517_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_517_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_517_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_518_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_518_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_518_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_518_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_519_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_519_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_519_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_519_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_520_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_520_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_520_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_520_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_521_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_521_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_521_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_521_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: _hyper_5_522_chunk id; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_522_chunk ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: _hyper_5_522_chunk timestamp; Type: DEFAULT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_522_chunk ALTER COLUMN "timestamp" SET DEFAULT now();


--
-- Name: data id; Type: DEFAULT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.data ALTER COLUMN id SET DEFAULT nextval('device.data2_id_seq'::regclass);


--
-- Name: device_activity id; Type: DEFAULT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.device_activity ALTER COLUMN id SET DEFAULT nextval('device.activity_id_seq'::regclass);


--
-- Name: file id; Type: DEFAULT; Schema: sysfile; Owner: revaananda
--

ALTER TABLE ONLY sysfile.file ALTER COLUMN id SET DEFAULT nextval('sysfile.image_id_seq'::regclass);


--
-- Name: device_activity activity_pkey; Type: CONSTRAINT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.device_activity
    ADD CONSTRAINT activity_pkey PRIMARY KEY (id);


--
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (id);


--
-- Name: unit uq_device_unit_name; Type: CONSTRAINT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.unit
    ADD CONSTRAINT uq_device_unit_name UNIQUE (name);


--
-- Name: file image_pkey; Type: CONSTRAINT; Schema: sysfile; Owner: revaananda
--

ALTER TABLE ONLY sysfile.file
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: sysuser; Owner: revaananda
--

ALTER TABLE ONLY sysuser.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (session_id);


--
-- Name: session session_user_id_key; Type: CONSTRAINT; Schema: sysuser; Owner: revaananda
--

ALTER TABLE ONLY sysuser.session
    ADD CONSTRAINT session_user_id_key UNIQUE (user_id);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: sysuser; Owner: revaananda
--

ALTER TABLE ONLY sysuser.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (user_id, token);


--
-- Name: user unique_email; Type: CONSTRAINT; Schema: sysuser; Owner: revaananda
--

ALTER TABLE ONLY sysuser."user"
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: token unique_user_id; Type: CONSTRAINT; Schema: sysuser; Owner: revaananda
--

ALTER TABLE ONLY sysuser.token
    ADD CONSTRAINT unique_user_id UNIQUE (user_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: sysuser; Owner: revaananda
--

ALTER TABLE ONLY sysuser."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_unique_name; Type: CONSTRAINT; Schema: sysuser; Owner: revaananda
--

ALTER TABLE ONLY sysuser."user"
    ADD CONSTRAINT user_unique_name UNIQUE (username);


--
-- Name: _hyper_5_471_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_471_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_471_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_471_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_471_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_471_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_471_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_471_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_471_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_471_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_471_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_471_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_472_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_472_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_472_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_472_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_472_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_472_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_472_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_472_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_472_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_472_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_472_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_472_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_473_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_473_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_473_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_473_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_473_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_473_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_473_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_473_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_473_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_473_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_473_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_473_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_474_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_474_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_474_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_474_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_474_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_474_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_474_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_474_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_474_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_474_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_474_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_474_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_475_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_475_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_475_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_475_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_475_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_475_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_475_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_475_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_475_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_475_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_475_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_475_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_476_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_476_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_476_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_476_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_476_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_476_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_476_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_476_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_476_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_476_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_476_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_476_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_477_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_477_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_477_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_477_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_477_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_477_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_477_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_477_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_477_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_477_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_477_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_477_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_478_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_478_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_478_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_478_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_478_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_478_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_478_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_478_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_478_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_478_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_478_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_478_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_479_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_479_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_479_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_479_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_479_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_479_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_479_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_479_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_479_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_479_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_479_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_479_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_480_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_480_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_480_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_480_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_480_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_480_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_480_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_480_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_480_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_480_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_480_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_480_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_481_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_481_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_481_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_481_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_481_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_481_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_481_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_481_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_481_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_481_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_481_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_481_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_482_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_482_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_482_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_482_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_482_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_482_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_482_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_482_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_482_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_482_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_482_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_482_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_483_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_483_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_483_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_483_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_483_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_483_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_483_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_483_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_483_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_483_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_483_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_483_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_484_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_484_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_484_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_484_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_484_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_484_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_484_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_484_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_484_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_484_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_484_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_484_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_485_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_485_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_485_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_485_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_485_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_485_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_485_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_485_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_485_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_485_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_485_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_485_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_486_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_486_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_486_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_486_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_486_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_486_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_486_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_486_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_486_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_486_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_486_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_486_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_487_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_487_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_487_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_487_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_487_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_487_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_487_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_487_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_487_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_487_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_487_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_487_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_488_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_488_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_488_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_488_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_488_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_488_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_488_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_488_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_488_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_488_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_488_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_488_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_489_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_489_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_489_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_489_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_489_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_489_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_489_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_489_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_489_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_489_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_489_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_489_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_490_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_490_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_490_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_490_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_490_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_490_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_490_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_490_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_490_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_490_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_490_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_490_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_491_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_491_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_491_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_491_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_491_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_491_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_491_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_491_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_491_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_491_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_491_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_491_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_492_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_492_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_492_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_492_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_492_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_492_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_492_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_492_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_492_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_492_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_492_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_492_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_493_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_493_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_493_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_493_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_493_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_493_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_493_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_493_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_493_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_493_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_493_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_493_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_494_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_494_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_494_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_494_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_494_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_494_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_494_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_494_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_494_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_494_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_494_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_494_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_495_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_495_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_495_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_495_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_495_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_495_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_495_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_495_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_495_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_495_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_495_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_495_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_496_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_496_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_496_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_496_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_496_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_496_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_496_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_496_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_496_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_496_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_496_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_496_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_497_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_497_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_497_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_497_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_497_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_497_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_497_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_497_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_497_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_497_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_497_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_497_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_498_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_498_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_498_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_498_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_498_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_498_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_498_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_498_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_498_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_498_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_498_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_498_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_499_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_499_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_499_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_499_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_499_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_499_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_499_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_499_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_499_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_499_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_499_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_499_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_500_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_500_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_500_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_500_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_500_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_500_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_500_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_500_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_500_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_500_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_500_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_500_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_501_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_501_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_501_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_501_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_501_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_501_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_501_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_501_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_501_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_501_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_501_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_501_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_502_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_502_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_502_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_502_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_502_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_502_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_502_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_502_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_502_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_502_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_502_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_502_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_503_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_503_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_503_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_503_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_503_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_503_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_503_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_503_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_503_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_503_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_503_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_503_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_504_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_504_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_504_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_504_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_504_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_504_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_504_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_504_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_504_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_504_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_504_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_504_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_505_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_505_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_505_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_505_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_505_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_505_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_505_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_505_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_505_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_505_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_505_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_505_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_506_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_506_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_506_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_506_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_506_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_506_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_506_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_506_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_506_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_506_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_506_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_506_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_507_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_507_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_507_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_507_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_507_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_507_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_507_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_507_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_507_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_507_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_507_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_507_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_508_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_508_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_508_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_508_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_508_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_508_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_508_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_508_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_508_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_508_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_508_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_508_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_509_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_509_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_509_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_509_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_509_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_509_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_509_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_509_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_509_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_509_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_509_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_509_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_510_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_510_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_510_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_510_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_510_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_510_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_510_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_510_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_510_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_510_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_510_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_510_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_511_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_511_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_511_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_511_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_511_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_511_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_511_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_511_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_511_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_511_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_511_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_511_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_512_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_512_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_512_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_512_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_512_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_512_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_512_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_512_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_512_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_512_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_512_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_512_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_513_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_513_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_513_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_513_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_513_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_513_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_513_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_513_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_513_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_513_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_513_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_513_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_514_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_514_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_514_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_514_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_514_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_514_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_514_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_514_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_514_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_514_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_514_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_514_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_515_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_515_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_515_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_515_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_515_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_515_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_515_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_515_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_515_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_515_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_515_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_515_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_516_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_516_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_516_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_516_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_516_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_516_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_516_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_516_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_516_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_516_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_516_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_516_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_517_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_517_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_517_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_517_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_517_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_517_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_517_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_517_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_517_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_517_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_517_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_517_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_518_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_518_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_518_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_518_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_518_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_518_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_518_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_518_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_518_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_518_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_518_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_518_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_519_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_519_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_519_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_519_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_519_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_519_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_519_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_519_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_519_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_519_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_519_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_519_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_520_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_520_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_520_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_520_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_520_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_520_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_520_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_520_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_520_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_520_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_520_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_520_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_521_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_521_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_521_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_521_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_521_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_521_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_521_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_521_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_521_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_521_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_521_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_521_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: _hyper_5_522_chunk_data_tstamp_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_522_chunk_data_tstamp_idx ON _timescaledb_internal._hyper_5_522_chunk USING btree ("timestamp" DESC);


--
-- Name: _hyper_5_522_chunk_data_unique_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE UNIQUE INDEX _hyper_5_522_chunk_data_unique_idx ON _timescaledb_internal._hyper_5_522_chunk USING btree (id, "timestamp");


--
-- Name: _hyper_5_522_chunk_idx_data_unit_id_timestamp; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_522_chunk_idx_data_unit_id_timestamp ON _timescaledb_internal._hyper_5_522_chunk USING btree (unit_id, "timestamp" DESC);


--
-- Name: _hyper_5_522_chunk_idx_data_unit_year; Type: INDEX; Schema: _timescaledb_internal; Owner: revaananda
--

CREATE INDEX _hyper_5_522_chunk_idx_data_unit_year ON _timescaledb_internal._hyper_5_522_chunk USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: data_tstamp_idx; Type: INDEX; Schema: device; Owner: revaananda
--

CREATE INDEX data_tstamp_idx ON device.data USING btree ("timestamp" DESC);


--
-- Name: data_unique_idx; Type: INDEX; Schema: device; Owner: revaananda
--

CREATE UNIQUE INDEX data_unique_idx ON device.data USING btree (id, "timestamp");


--
-- Name: idx_data_unit_id_timestamp; Type: INDEX; Schema: device; Owner: revaananda
--

CREATE INDEX idx_data_unit_id_timestamp ON device.data USING btree (unit_id, "timestamp" DESC);


--
-- Name: idx_data_unit_year; Type: INDEX; Schema: device; Owner: revaananda
--

CREATE INDEX idx_data_unit_year ON device.data USING btree (unit_id, EXTRACT(year FROM "timestamp"));


--
-- Name: idx_device_name; Type: INDEX; Schema: device; Owner: revaananda
--

CREATE INDEX idx_device_name ON device.unit USING btree (name);


--
-- Name: data ts_insert_blocker; Type: TRIGGER; Schema: device; Owner: revaananda
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON device.data FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _hyper_5_471_chunk 471_471_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_471_chunk
    ADD CONSTRAINT "471_471_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_472_chunk 472_472_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_472_chunk
    ADD CONSTRAINT "472_472_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_473_chunk 473_473_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_473_chunk
    ADD CONSTRAINT "473_473_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_474_chunk 474_474_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_474_chunk
    ADD CONSTRAINT "474_474_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_475_chunk 475_475_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_475_chunk
    ADD CONSTRAINT "475_475_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_476_chunk 476_476_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_476_chunk
    ADD CONSTRAINT "476_476_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_477_chunk 477_477_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_477_chunk
    ADD CONSTRAINT "477_477_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_478_chunk 478_478_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_478_chunk
    ADD CONSTRAINT "478_478_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_479_chunk 479_479_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_479_chunk
    ADD CONSTRAINT "479_479_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_480_chunk 480_480_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_480_chunk
    ADD CONSTRAINT "480_480_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_481_chunk 481_481_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_481_chunk
    ADD CONSTRAINT "481_481_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_482_chunk 482_482_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_482_chunk
    ADD CONSTRAINT "482_482_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_483_chunk 483_483_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_483_chunk
    ADD CONSTRAINT "483_483_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_484_chunk 484_484_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_484_chunk
    ADD CONSTRAINT "484_484_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_485_chunk 485_485_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_485_chunk
    ADD CONSTRAINT "485_485_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_486_chunk 486_486_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_486_chunk
    ADD CONSTRAINT "486_486_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_487_chunk 487_487_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_487_chunk
    ADD CONSTRAINT "487_487_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_488_chunk 488_488_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_488_chunk
    ADD CONSTRAINT "488_488_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_489_chunk 489_489_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_489_chunk
    ADD CONSTRAINT "489_489_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_490_chunk 490_490_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_490_chunk
    ADD CONSTRAINT "490_490_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_491_chunk 491_491_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_491_chunk
    ADD CONSTRAINT "491_491_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_492_chunk 492_492_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_492_chunk
    ADD CONSTRAINT "492_492_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_493_chunk 493_493_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_493_chunk
    ADD CONSTRAINT "493_493_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_494_chunk 494_494_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_494_chunk
    ADD CONSTRAINT "494_494_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_495_chunk 495_495_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_495_chunk
    ADD CONSTRAINT "495_495_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_496_chunk 496_496_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_496_chunk
    ADD CONSTRAINT "496_496_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_497_chunk 497_497_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_497_chunk
    ADD CONSTRAINT "497_497_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_498_chunk 498_498_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_498_chunk
    ADD CONSTRAINT "498_498_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_499_chunk 499_499_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_499_chunk
    ADD CONSTRAINT "499_499_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_500_chunk 500_500_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_500_chunk
    ADD CONSTRAINT "500_500_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_501_chunk 501_501_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_501_chunk
    ADD CONSTRAINT "501_501_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_502_chunk 502_502_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_502_chunk
    ADD CONSTRAINT "502_502_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_503_chunk 503_503_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_503_chunk
    ADD CONSTRAINT "503_503_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_504_chunk 504_504_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_504_chunk
    ADD CONSTRAINT "504_504_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_505_chunk 505_505_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_505_chunk
    ADD CONSTRAINT "505_505_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_506_chunk 506_506_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_506_chunk
    ADD CONSTRAINT "506_506_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_507_chunk 507_507_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_507_chunk
    ADD CONSTRAINT "507_507_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_508_chunk 508_508_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_508_chunk
    ADD CONSTRAINT "508_508_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_509_chunk 509_509_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_509_chunk
    ADD CONSTRAINT "509_509_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_510_chunk 510_510_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_510_chunk
    ADD CONSTRAINT "510_510_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_511_chunk 511_511_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_511_chunk
    ADD CONSTRAINT "511_511_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_512_chunk 512_512_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_512_chunk
    ADD CONSTRAINT "512_512_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_513_chunk 513_513_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_513_chunk
    ADD CONSTRAINT "513_513_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_514_chunk 514_514_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_514_chunk
    ADD CONSTRAINT "514_514_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_515_chunk 515_515_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_515_chunk
    ADD CONSTRAINT "515_515_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_516_chunk 516_516_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_516_chunk
    ADD CONSTRAINT "516_516_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_517_chunk 517_517_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_517_chunk
    ADD CONSTRAINT "517_517_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_518_chunk 518_518_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_518_chunk
    ADD CONSTRAINT "518_518_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_519_chunk 519_519_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_519_chunk
    ADD CONSTRAINT "519_519_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_520_chunk 520_520_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_520_chunk
    ADD CONSTRAINT "520_520_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_521_chunk 521_521_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_521_chunk
    ADD CONSTRAINT "521_521_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: _hyper_5_522_chunk 522_522_fk_unit; Type: FK CONSTRAINT; Schema: _timescaledb_internal; Owner: revaananda
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_522_chunk
    ADD CONSTRAINT "522_522_fk_unit" FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: unit fk_attachment; Type: FK CONSTRAINT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.unit
    ADD CONSTRAINT fk_attachment FOREIGN KEY (image) REFERENCES sysfile.file(id) ON DELETE SET NULL;


--
-- Name: data fk_unit; Type: FK CONSTRAINT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.data
    ADD CONSTRAINT fk_unit FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: device_activity fk_unit; Type: FK CONSTRAINT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.device_activity
    ADD CONSTRAINT fk_unit FOREIGN KEY (unit_id) REFERENCES device.unit(id) ON DELETE CASCADE;


--
-- Name: device_activity fk_user; Type: FK CONSTRAINT; Schema: device; Owner: revaananda
--

ALTER TABLE ONLY device.device_activity
    ADD CONSTRAINT fk_user FOREIGN KEY (actor) REFERENCES sysuser."user"(id) ON DELETE SET NULL;


--
-- Name: token fk_user_id; Type: FK CONSTRAINT; Schema: sysuser; Owner: revaananda
--

ALTER TABLE ONLY sysuser.token
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES sysuser."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

