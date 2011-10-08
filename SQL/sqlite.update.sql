CREATE TABLE collected_contacts_tmp AS SELECT * FROM collected_contacts;
DROP TABLE collected_contacts;

CREATE TABLE collected_contacts AS SELECT * FROM contacts WHERE 1=0;

INSERT INTO collected_contacts (contact_id, user_id, changed, del, name, email, firstname, surname, vcard)
    SELECT contact_id, user_id, changed, del, name, email, firstname, surname, vcard FROM collected_contacts_tmp;

CREATE INDEX ix_collected_contacts_user_id ON collected_contacts(user_id, email);

DROP TABLE collected_contacts_tmp;
