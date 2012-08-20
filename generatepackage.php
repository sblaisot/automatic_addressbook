#!/usr/bin/php
<?php

require_once('PEAR/PackageFileManager2.php');
PEAR::setErrorHandling(PEAR_ERROR_DIE);

$options = array(
  'filelistgenerator' => 'svn', // this copy of our source code is a CVS checkout
  'simpleoutput' => true,
  'baseinstalldir' => '/', // The PEAR directory install location
  'packagedirectory' => dirname('___FILE___'), // We’ve put this file in the root source code dir
  'clearcontents' => true, // dump any old package.xml content (set false to append release)
  // no bundling of cvs/svn files or this generator file
  'ignore' => array('generate_package_xml.php', '.svn', '.cvs*'),
  'dir_roles' => array( // set up roles for some directories; the default is php
    'config' => 'cfg',
    'localization' => 'data',
    'SQL' => 'data',
    ),
);

$packagefile="package.xml";
// Oddly enough, this is a PHP source code package…

$packagexml = &PEAR_PackageFileManager2::importOptions($packagefile, $options);
$packagexml->setPackageType('php');

// Package name, summary and longer description

$packagexml->setPackage('automatic_addressbook');
$packagexml->setSummary('The automatic addressbook plugin collect each address you send an email to and records it in an address book, making it available for later use or auto-completion.');
$packagexml->setDescription("   * Simple plugin to register to \"collect\" all recipients of sent mail
   * to a dedicated address book (usefull for autocompleting email you
   * already used). User can choose in preferences (compose group) to
   * enable or disable the feature of this plugin.
   * Aims to reproduce the similar features of thunderbird or gmail.");

// The channel where this package is hosted. Since we’re installing from a local
// downloaded file rather than a channel we’ll pretend it’s from PEAR.

$packagexml->setChannel('pear.roundcube.net');

// Add some release notes!

$notes = 'v0.3 :
* Populated documentation files (README and INSTALL) to have documentation available when installing offline
* Added Changelog File
* Fixed compatibility with other addressbook_plugins (#46)
* Fixed Add contact button disabled in default abook after viewing collected abook (#58).
  Side effect is that you can now add contact in collected abook.
* Disabled contact groups in collected abook
* Added calls to exec_hook when creating or deleting a contact to improve compatibility with other plugins (thanks to Venia Legendi for submitting patch) (#56)
* Updated database statements in SQL to reflect changes from RC 0.5
* Now call decode_address_list function from rcube_mime as it is deprecated from rcube_imap (#51)
* Fixed on_edit_move_to_default not working. Fixes #47. Also Fixes #25
* Defined plugin task list as advised in plugin writing documentation (maybe will improve performance ?)

v0.2 and before :
* previous releases';
$packagexml->setNotes($notes);

// Add any known dependencies such as PHP version, extensions, PEAR installer

$packagexml->setPhpDep('5.1.4');
$packagexml->setPearinstallerDep('1.4.0');
$packagexml->addPackageDepWithChannel('required', 'PEAR', 'pear.php.net', '1.4.0');

// Other info, like the Lead Developers. license, version details and stability type

$packagexml->addMaintainer('lead', 'sblaisot', 'Sebastien Blaisot', 'sebastien@blaisot.org');
$packagexml->setLicense('GNU GPLv3+', 'http://www.gnu.org/licenses/gpl-3.0.html');
$packagexml->setAPIVersion('0.3');
$packagexml->setReleaseVersion('0.3b1');
$packagexml->setReleaseStability('beta');
$packagexml->setAPIStability('stable');

// Add this as a release, and generate XML content

$packagexml->addRelease();
$packagexml->generateContents();

// Pass a “make” flag from the command line or browser address to actually write
// package.xml to disk, otherwise just debug it for any errors

if (isset($_GET['make']) || (isset($_SERVER['argv']) && @$_SERVER['argv'][1] == 'make')) {
  $packagexml->writePackageFile();
} else {
  $packagexml->debugPackageFile();
}
?>
