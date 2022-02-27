<?php

require_once("db.php");
$query = 'SELECT idLocation,latitude,longtitude FROM Location';
$stm = $db->prepare($query);
$stm->execute();
$row= $stm->fetch(PDO::FETCH_ASSOC);
 echo json_encode($row);
?>