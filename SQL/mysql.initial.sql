CREATE TABLE `collected_contacts` (
 `contact_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
 `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
 `del` tinyint(1) NOT NULL DEFAULT '0',
 `name` varchar(128) NOT NULL,
 `email` varchar(128) NOT NULL,
 `firstname` varchar(128) NOT NULL,
 `surname` varchar(128) NOT NULL,
 `vcard` text NULL,
 `user_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
 PRIMARY KEY(`contact_id`),
 INDEX `user_collected_contacts_index` (`user_id`,`email`),
 CONSTRAINT `user_id_fk_contacts` FOREIGN KEY (`user_id`)
   REFERENCES `users`(`user_id`)
   --!40008
   --ON DELETE CASCADE
   --ON UPDATE CASCADE
) ;
