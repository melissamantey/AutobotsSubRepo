<?php

#   var_dump($argc);
#	var_dump($argv);

    $name = "self";
    $lat = $argv[1];
    $long = $argv[2];
    $vel = -1;
    $angle = -1;
    $accel = -1;
    $time = $argv[3];
    $error = $argv[4];
#    echo "Latitude is: $lat!\n";
#    echo "Longitude is: $long!\n";

    //Connect to database
    $db = mysqli_connect("localhost","root","password","MNAV_Registry");  

    if($db === false) {
        //Print an error if the database can't be reached
        echo "Cannot connect to the database!\n";
    }else {
        $sql = "INSERT INTO `Registry` (`user_id`,`latitude`,`longitude`,`velocity`,`steering_angle`,`acceleration`,`time_stamp`,`error_message`) values
            ('$name','$lat','$long','$vel','$angle','$accel','$time','$error');";
        if ($db->query($sql) === TRUE) {
            echo "Record updated successfully!\n";
        } else {
            echo "Error updating record: " . $db->error;
        }
    }

?>
