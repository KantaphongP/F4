<?php

$dns='mysql:host=localhost;dbname=id18473502_f4';
$user='id18473502_4f';
$pass='Q6kbN\1lr^R2BBUX';
ini_set('mssql.charset', 'utf8'); 
try{
    $db = new PDO($dns ,$user,$pass);
    
    //echo 'connected';
    

}catch(PDOException $e){
    $error =$e->getMessage();
    echo $error;
}
/*try{
$connection = new PDO('mysql:host=localhost, dbname =id18473502_f4','id18473502_4f','Q6kbN\1lr^R2BBUX')
$connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION)  ;
echo "yes connected" ; 
}catch(PDOException $exc){
echo $exc->getMessage() ;
die("could not connecct") ; 
}*/
?>