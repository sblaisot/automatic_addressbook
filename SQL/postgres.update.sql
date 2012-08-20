-- Updates from version 0.5.1
-- Updates from version 0.5.2
-- Updates from version 0.5.3
-- Updates from version 0.5.4

ALTER TABLE collected_contacts ADD words TEXT NULL;

-- Updates from version 0.6
-- Updates from version 0.7-beta
-- Updates from version 0.7

DROP INDEX collected_contacts_user_id_idx;
CREATE INDEX collected_contacts_user_id_idx ON collected_contacts USING btree (user_id, del);
ALTER TABLE collected_contacts ALTER email TYPE text;
