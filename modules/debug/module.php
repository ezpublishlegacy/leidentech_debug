<?php

$Module = array( 'name' => 'setup' );

$ViewList = array();

$ViewList['settingstoolbar'] = array(
    'functions' => array( 'setup' ),
    'script' => 'settingstoolbar.php',
    'single_post_actions' => array( 'SetButton' => 'Set' ),
    'post_action_parameters' => array( 'Set' => array( 'SiteAccess' => 'SiteAccess',
                                                       'AllSettingsList' => 'AllSettingsList',
                                                       'SelectedList' => 'SelectedList' ) ),
    'params' => array() );

$FunctionList['setup'] = array();

?>
