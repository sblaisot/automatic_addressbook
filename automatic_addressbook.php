<?php

  /**
   * Automatic address book
   * 
   * Simple plugin to register to "collect" all recipients of sent mail
   * to a dedicated address book (usefull for autocompleting email you
   * already used). User can choose in preferences (compose group) to
   * enable or disable the feature of this plugin.
   * Aims to reproduce the similar features of thunderbird or gmail.
   * 
   * @version 0.1
   * @author Jocelyn Delalande
   * 
   * Skeletton based on "example_addressbook" plugin.
   * Contact adding code inspired by addcontact.inc by Thomas Bruederli
   */
class automatic_addressbook extends rcube_plugin
{
    private $abook_id = 'collected';
  
    public function init()
    {
        $this->add_hook('address_sources', array($this, 'address_sources'));
        $this->add_hook('get_address_book', array($this, 'get_address_book'));
        $this->add_hook('message_sent', array($this, 'register_recipients'));
        $this->add_hook('user_preferences', array($this, 'settings_table'));
        $this->add_hook('save_preferences', array($this, 'save_prefs'));
        $this->add_hook('save_contact', array($this, 'handle_doubles'));
        $this->add_hook('create_contact', array($this, 'handle_doubles'));
        
        $this->add_texts('localization/', false);
        // use this address book for autocompletion queries
        $config = rcmail::get_instance()->config;
        $sources = $config->get('autocomplete_addressbooks', array('sql'));
        
        if (!in_array($this->abook_id, $sources)) {
            $sources[] = $this->abook_id;
            $config->set('autocomplete_addressbooks', $sources);
        }
    }
    
    public function address_sources($p)
    {
        $rcmail = rcmail::get_instance();
        if ($rcmail->config->get('use_auto_abook'))
            $p['sources'][$this->abook_id] = 
                array('id' => $this->abook_id, 'name' => Q($this->gettext('automaticallycollected')), 'readonly' => false);

        return $p;
    }
  
    public function get_address_book($p)
    {
        $rcmail = rcmail::get_instance();
        if (($p['id'] === $this->abook_id) && $rcmail->config->get('use_auto_abook')) {
            require_once(dirname(__FILE__) . '/automatic_addressbook_backend.php');
            $p['instance'] = new automatic_addressbook_backend($rcmail->db, $rcmail->user->ID);
        }
        return $p;
    }

    /**
     * Collect the email address of a just-sent email recipients into
     * the automatic addressbook (if it's not already in another
     * addressbook). 
     */
    public function register_recipients($p)
    {
        $rcmail = rcmail::get_instance();
    
        if (!$rcmail->config->get('use_auto_abook'))
            return;
    
        $IMAP = new rcube_imap(null);
        $headers = $p['headers'];

        $all_recipients = array_merge(
            $IMAP->decode_address_list($headers['To']),
            $IMAP->decode_address_list($headers['Cc']),
            $IMAP->decode_address_list($headers['Bcc'])
            );

        require_once(dirname(__FILE__) . '/automatic_addressbook_backend.php');
        $CONTACTS = new automatic_addressbook_backend($rcmail->db, $rcmail->user->ID);
    
        foreach($all_recipients as $recipient) {
            // Bcc and Cc can be empty
            if ($recipient['mailto'] != '') {
                $contact = array(
                    'email' => $recipient['mailto'],
                    'name' => $recipient['name']
                    );

                // use email address part for name
                if (empty($contact['name']) || $contact['name'] == $contact['email'])
                    $contact['name'] = ucfirst(preg_replace('/[\.\-]/', ' ', 
                                                            substr($contact['email'], 0, strpos($contact['email'], '@'))));

                /* We only want to add the contact to the collected contacts
                 * address book if it is not already in an addressbook, so we
                 * first lookup in every address source.
                 */
                $book_types = (array)$rcmail->config->get('autocomplete_addressbooks', 'sql');

                foreach ($book_types as $id) {
                    $abook = $rcmail->get_address_book($id);
                    $previous_entries = $abook->search('email', $contact['email'], false, false);
      
                    if ($previous_entries->count)
                        break;
                }
                if (!$previous_entries->count)
                    $CONTACTS->insert($contact, false);
            }
        }
    }
  
    /**
     * Adds a check-box to enable/disable automatic address collection.
     */
    public function settings_table($args) {
        if ($args['section'] == 'compose') {
            $use_auto_abook = rcmail::get_instance()->config->get('use_auto_abook');
            $field_id = 'rcmfd_use_auto_abook';

            $checkbox = new html_checkbox(array('name' => '_use_auto_abook', 'id' => $field_id, 'value' => 1));
            $args['blocks']['main']['options']['use_subscriptions'] = array(
                'title' => html::label($field_id, Q($this->gettext('useautoabook'))),
                'content' => $checkbox->show($use_auto_abook?1:0),
            );
        }
        return $args;
    }

    public function save_prefs($args) {
        $rcmail = rcmail::get_instance();
        $use_auto_abook = $rcmail->config->get('use_auto_abook');
        $args['prefs']['use_auto_abook'] = isset($_POST['_use_auto_abook']) ? true : false;
        return $args;
    }

    /**
     * When a contact is added to a "regular" addressbook, take care to
     * delete it from collected addressbook if it was in.
     */
    public function handle_doubles($args) {
        $rcmail = rcmail::get_instance();
        $contact_email = $args['record']['email'];

        if ($args['source'] != $this->abook_id) {
            $auto_abook = $rcmail->get_address_book($this->abook_id);
            $collected_contact = $auto_abook->search('email', $contact_email, false, true);

            if ($collected_contact->count) {
                $record = $collected_contact->first();
                $auto_abook->delete($record['contact_id']);
            }
        }
        return $args;
    }
}
