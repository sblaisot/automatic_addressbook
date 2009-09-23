<?php
define('INSTALL_PATH', dirname($_SERVER['SCRIPT_FILENAME']).'/../../../');
require_once("program/include/iniset.php");


PEAR::setErrorHandling(PEAR_ERROR_DIE);

function is_eol($line)
{
    if ($engine != 'mssql') {
        return preg_match('/;$/', trim($line));
    } else {
        return preg_match('/(^|.*\s*)GO$/', trim($line));
    }
}


function init_db($DB, $engine, $sql_dir)
{
    // read schema file
    $fname = $sql_dir.'/'.$engine.'.initial.sql';
    if ($lines = @file($fname, FILE_SKIP_EMPTY_LINES)) {
      $buff = '';
      foreach ($lines as $i => $line) {
        if (preg_match('/^--/', $line))
          continue;
        $buff .= $line . "\n";
        if (is_eol($line)){
          $res = $DB->query($buff);
	  echo "\n";
//	  if(PEAR::isError($res)) {
//       die("SQL error : " . $res->getMessage());
//	  }
          $buff = '';
        }
      }
      return true;
    }
    else {
      echo "<strong>$engine backend not supported. Only sqlite is supported at the moment)... contributions are welcome !</strong>\n";
      return false;
    }
}

$sql_dir = getcwd();
chdir(INSTALL_PATH); //To avoid issues with relative sqlite paths

$rcmail = rcmail::get_instance();
$parts = split('://', $rcmail->config->get("db_dsnw"));
$engine = $parts[0];

$init_res = init_db($rcmail->db, $engine, $sql_dir);

if ($init_res) {
  $res = "Ok<br />\n Automatic addressbook plugin is installed !";
  
} else {
  $res = 'Failled';
}
echo '<p>Building table (engine : '.$engine.')...<strong>'.$res.'</strong></p>';

?>
