<?php

//check json
if (isset($_POST['json'])) {
  $json = $_POST['json'];
  echo "json Success"."<br>";
} else {
  echo "json Failed"."<br>";
}

//$tojson = array('id' => 1, 'name' => sample);
//$json = json_encode($tojson);
$toarray = json_decode($json, true);

//before read db
//$id = 0;
$insertname = $toarray["name"];
echo "$insertname";
//echo "$toarray[name]";

//start connection
$link = mysql_connect('localhost','dbuser','0510kaHA//');
if( !$link ){
print(mysql_error());
}

//check db_connect
$db_selected = mysql_select_db('diet', $link);
if( !$db_selected ){
	echo 'failed to connect db';
}

/*
//update query
$result = mysql_query('update user set name = "masa" where id = 0');
if( !$result ){
	echo 'failed to query';
}
else{
	echo 'update success!';
}
*/

$maxid = 0;
$minid = 0;
//select query
$result = mysql_query('select id,name from user');
if( !$result ){
	echo 'failed to query';
}
else{
	echo 'select success!';
	echo "<br>";

	while ($row = mysql_fetch_assoc($result)) {
    echo $row["id"];
    echo $row["name"];
    echo "<br>";

    //check maxid
    if($row["id"] > $maxid){
    	$maxid = $row["id"];
    }
    	$maxid = $maxid + 1;
	}
}

//insert query
if(isset($insertname)){
$result = mysql_query("insert into diet.user(id,name) values('$maxid', '$insertname')");
echo "after"."$maxid"."<br>";
if( !$result ){
	echo 'failed to insert query';
}
else{
	echo 'insert success!';
}
}

/*
//delete query
$result = mysql_query("delete from diet.user where id = 1");
if( !$result ){
	echo 'failed to delete query';
}
else{
	echo 'delete success!';
}
*/

//after read db
/*
while( $row = mysql_fetch_assoc( $result )){
	echo "<br>";
	echo $row['id'];
	echo $row['name'];
}
*/



mysql_close($link);

?>