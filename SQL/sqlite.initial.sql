CREATE TABLE collected_contacts AS SELECT * FROM contacts WHERE 1=0;
CREATE INDEX ix_collected_contacts_user_id ON collected_contacts(user_id, email);
