<?php

/**
 * Automatic addressbook backend 
 *
 * Minimal backend for Automatic Addressbook
 *
 * @author Jocelyn Delalande
 * @version 0.1
 */

$rcmail_config['db_table_collected_contacts'] = 'collected_contacts';

class automatic_addressbook_backend extends rcube_contacts
{
    function __construct($dbconn, $user)
    {
        parent::__construct($dbconn, $user);
        $this->db_name = get_table_name('collected_contacts');
    }
}