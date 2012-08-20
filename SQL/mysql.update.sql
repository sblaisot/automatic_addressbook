-- Updates from version 0.5.1
-- Updates from version 0.5.2
-- Updates from version 0.5.3
-- Updates from version 0.5.4

ALTER TABLE `collected_contacts` ADD `words` TEXT NULL AFTER `vcard`;
ALTER TABLE `collected_contacts` CHANGE `vcard` `vcard` LONGTEXT /*!40101 CHARACTER SET utf8 */ NULL DEFAULT NULL;

-- Updates from version 0.6
-- Updates from version 0.7-beta
-- Updates from version 0.7

/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

ALTER TABLE `collected_contacts` DROP FOREIGN KEY `user_id_fk_collected_contacts`;
ALTER TABLE `collected_contacts` DROP INDEX `user_collected_contacts_index`;
ALTER TABLE `collected_contacts` MODIFY `email` text NOT NULL;
ALTER TABLE `collected_contacts` ADD INDEX `user_collected_contacts_index` (`user_id`,`del`);
ALTER TABLE `collected_contacts` ADD CONSTRAINT `user_id_fk_collected_contacts` FOREIGN KEY (`user_id`)
   REFERENCES `users`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `collected_contacts` ALTER `user_id` DROP DEFAULT;

/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
