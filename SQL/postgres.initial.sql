--
-- Sequence "collected_contacts_seq"
-- Name: collected_contacts_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE collected_contacts_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

--
-- Table "collected_contacts"
-- Name: collected_contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE collected_contacts (
    contact_id integer DEFAULT nextval('collected_contacts_seq'::text) PRIMARY KEY,
    user_id integer NOT NULL
        REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    changed timestamp with time zone DEFAULT now() NOT NULL,
    del smallint DEFAULT 0 NOT NULL,
    name varchar(128) DEFAULT '' NOT NULL,
    email text DEFAULT '' NOT NULL,
    firstname varchar(128) DEFAULT '' NOT NULL,
    surname varchar(128) DEFAULT '' NOT NULL,
    vcard text,
    words text
);

CREATE INDEX collected_contacts_user_id_idx ON collected_contacts (user_id, del);
