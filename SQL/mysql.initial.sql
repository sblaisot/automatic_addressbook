CREATE TABLE `collected_contacts` (
`contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
`del` tinyint(1) NOT NULL DEFAULT '0',
`name` varchar(128) NOT NULL,
`email` varchar(128) NOT NULL,
`firstname` varchar(128) NOT NULL,
`surname` varchar(128) NOT NULL,
`vcard` longtext NULL,
 `words` text NULL,
`user_id` int(10) unsigned NOT NULL DEFAULT '0',
PRIMARY KEY (`contact_id`),
KEY `user_collected_contacts_index` (`user_id`,`email`),
CONSTRAINT `collected_contacts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;