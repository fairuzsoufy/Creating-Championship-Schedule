<html>

<head>
    <title>Clubs</title>
</head>

<style>
     html *
    {
        font-size: 15px !important;
        color: #000 !important;
        font-family: Arial !important;
    }

    body 
    {
        background-image: url('images/wallpaper.jpg');
        background-repeat: no-repeat;
        background-size: cover;
    }

    .parent-wrapper 
    {
        height:100%;
        width:100%;
    }

    .parent 
    {
        display: flex;
        flex-wrap: wrap;
    }

    .child 
    {
        flex: 1 0 21%; 
        /* background-color: blue; */
        text-align: center;
        line-height: 50px;
        margin-top: 100px;
    }

    button{
        cursor: pointer; 
        border: 1px solid black; 
        background-color: transparent; 
        height: 50px; 
        width: 200px; 
        color: #3498db; 
        font-size: 1.5em; 
        box-shadow: 0 6px 6px rgba(0, 0, 0, 0.6); 
        border-radius: 10px;
    }


</style>

<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>


<script>

    function saveData($groups) 
    {
        jQuery.ajax(
        {
          url: "index.php",
          data: 'method=saveScheduleToDB',
          type: "POST",
          success:function(data2)
          {
            alert('Saved Successfully!');
          },
          error: function(jqXHR, textStatus, errorThrown)
          {
            alert("Save Failed!");
          }    
                  
        });

   
    }
</script>

<body>

    <?php

    
    require_once('Group.php');
    require_once('Club.php');
    // Make and check connection
    $conn = mysqli_connect("localhost", "root", "", "groups");
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    $groups =  array();
    $temp_groups =  array();
    $conn = mysqli_connect("localhost", "root", "", "groups");

    generateQualified($groups, $conn);
    // Assigning groups
    function generateQualified($groups, $conn)
    {
        //Put every qualified club in a seperate group
        $sql1 = "select name, state_id from team where qualified=1 ORDER BY RAND()";
        $result = mysqli_query($conn, $sql1);
        $i = 0;
        $letter = 'A';
        while ($row = mysqli_fetch_array($result)) {
            $group = new Group();
            $group->name = 'Group' . $letter;
            $groupclub = new club();
            $groupclub->name = $row['name'];
            $groupclub->state = $row['state_id'];
            $groupclub->isTaken = 1;
            array_push($group->clubs, $groupclub);
            array_push($groups, $group);
            $letter++;
        }
        generate($groups, $conn);
    }

    //    print_r($groups);
    // print_r('<br>');
    function generate($groups, $conn)
    {
        $temp = [];
        // Insert unqualified teams in groups    
        $sql2 = "SELECT name, state_id FROM `team` WHERE `qualified`=0 ORDER BY RAND()";
        $result = mysqli_query($conn, $sql2);

        while ($row = mysqli_fetch_array($result)) {
            $club = new club();
            $club->name = $row['name'];
            $club->state = $row['state_id'];
            array_push($temp, $club);
        }

        for ($i = 0; $i < sizeof($groups); $i++) {

            for ($j = 0; $j < sizeof($temp); $j++) {


                if ($temp[$j]->isTaken == 0) {
                    $found = false;
                    for ($k = 0; $k < sizeof($groups[$i]->clubs); $k++) {

                        if ($temp[$j]->state == $groups[$i]->clubs[$k]->state) {
                            $found = true;
                        }
                    }
                    if ($found == false) {
                        array_push($groups[$i]->clubs, $temp[$j]);
                        $temp[$j]->isTaken = 1;
                    }
                }
                if (sizeof($groups[$i]->clubs) == 4) break;
            }
        }
        check($groups, $conn);
        display($groups);
        $temp_groups= array_merge($groups);
        // print_r($temp_groups);
    }

    function check($groups, $conn)
    {
        for ($i = 0; $i < sizeof($groups); $i++) {
            if (sizeof($groups[$i]->clubs) < 4) {
                $groups =  array();
                break;
            }
        }
        if (sizeof($groups) == 0)
            generateQualified($groups, $conn);
    }



    // echo (json_encode($groups));


    function display($groups)
    {
        echo '<div class="parent-wrapper">
            <div class="parent">';

        for ($i = 0; $i < sizeof($groups); $i++) {
            echo ('<div class="child">');
            //Print group name
            print_r('<b>' . substr_replace($groups[$i]->name, ' ' . substr($groups[$i]->name, -1), -1) . '</b><br>');
            // print group clubs
            for ($k = 0; $k < sizeof($groups[$i]->clubs); $k++) {
                echo $groups[$i]->clubs[$k]->name . '<br>';
            }
            echo '</div>';
        }

        echo '</div></div>';
    }


    // AJAX Checking
    if(isset($_POST['method']) && $_POST['method']=="saveScheduleToDB")
    {
        saveScheduleToDB($conn,$temp_groups);
    }

    print_r($groups);
    // Save Groups to database
    function saveScheduleToDB($conn,$temp_groups)
    {
        
        for ($i = 0; $i < sizeof($temp_groups); $i++) 
        {
            
            $group_name = substr_replace($temp_groups[$i]->name, ' ' . substr($temp_groups[$i]->name, -1), -1);
            // loop on group clubs
            for ($k = 0; $k < sizeof($temp_groups[$i]->clubs); $k++) 
            {
                //echo $group_name;
                // echo $groups[$i]->clubs[$k]->name.'<br>';
                $sql="INSERT INTO HISTORY (`group`, `team`, `timestamp`) VALUES ('".$group_name."','".$temp_groups[$i]->clubs[$k]->name."',NOW())";
                print_r($sql);
                print_r('hiiii');
                $result = mysqli_query($conn, $sql);
            }
            
        }

      
    }

    ?>


    <div style='text-align:center;'> 
        <button type="button" onclick="saveData()">Save To Database</button>
    </div>
</body>

</html>