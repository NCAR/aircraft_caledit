--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.calibrations DROP CONSTRAINT calibrations_rid_key;
DROP TABLE public.calibrations;
DROP FUNCTION public.dblink_open(text, text, text, boolean);
DROP FUNCTION public.dblink_open(text, text, text);
DROP FUNCTION public.dblink_open(text, text, boolean);
DROP FUNCTION public.dblink_open(text, text);
DROP FUNCTION public.dblink_get_pkey(text);
DROP FUNCTION public.dblink_fetch(text, text, integer, boolean);
DROP FUNCTION public.dblink_fetch(text, text, integer);
DROP FUNCTION public.dblink_fetch(text, integer, boolean);
DROP FUNCTION public.dblink_fetch(text, integer);
DROP FUNCTION public.dblink_exec(text, boolean);
DROP FUNCTION public.dblink_exec(text);
DROP FUNCTION public.dblink_exec(text, text, boolean);
DROP FUNCTION public.dblink_exec(text, text);
DROP FUNCTION public.dblink_disconnect(text);
DROP FUNCTION public.dblink_disconnect();
DROP FUNCTION public.dblink_current_query();
DROP FUNCTION public.dblink_connect_u(text, text);
DROP FUNCTION public.dblink_connect_u(text);
DROP FUNCTION public.dblink_connect(text, text);
DROP FUNCTION public.dblink_connect(text);
DROP FUNCTION public.dblink_close(text, text, boolean);
DROP FUNCTION public.dblink_close(text, text);
DROP FUNCTION public.dblink_close(text, boolean);
DROP FUNCTION public.dblink_close(text);
DROP FUNCTION public.dblink_build_sql_update(text, int2vector, integer, text[], text[]);
DROP FUNCTION public.dblink_build_sql_insert(text, int2vector, integer, text[], text[]);
DROP FUNCTION public.dblink_build_sql_delete(text, int2vector, integer, text[]);
DROP FUNCTION public.dblink(text, boolean);
DROP FUNCTION public.dblink(text);
DROP FUNCTION public.dblink(text, text, boolean);
DROP FUNCTION public.dblink(text, text);
DROP FUNCTION public.add(integer, integer);
DROP TYPE public.dblink_pkey_results;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


SET search_path = public, pg_catalog;

--
-- Name: dblink_pkey_results; Type: TYPE; Schema: public; Owner: ads
--

CREATE TYPE dblink_pkey_results AS (
	"position" integer,
	colname text
);


ALTER TYPE public.dblink_pkey_results OWNER TO ads;

--
-- Name: add(integer, integer); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION add(integer, integer) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1 + $2;$_$;


ALTER FUNCTION public.add(integer, integer) OWNER TO ads;

