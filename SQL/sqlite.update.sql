-- Updates from version 0.5.1
-- Updates from version 0.5.2
-- Updates from version 0.5.3
-- Updates from version 0.5.4

CREATE TABLE collected_contacts_tmp AS SELECT * FROM collected_contacts;
DROP TABLE collected_contacts;

CREATE TABLE collected_contacts (
    contact_id integer NOT NULL PRIMARY KEY,
    user_id integer NOT NULL default '0',
    changed datetime NOT NULL default '0000-00-00 00:00:00',
    del tinyint NOT NULL default '0',
    name varchar(128) NOT NULL default '',
    email varchar(255) NOT NULL default '',
    firstname varchar(128) NOT NULL default '',
    surname varchar(128) NOT NULL default '',
    vcard text NOT NULL default '',
    words text NOT NULL default ''
);

INSERT INTO collected_contacts (contact_id, user_id, changed, del, name, email, firstname, surname, vcard)
    SELECT contact_id, user_id, changed, del, name, email, firstname, surname, vcard FROM collected_contacts_tmp;

CREATE INDEX ix_collected_contacts_user_id ON collected_contacts(user_id, email);

DROP TABLE collected_contacts_tmp;

-- Updates from version 0.6
-- Updates from version 0.7-beta
-- Updates from version 0.7

CREATE TABLE collected_contacts_tmp (
  contact_id integer NOT NULL PRIMARY KEY,
  user_id integer NOT NULL,
  changed datetime NOT NULL default '0000-00-00 00:00:00',
  del tinyint NOT NULL default '0',
  name varchar(128) NOT NULL default '',
  email text NOT NULL default '',
  firstname varchar(128) NOT NULL default '',
  surname varchar(128) NOT NULL default '',
  vcard text NOT NULL default '',
  words text NOT NULL default ''
);

INSERT INTO collected_contacts_tmp (contact_id, user_id, changed, del, name, email, firstname, surname, vcard, words)
    SELECT contact_id, user_id, changed, del, name, email, firstname, surname, vcard, words FROM collected_contacts;

DROP TABLE collected_contacts;

CREATE TABLE collected_contacts (
  contact_id integer NOT NULL PRIMARY KEY,
  user_id integer NOT NULL,
  changed datetime NOT NULL default '0000-00-00 00:00:00',
  del tinyint NOT NULL default '0',
  name varchar(128) NOT NULL default '',
  email text NOT NULL default '', 
  firstname varchar(128) NOT NULL default '',
  surname varchar(128) NOT NULL default '',
  vcard text NOT NULL default '',
  words text NOT NULL default ''
);

INSERT INTO collected_contacts (contact_id, user_id, changed, del, name, email, firstname, surname, vcard, words)
    SELECT contact_id, user_id, changed, del, name, email, firstname, surname, vcard, words FROM collected_contacts_tmp;

CREATE INDEX ix_collected_contacts_user_id ON collected_contacts(user_id, del);
DROP TABLE collected_contacts_tmp;
