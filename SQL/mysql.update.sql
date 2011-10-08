-- Updates from version 0.5.1
-- Updates from version 0.5.2
-- Updates from version 0.5.3
-- Updates from version 0.5.4

ALTER TABLE `collected_contacts` ADD `words` TEXT NULL AFTER `vcard`;
ALTER TABLE `collected_contacts` CHANGE `vcard` `vcard` LONGTEXT /*!40101 CHARACTER SET utf8 */ NULL DEFAULT NULL;