--
-- Name: dblink(text, text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink(text, text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, text) OWNER TO ads;

--
-- Name: dblink(text, text, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink(text, text, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, text, boolean) OWNER TO ads;

--
-- Name: dblink(text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink(text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text) OWNER TO ads;

--
-- Name: dblink(text, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink(text, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, boolean) OWNER TO ads;

--
-- Name: dblink_build_sql_delete(text, int2vector, integer, text[]); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_build_sql_delete(text, int2vector, integer, text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_delete';


ALTER FUNCTION public.dblink_build_sql_delete(text, int2vector, integer, text[]) OWNER TO ads;

--
-- Name: dblink_build_sql_insert(text, int2vector, integer, text[], text[]); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_build_sql_insert(text, int2vector, integer, text[], text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_insert';


ALTER FUNCTION public.dblink_build_sql_insert(text, int2vector, integer, text[], text[]) OWNER TO ads;

--
-- Name: dblink_build_sql_update(text, int2vector, integer, text[], text[]); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_build_sql_update(text, int2vector, integer, text[], text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_update';


ALTER FUNCTION public.dblink_build_sql_update(text, int2vector, integer, text[], text[]) OWNER TO ads;

--
-- Name: dblink_close(text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_close(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text) OWNER TO ads;

--
-- Name: dblink_close(text, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_close(text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, boolean) OWNER TO ads;

--
-- Name: dblink_close(text, text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_close(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, text) OWNER TO ads;

--
-- Name: dblink_close(text, text, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_close(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, text, boolean) OWNER TO ads;

--
-- Name: dblink_connect(text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_connect(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect(text) OWNER TO ads;

--
-- Name: dblink_connect(text, text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_connect(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect(text, text) OWNER TO ads;

--
-- Name: dblink_connect_u(text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_connect_u(text) RETURNS text
    LANGUAGE c STRICT SECURITY DEFINER
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect_u(text) OWNER TO ads;

--
-- Name: dblink_connect_u(text, text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_connect_u(text, text) RETURNS text
    LANGUAGE c STRICT SECURITY DEFINER
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect_u(text, text) OWNER TO ads;

--
-- Name: dblink_current_query(); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_current_query() RETURNS text
    LANGUAGE c
    AS '$libdir/dblink', 'dblink_current_query';


ALTER FUNCTION public.dblink_current_query() OWNER TO ads;

--
-- Name: dblink_disconnect(); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_disconnect() RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_disconnect';


ALTER FUNCTION public.dblink_disconnect() OWNER TO ads;

--
-- Name: dblink_disconnect(text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_disconnect(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_disconnect';


ALTER FUNCTION public.dblink_disconnect(text) OWNER TO ads;

--
-- Name: dblink_exec(text, text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_exec(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, text) OWNER TO ads;

--
-- Name: dblink_exec(text, text, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_exec(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, text, boolean) OWNER TO ads;

--
-- Name: dblink_exec(text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_exec(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text) OWNER TO ads;

--
-- Name: dblink_exec(text, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_exec(text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, boolean) OWNER TO ads;

--
-- Name: dblink_fetch(text, integer); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_fetch(text, integer) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, integer) OWNER TO ads;

--
-- Name: dblink_fetch(text, integer, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_fetch(text, integer, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, integer, boolean) OWNER TO ads;

--
-- Name: dblink_fetch(text, text, integer); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_fetch(text, text, integer) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, text, integer) OWNER TO ads;

--
-- Name: dblink_fetch(text, text, integer, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_fetch(text, text, integer, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, text, integer, boolean) OWNER TO ads;

--
-- Name: dblink_get_pkey(text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_get_pkey(text) RETURNS SETOF dblink_pkey_results
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_get_pkey';


ALTER FUNCTION public.dblink_get_pkey(text) OWNER TO ads;

--
-- Name: dblink_open(text, text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_open(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text) OWNER TO ads;

--
-- Name: dblink_open(text, text, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_open(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, boolean) OWNER TO ads;

--
-- Name: dblink_open(text, text, text); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_open(text, text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, text) OWNER TO ads;

--
-- Name: dblink_open(text, text, text, boolean); Type: FUNCTION; Schema: public; Owner: ads
--

CREATE FUNCTION dblink_open(text, text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, text, boolean) OWNER TO ads;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: calibrations; Type: TABLE; Schema: public; Owner: ads; Tablespace: 
--

CREATE TABLE calibrations (
    rid character(36) NOT NULL,
    pid character(36),
    site character varying(20),
    pulled character(1),
    removed character(1),
    exported character(1),
    cal_date timestamp without time zone,
    project_name character varying(32),
    username character varying(32),
    sensor_type character varying(20),
    serial_number character varying(20),
    var_name character varying(20),
    dsm_name character varying(16),
    cal_type character varying(16),
    channel character(1),
    gainbplr character(2),
    ads_file_name character varying(200),
    set_times timestamp without time zone[],
    set_points double precision[],
    averages double precision[],
    stddevs double precision[],
    cal double precision[],
    temperature double precision,
    comment character varying(256)
);


ALTER TABLE public.calibrations OWNER TO ads;

--
-- Data for Name: calibrations; Type: TABLE DATA; Schema: public; Owner: ads
--

INSERT INTO calibrations VALUES ('88f47d3f-d98e-41ad-b90a-a4bd37bf50d5', '                                    ', 'Lab_FL1', '1', '0', '1', '2013-01-07 10:51:00', 'SAANGRIA-TEST', 'wasinger', 'Heated', '812452B', 'TT_BATH', '', 'bath', '1', '  ', '/home/local/projects/Configuration/raf/cal_files/Bath/RAF_01072013', '{}', '{29.870000000000001,19.879000000000001,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{55.93,53.960000000000001,51.985999999999997,50.003999999999998,48.018000000000001,46.024000000000001,44.024999999999999,42.018999999999998,40.006,37.987000000000002}', '{9.7999999999999997e-05,0.00026200000000000003,0.000232,0.000292,0.00025500000000000002,0.00024600000000000002,0.000147,0.000174,0.00017899999999999999,0.00026400000000000002}', '{50.023299999999999,0.19867099999999999,-3.1136300000000002e-05}', 'NaN', 'Temperature Calibration');
INSERT INTO calibrations VALUES ('1d2615a1-66ea-43cd-879a-754656791fa3', '                                    ', 'Lab_FL1', '1', '0', '1', '2013-01-07 10:51:00', 'SAANGRIA-TEST', 'wasinger', 'Heated', '812452A', 'TT_BATH', '', 'bath', '0', '  ', '/home/local/projects/Configuration/raf/cal_files/Bath/RAF_01072013', '{}', '{29.870000000000001,19.879000000000001,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{55.939999999999998,53.970999999999997,51.997,50.015999999999998,48.030000000000001,46.036999999999999,44.037999999999997,42.031999999999996,40.018999999999998,38}', '{9.3999999999999994e-05,0.000263,0.00023000000000000001,0.00028600000000000001,0.00025399999999999999,0.00025099999999999998,0.000147,0.00017000000000000001,0.00018599999999999999,0.00026200000000000003}', '{50.035200000000003,0.19862299999999999,-3.16299e-05}', 'NaN', 'Temperature Calibration');
INSERT INTO calibrations VALUES ('e20bed8f-3aff-46dd-8691-a3dd0d358977', '                                    ', 'Lab_FL1', '1', '0', '1', '2013-01-07 10:51:00', 'SAANGRIA-TEST', 'wasinger', 'FastResp', '3109', 'TT_BATH', '', 'bath', '2', '  ', '/home/local/projects/Configuration/raf/cal_files/Bath/RAF_01072013', '{}', '{29.870000000000001,19.879000000000001,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{55.128,53.261000000000003,51.387999999999998,49.509999999999998,47.625999999999998,45.734999999999999,43.840000000000003,41.939,40.030999999999999,38.116}', '{6.0000000000000002e-05,0.00027599999999999999,0.000243,0.00029399999999999999,0.000194,0.000223,0.00014100000000000001,0.00024699999999999999,0.00013200000000000001,0.00023000000000000001}', '{49.527500000000003,0.18837499999999999,-2.91357e-05}', 'NaN', 'Temperature Calibration');
INSERT INTO calibrations VALUES ('7789350d-7d3f-48f4-8ed9-adf1790aa4bd', 'e20bed8f-3aff-46dd-8691-a3dd0d358977', 'GV_N677F', '1', '0', '0', '2013-01-30 22:43:06', 'SAANGRIA-TEST', 'DEA', 'Rosemount', '3109', 'TTRL', '305', 'instrument', '1', '4F', '20130130_160821_Jan30.ads', '{"2013-01-30 22:16:55.99","2013-01-30 22:17:33.99","2013-01-30 22:19:35.99","2013-01-30 22:21:13.99","2013-01-30 22:23:15.99","2013-01-30 22:26:05.99","2013-01-30 22:27:35.99","2013-01-30 22:30:21.99","2013-01-30 22:38:45.99","2013-01-30 22:40:08.99"}', '{-60.020000000000003,-50.030000000000001,-40.036999999999999,-30.050000000000001,-20.067,-10.079000000000001,-0.098000000000000004,9.8930000000000007,19.878,29.870000000000001}', '{0.93645999999999996,1.3100000000000001,1.6794,2.0457000000000001,2.407,2.7673999999999999,3.1215999999999999,3.4710999999999999,3.8155999999999999,4.1589999999999998}', '{6.9955000000000004e-05,6.7935999999999995e-05,5.6110000000000003e-05,8.1431e-05,7.5091000000000003e-05,8.1726999999999999e-05,8.2397000000000004e-05,7.6940999999999994e-05,8.6904999999999995e-05,9.3925000000000006e-05}', '{-84.411600000000007,25.6768,0.432085}', 'NaN', '');
INSERT INTO calibrations VALUES ('398526b2-a9b5-49f7-934b-9179cd4fcd5d', '1d2615a1-66ea-43cd-879a-754656791fa3', 'GV_N677F', '1', '0', '0', '2013-01-30 23:03:26', 'SAANGRIA-TEST', 'DEA', 'Harco Temp', '812452A', 'TTHR1', '305', 'instrument', '3', '4F', '20130130_221336_cf01.ads', '{"2013-01-30 22:54:53.99","2013-01-30 22:55:26.99","2013-01-30 22:56:04.99","2013-01-30 22:56:32.99","2013-01-30 23:00:33.99","2013-01-30 22:59:00.99","2013-01-30 22:59:54.99","2013-01-30 23:01:02.99","2013-01-30 23:01:32.99","2013-01-30 23:02:08.99"}', '{-60.020000000000003,-50.030000000000001,-40.036999999999999,-30.050000000000001,-20.067,-10.079000000000001,-0.098000000000000004,9.8930000000000007,19.878,29.870000000000001}', '{0.97567999999999999,1.4037999999999999,1.8269,2.2458999999999998,2.6602999999999999,3.0705,3.4762,3.8782999999999999,4.2759,4.6710000000000003}', '{6.2700999999999995e-05,5.7300999999999999e-05,7.4641000000000006e-05,0.00010712,5.7136999999999999e-05,5.5084999999999999e-05,6.7484000000000006e-05,0.00010635,6.3348000000000004e-05,6.5172999999999994e-05}', '{-82.372399999999999,22.6157,0.30291099999999999}', 'NaN', '');
INSERT INTO calibrations VALUES ('8f5a627c-7616-4394-b6c6-592931212a63', '88f47d3f-d98e-41ad-b90a-a4bd37bf50d5', 'GV_N677F', '1', '0', '0', '2013-01-30 23:09:25', 'SAANGRIA-TEST', 'DEA', 'Heated Rosemount GV', '812452B', 'TTHR2', '305', 'instrument', '2', '4F', '20130130_221336_cf01.ads', '{"2013-01-30 23:04:58.99","2013-01-30 23:05:27.99","2013-01-30 23:05:51.99","2013-01-30 23:06:17.99","2013-01-30 23:06:37.99","2013-01-30 23:06:59.99","2013-01-30 23:07:19.99","2013-01-30 23:07:44.99","2013-01-30 23:08:08.99","2013-01-30 23:08:31.99"}', '{29.870000000000001,19.878,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{4.6643999999999997,4.2706999999999997,3.8721999999999999,3.4702000000000002,3.0644,2.6537999999999999,2.2393999999999998,1.8205,1.3972,0.96931999999999996}', '{0.00023881,6.2624000000000002e-05,8.2344999999999998e-05,6.9066999999999994e-05,5.0175e-05,6.6084e-05,5.7389999999999998e-05,6.4051000000000001e-05,0.0001192,5.7237000000000001e-05}', '{-82.217699999999994,22.613399999999999,0.303286}', 'NaN', '');
INSERT INTO calibrations VALUES ('c9b23cc9-bb52-49d9-bf6f-2a38fafe9321', '                                    ', 'Lab_FL1', '1', '0', '1', '2013-02-06 07:11:00', 'NOMADSS', 'wasinger', 'Heated', '812453B', 'TT_BATH', '', 'bath', '1', '  ', '/net/jlocal/projects/Configuration/raf/cal_files/Bath/RAF_02062013', '{}', '{29.867999999999999,19.878,9.8940000000000001,-0.096000000000000002,-10.08,-20.068999999999999,-30.050000000000001,-40.036000000000001,-50.031999999999996,-60.018999999999998}', '{55.917000000000002,53.948,51.973999999999997,49.993000000000002,48.006,46.012,44.014000000000003,42.009,39.994999999999997,37.975999999999999}', '{2.1999999999999999e-05,0.00012999999999999999,0.000115,0.00015799999999999999,0.00015699999999999999,0.000115,0.000103,6.3999999999999997e-05,0.000126,0.00013799999999999999}', '{50.011699999999998,0.19864699999999999,-3.1305600000000001e-05}', 'NaN', 'Calibrating RAF Probes');
INSERT INTO calibrations VALUES ('83a88e36-f410-4d21-9824-76600b2a87fe', '                                    ', 'Lab_FL1', '1', '0', '1', '2013-02-06 07:11:00', 'NOMADSS', 'wasinger', 'Heated', '812453A', 'TT_BATH', '', 'bath', '0', '  ', '/net/jlocal/projects/Configuration/raf/cal_files/Bath/RAF_02062013', '{}', '{29.867999999999999,19.878,9.8940000000000001,-0.096000000000000002,-10.08,-20.068999999999999,-30.050000000000001,-40.036000000000001,-50.031999999999996,-60.018999999999998}', '{55.936,53.965000000000003,51.988999999999997,50.006,48.018000000000001,46.021999999999998,44.023000000000003,42.015000000000001,40,37.979999999999997}', '{2.1999999999999999e-05,0.000125,0.000115,0.000155,0.000156,0.000122,0.0001,6.3e-05,0.000125,0.000137}', '{50.025100000000002,0.198823,-3.10395e-05}', 'NaN', 'Calibrating RAF Probes');
INSERT INTO calibrations VALUES ('952523da-6b76-40a6-8455-2a4c947dc068', '                                    ', 'Lab_FL1', '1', '0', '1', '2013-02-12 08:35:00', 'NOMADSS', 'wasinger', 'FastResp', '2984', 'TT_BATH', '', 'bath', '2', '  ', '/net/jlocal/projects/Configuration/raf/cal_files/Bath/RAF_02122013', '{}', '{29.864000000000001,19.878,9.8949999999999996,-0.097000000000000003,-10.08,-20.068999999999999,-30.052,-40.039000000000001,-50.030999999999999,-60.017000000000003}', '{56.527000000000001,54.533999999999999,52.536999999999999,50.531999999999996,48.521999999999998,46.506,44.484000000000002,42.454999999999998,40.417999999999999,38.375}', '{9.7999999999999997e-05,8.1000000000000004e-05,0.000112,0.00022000000000000001,0.000144,0.00017699999999999999,0.000173,0.000112,0.000176,0.00015899999999999999}', '{50.551900000000003,0.200985,-3.14662e-05}', 'NaN', 'RAF Temperature Probe Calibration');
INSERT INTO calibrations VALUES ('70f5ce63-b724-4b5d-86dd-e1c5fe92048a', 'e20bed8f-3aff-46dd-8691-a3dd0d358977', 'GV_N677F', '1', '0', '1', '2013-05-02 19:53:43', 'MPEX', 'JC/KH', 'Rosemount', '3109', 'TTRL', '305', 'instrument', '1', '4F', '20130502_182547_cf01.ads', '{"2013-05-02 19:45:13.99","2013-05-02 19:46:09.99","2013-05-02 19:46:59.99","2013-05-02 19:47:48.99","2013-05-02 19:48:39.99","2013-05-02 19:49:31.99","2013-05-02 19:50:18.99","2013-05-02 19:51:05.99","2013-05-02 19:51:51.99","2013-05-02 19:52:42.99"}', '{29.870000000000001,19.879000000000001,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{4.1463000000000001,3.8043,3.4535,3.1053999999999999,2.7494000000000001,2.3923000000000001,2.0331000000000001,1.6694,1.3010999999999999,0.92879999999999996}', '{0.00060271999999999995,6.7088999999999994e-05,0.00021541999999999999,0.00010857,8.9356000000000003e-05,6.8219000000000005e-05,6.8728999999999999e-05,7.9494999999999997e-05,8.4215000000000006e-05,8.3059000000000006e-05}', '{-84.566999999999993,26.074300000000001,0.36657499999999998}', 'NaN', '');
INSERT INTO calibrations VALUES ('7809ffcd-d28a-49b9-b578-4aafc027bf83', '1d2615a1-66ea-43cd-879a-754656791fa3', 'GV_N677F', '1', '0', '1', '2013-05-02 20:10:18', 'MPEX', 'JC/KH', 'Harco Temp', '812452A', 'TTHR1', '305', 'instrument', '0', '4F', '20130502_182547_cf01.ads', '{"2013-05-02 20:00:02.99","2013-05-02 20:01:56.99","2013-05-02 20:03:01.99","2013-05-02 20:04:03.99","2013-05-02 20:04:57.99","2013-05-02 20:05:43.99","2013-05-02 20:06:42.99","2013-05-02 20:07:33.99","2013-05-02 20:08:35.99","2013-05-02 20:09:31.99"}', '{29.870000000000001,19.879000000000001,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{4.6734,4.2765000000000004,3.8784000000000001,3.4762,3.0703,2.6598999999999999,2.2454999999999998,1.8266,1.4032,0.97548000000000001}', '{4.9184000000000002e-05,8.1557999999999994e-05,6.2262999999999997e-05,6.5629000000000005e-05,7.6724999999999995e-05,5.8341000000000003e-05,5.2775000000000002e-05,6.6366999999999997e-05,6.8359000000000001e-05,5.6851000000000002e-05}', '{-82.403099999999995,22.657900000000001,0.29320299999999999}', 'NaN', '');
INSERT INTO calibrations VALUES ('f0d44cd1-0e0f-45df-a82d-44196dd5a73b', '88f47d3f-d98e-41ad-b90a-a4bd37bf50d5', 'GV_N677F', '1', '0', '1', '2013-05-02 20:27:38', 'MPEX', 'JC/KH', 'Heated Rosemount GV', '812452B', 'TTHR2', '305', 'instrument', '2', '4F', '20130502_182547_cf01.ads', '{"2013-05-02 20:14:37.99","2013-05-02 20:15:40.99","2013-05-02 20:18:39.99","2013-05-02 20:19:34.99","2013-05-02 20:20:27.99","2013-05-02 20:21:13.99","2013-05-02 20:21:57.99","2013-05-02 20:22:44.99","2013-05-02 20:26:20.99","2013-05-02 20:24:46.99"}', '{29.870000000000001,19.879000000000001,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{4.6582999999999997,4.2630999999999997,3.8656999999999999,3.4634999999999998,3.0577000000000001,2.6469999999999998,2.2324999999999999,1.8134999999999999,1.3902000000000001,0.96216000000000002}', '{6.6778000000000003e-05,6.5324e-05,6.1797000000000005e-05,6.8100000000000002e-05,5.4109e-05,7.4709999999999995e-05,5.7052999999999997e-05,5.02e-05,5.8526999999999997e-05,7.0848999999999999e-05}', '{-82.053299999999993,22.613600000000002,0.30347000000000002}', 'NaN', '');
INSERT INTO calibrations VALUES ('8e7e47a9-2dcf-45b8-a57e-f1a40b8df72f', 'e20bed8f-3aff-46dd-8691-a3dd0d358977', 'GV_N677F', '1', '0', '1', '2013-05-06 16:42:25', 'MPEX', 'KH', 'Rosemount', '3109', 'TTRL', '305', 'instrument', '1', '4F', '20130506_133037_cf03.ads', '{"2013-05-06 16:34:27.99","2013-05-06 16:36:08.99","2013-05-06 16:38:32.99","2013-05-06 16:41:23.99","2013-05-06 16:22:45.99","2013-05-06 16:23:55.99","2013-05-06 16:26:01.99","2013-05-06 16:28:55.99","2013-05-06 16:30:06.99","2013-05-06 16:31:36.99"}', '{29.870000000000001,19.879000000000001,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{4.1456,3.8024,3.4350000000000001,3.0926999999999998,2.7429999999999999,2.3877999999999999,2.0287000000000002,1.6654,1.2978000000000001,0.92598000000000003}', '{0.00010119,0.00020706000000000001,0.00010064999999999999,0.00025925999999999998,9.9718999999999999e-05,6.9639000000000002e-05,7.8159999999999997e-05,6.7941000000000006e-05,7.7788999999999997e-05,6.9740000000000007e-05}', '{-84.8767,26.471599999999999,0.29547800000000002}', 'NaN', '');
INSERT INTO calibrations VALUES ('214e7b5f-f473-4d80-b6ce-7b625b05a52f', '83a88e36-f410-4d21-9824-76600b2a87fe', 'C130_N130AR', '1', '0', '1', '2013-05-14 20:15:47', 'NOMADSS', 'KH', 'HARCO', '812453A', 'TTHL1', 'dsm321', 'instrument', '0', '  ', '20130514_174324_cf05.ads', '{"2013-05-14 20:06:56.99","2013-05-14 20:07:32.99","2013-05-14 20:08:21.99","2013-05-14 20:08:51.99","2013-05-14 20:09:24.99","2013-05-14 20:09:57.99","2013-05-14 20:10:33.99","2013-05-14 20:11:09.99","2013-05-14 20:11:51.99","2013-05-14 20:12:31.99"}', '{29.867999999999999,19.878,9.8940000000000001,-0.096000000000000002,-10.08,-20.068999999999999,-30.050000000000001,-40.036000000000001,-50.031999999999996,-60.018999999999998}', '{4.6467000000000001,4.2523,3.8546,3.4531000000000001,3.0472000000000001,2.6368,2.2229999999999999,1.8039000000000001,1.3811,0.95330999999999999}', '{7.1580000000000002e-05,7.2083999999999996e-05,6.7241000000000002e-05,0.00012962,6.1035000000000001e-05,4.8644999999999999e-05,6.5769e-05,7.8684999999999996e-05,7.2953000000000004e-05,5.4732999999999999e-05}', '{-81.869900000000001,22.635999999999999,0.30355599999999999}', 'NaN', '');
INSERT INTO calibrations VALUES ('2ed7a6bd-15ad-4d22-b333-64ec0c8ae9a8', 'c9b23cc9-bb52-49d9-bf6f-2a38fafe9321', 'C130_N130AR', '1', '0', '1', '2013-05-14 20:30:27', 'NOMADSS', 'KH', 'HARCO', '812453B', 'TTHL2', 'dsm321', 'instrument', '0', '  ', '20130514_174324_cf05.ads', '{"2013-05-14 20:23:31.99","2013-05-14 20:24:05.99","2013-05-14 20:24:44.99","2013-05-14 20:25:16.99","2013-05-14 20:25:49.99","2013-05-14 20:26:24.99","2013-05-14 20:26:57.99","2013-05-14 20:27:56.99","2013-05-14 20:28:46.99","2013-05-14 20:29:26.99"}', '{29.867999999999999,19.878,9.8940000000000001,-0.096000000000000002,-10.08,-20.068999999999999,-30.050000000000001,-40.036000000000001,-50.031999999999996,-60.018999999999998}', '{4.6569000000000003,4.2614000000000001,3.8628999999999998,3.4607999999999999,3.0545,2.6436000000000002,2.2290999999999999,1.8104,1.3867,0.96179999999999999}', '{0.00013570999999999999,8.4498000000000003e-05,0.00013121000000000001,0.00010043,0.00011344,7.8035999999999996e-05,5.0772000000000001e-05,0.00013954000000000001,6.7130000000000003e-05,0.089339000000000002}', '{-82.094700000000003,22.704599999999999,0.28704299999999999}', 'NaN', '');
INSERT INTO calibrations VALUES ('1bfb9cfd-48f2-488e-8da0-03ceea34100a', '952523da-6b76-40a6-8455-2a4c947dc068', 'C130_N130AR', '1', '0', '1', '2013-05-14 20:51:51', 'NOMADSS', 'KH', 'Rosemount', '2984', 'TTRL', 'dsm320', 'instrument', '0', '  ', '20130514_174324_cf05.ads', '{"2013-05-14 20:46:08.99","2013-05-14 20:46:51.99","2013-05-14 20:47:16.99","2013-05-14 20:47:38.99","2013-05-14 20:48:17.99","2013-05-14 20:48:46.99","2013-05-14 20:49:27.99","2013-05-14 20:49:53.99","2013-05-14 20:50:25.99","2013-05-14 20:50:58.99"}', '{29.864000000000001,19.878,9.8949999999999996,-0.097000000000000003,-10.08,-20.068999999999999,-30.052,-40.039000000000001,-50.030999999999999,-60.017000000000003}', '{3.9026000000000001,3.4798,3.0575000000000001,2.6347,2.2124999999999999,1.7899,1.3663000000000001,0.94260999999999995,0.51846000000000003,0.095131999999999994}', '{5.4697000000000002e-05,8.1679000000000002e-05,6.6316999999999995e-05,0.00014461000000000001,7.7698e-05,5.2105999999999999e-05,0.00028589000000000002,5.1156999999999998e-05,7.2395000000000001e-05,0.00059608000000000003}', '{-62.254199999999997,23.5517,0.0141067}', 'NaN', '');
INSERT INTO calibrations VALUES ('074337f7-694f-4c3a-b90f-54f8af66ab21', '41438548-aefc-4be1-a773-f52a68ce56d4', 'C130_N130AR', '1', '0', '1', '2013-05-30 00:00:00', 'NOMADSS', 'Schanot', '', '2189', 'QCR', '', 'instrument', NULL, '  ', '20130730_143042_cf08.ads', '{"2013-07-30 14:36:26.998","2013-07-30 15:34:48.998","2013-07-30 15:29:02.998","2013-07-30 15:41:56.998","2013-07-30 15:04:49.998","2013-07-30 14:59:05.998","2013-07-30 14:53:55.998"}', '{0,20,40,60,80,100,120}', '{0.065127000000000004,1.2178,2.3698999999999999,3.5215999999999998,4.6799999999999997,5.8334000000000001,6.9866000000000001}', '{0.00014875000000000001,0.00016534000000000001,0.00015540000000000001,0.00015835999999999999,0.00015338999999999999,0.00016192999999999999,0.00014507999999999999}', '{-1.12713,17.359000000000002,-0.00349563}', 'NaN', 'Advanced Post Cals for use as final processing coefficients.');
INSERT INTO calibrations VALUES ('38b3fd70-02b5-4dda-bed3-ebd2297c22b4', '1605aada-794a-4592-a92a-48fbec21bb7f', 'C130_N130AR', '1', '0', '1', '2013-05-30 00:00:00', 'NOMADSS', 'Schanot', '', '149', 'QCFR', '', 'instrument', ' ', '  ', '20130729_201929_cf07.ads', '{"2013-07-29 22:19:16.998","2013-07-29 21:59:24.998","2013-07-29 22:08:35.998","2013-07-29 21:41:41.998","2013-07-29 21:37:43.998","2013-07-29 21:32:52.998","2013-07-29 21:29:09.998"}', '{0,20,40,60,80,100,120}', '{0.032543000000000002,1.4762999999999999,2.9201000000000001,4.3663999999999996,5.8117000000000001,7.2584,8.7063000000000006}', '{0.00028017,0.00017024,0.00019505999999999999,0.00019207,0.00019045999999999999,0.00014632999999999999,0.00017813}', '{-0.45091199999999998,13.857900000000001,-0.0026177499999999999}', 'NaN', 'Advanced Post Cals for use as final processing coefficients.');
INSERT INTO calibrations VALUES ('da6356d4-cc96-46c9-b59e-4e981b2499ce', '3fc547b5-eff9-4f05-a538-66fd1f56527f', 'C130_N130AR', '1', '0', '1', '2013-05-30 00:00:00', 'NOMADSS', 'Schanot', '', '2190', 'QCF', '', 'instrument', ' ', '  ', '20130729_201929_cf07.ads', '{"2013-07-29 21:12:31.998","2013-07-29 21:05:49.998","2013-07-29 21:01:13.998","2013-07-29 20:55:28.998","2013-07-29 20:47:30.998","2013-07-29 20:42:02.998","2013-07-29 20:37:21.998"}', '{0,20,40,60,80,100,120}', '{-0.073122999999999994,1.0843,2.2416999999999998,3.399,4.5560999999999998,5.7126999999999999,6.8696999999999999}', '{0.00020542999999999999,0.000173,0.00019362000000000001,0.00022076999999999999,0.00018484,0.00013954000000000001,0.00020835}', '{1.26393,17.2773,0.00100117}', 'NaN', 'Advanced Post Cals for use as final processing coefficients.');
INSERT INTO calibrations VALUES ('b9082e8b-77b7-4f96-af5c-83addd409b59', 'e20bed8f-3aff-46dd-8691-a3dd0d358977', 'GV_N677F', '1', '0', '0', '2013-06-17 17:01:29', 'MPEX', 'KH', 'Rosemount', '3109', 'TTRL', '305', 'instrument', '1', '4F', '20130617_164101_cf04.ads', '{"2013-06-17 16:51:06.99","2013-06-17 16:53:23.99","2013-06-17 16:54:34.99","2013-06-17 16:55:31.99","2013-06-17 16:56:20.99","2013-06-17 16:57:01.99","2013-06-17 16:57:52.99","2013-06-17 16:58:35.99","2013-06-17 16:59:36.99","2013-06-17 17:00:22.99"}', '{29.870000000000001,19.879000000000001,9.8930000000000007,-0.098000000000000004,-10.079000000000001,-20.067,-30.050000000000001,-40.036999999999999,-50.030000000000001,-60.020000000000003}', '{4.1467000000000001,3.8005,3.4542999999999999,3.1053999999999999,2.7524999999999999,2.3959000000000001,2.0352000000000001,1.6701999999999999,1.3007,0.92732000000000003}', '{0.00048212999999999999,5.6963000000000003e-05,0.00013894999999999999,8.7052000000000006e-05,7.8213999999999993e-05,7.3351999999999998e-05,6.7996000000000004e-05,6.9220000000000005e-05,6.5693999999999998e-05,8.1743999999999995e-05}', '{-84.374600000000001,25.870899999999999,0.40788400000000002}', 'NaN', '');
INSERT INTO calibrations VALUES ('3fc547b5-eff9-4f05-a538-66fd1f56527f', '                                    ', 'C130_N130AR', '1', '0', '0', '2013-07-29 21:13:15', 'NOMADSS', 'JAM', 'Differential Press.', '2190', 'QCF', 'dsm320', 'instrument', '1', '  ', '20130729_201929_cf07.ads', '{"2013-07-29 21:12:31.998","2013-07-29 21:05:49.998","2013-07-29 21:01:13.998","2013-07-29 20:55:28.998","2013-07-29 20:47:30.998","2013-07-29 20:42:02.998","2013-07-29 20:37:21.998"}', '{0,20,40,60,80,100,120}', '{-0.073122999999999994,1.0843,2.2416999999999998,3.399,4.5560999999999998,5.7126999999999999,6.8696999999999999}', '{0.00020542999999999999,0.000173,0.00019362000000000001,0.00022076999999999999,0.00018484,0.00013954000000000001,0.00020835}', '{1.26393,17.2773,0.00100117}', 'NaN', '');
INSERT INTO calibrations VALUES ('1605aada-794a-4592-a92a-48fbec21bb7f', '                                    ', 'C130_N130AR', '1', '0', '0', '2013-07-29 22:20:08', 'NOMADSS', 'JAM', 'Differential Press.', '149', 'QCFR', 'dsm320', 'instrument', '5', '  ', '20130729_201929_cf07.ads', '{"2013-07-29 22:19:16.998","2013-07-29 21:59:24.998","2013-07-29 22:08:35.998","2013-07-29 21:41:41.998","2013-07-29 21:37:43.998","2013-07-29 21:32:52.998","2013-07-29 21:29:09.998"}', '{0,20,40,60,80,100,120}', '{0.032543000000000002,1.4762999999999999,2.9201000000000001,4.3663999999999996,5.8117000000000001,7.2584,8.7063000000000006}', '{0.00028017,0.00017024,0.00019505999999999999,0.00019207,0.00019045999999999999,0.00014632999999999999,0.00017813}', '{-0.45091199999999998,13.857900000000001,-0.0026177499999999999}', 'NaN', '');
INSERT INTO calibrations VALUES ('41438548-aefc-4be1-a773-f52a68ce56d4', '                                    ', 'C130_N130AR', '1', '0', '0', '2013-07-30 15:43:08', 'NOMADSS', 'JAM', 'Differential Press.', '2189', 'QCR', 'dsm320', 'instrument', '0', '  ', '20130730_143042_cf08.ads', '{"2013-07-30 14:36:26.998","2013-07-30 15:34:48.998","2013-07-30 15:29:02.998","2013-07-30 15:41:56.998","2013-07-30 15:04:49.998","2013-07-30 14:59:05.998","2013-07-30 14:53:55.998"}', '{0,20,40,60,80,100,120}', '{0.065127000000000004,1.2178,2.3698999999999999,3.5215999999999998,4.6799999999999997,5.8334000000000001,6.9866000000000001}', '{0.00014875000000000001,0.00016534000000000001,0.00015540000000000001,0.00015835999999999999,0.00015338999999999999,0.00016192999999999999,0.00014507999999999999}', '{-1.12713,17.359000000000002,-0.00349563}', 'NaN', '');


--
-- Name: calibrations_rid_key; Type: CONSTRAINT; Schema: public; Owner: ads; Tablespace: 
--

ALTER TABLE ONLY calibrations
    ADD CONSTRAINT calibrations_rid_key UNIQUE (rid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: dblink_connect_u(text); Type: ACL; Schema: public; Owner: ads
--

REVOKE ALL ON FUNCTION dblink_connect_u(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION dblink_connect_u(text) FROM ads;
GRANT ALL ON FUNCTION dblink_connect_u(text) TO ads;


--
-- Name: dblink_connect_u(text, text); Type: ACL; Schema: public; Owner: ads
--

REVOKE ALL ON FUNCTION dblink_connect_u(text, text) FROM PUBLIC;
REVOKE ALL ON FUNCTION dblink_connect_u(text, text) FROM ads;
GRANT ALL ON FUNCTION dblink_connect_u(text, text) TO ads;


--
-- PostgreSQL database dump complete
--

