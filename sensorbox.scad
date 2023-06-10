/**
 * Dave Davenport 2020
 * License MIT.
 * Sensor box wemos + battery + bme
 */

$fn = 100;

$lid = false;
$case = true;

$separator = false;
$extra_height = -3;
$display = false;

$usb = true;
$standoff = false;

$powerplug = false;

module battery_case ( )
{
    // Rounded up.
    $bc_width  = 77;
    $bc_depth  = 22;
    $bc_height = 21;

    color( "black" ) {
        cube([$bc_width, $bc_depth, $bc_height]);
    }

}

module power_supply()
{
    $ps_width = 25;
    $ps_depth = 16;
    $ps_height= 20;

    color ( "green" ) {
        cube([$ps_width, $ps_depth, $ps_height]);
    }
}

module wemos ()
{
    $wm_width = 30;
    $wm_depth = 15;
    $wm_height = 30;

    color ( "red") {
        cube([$wm_width, $wm_depth, $wm_height]);
    }
}

module case ()
{
    difference()
    {
        minkowski()
        {
            cube([110,50,33+$extra_height]);
            cylinder(d=10,0.1);
        }
        translate([0,0,1.5])
        {
            minkowski()
            {
                cube([110,50,33+$extra_height-1.4]);
                cylinder(d=5,0.1);
            }
        }
        translate([0,0,31.5+$extra_height])
        {
            minkowski()
            {
                cube([110,50,33+$extra_height-1.4]);
                cylinder(d=8,0.1);
            }
        }
    }

    translate([85,-5,0]) {
        difference()
        {
            cube([1.5,60,28]);
            rotate([0,-90,0]) {
                translate([10,50,-2]){
                    cylinder(d=12,h=3);
                }
            }
        }
    }
    if ( $separator )
    {
        translate ([-5,20,0]) {
            difference()
            {
                cube([90,1.5,28]);
                rotate([90,0,0]) {
                    translate([10,10,-2]){
                        cylinder(d=12,h=3);
                    }
                }
            }
        }
    }

    translate([-3.5,-3.5,0])
        cube([8,8,31.5+$extra_height]);
    translate([-3.5,50-4.5,0])
        cube([8,8,31.5+$extra_height]);
    //cylinder(d=10,37,$fn=100);
    translate([110-1.5,0,0]) {
        translate([-3,-3.5,0])
            cube([8,8,31.5+$extra_height]);
        translate([-3,50-4.5,0])
            cube([8,8,31.5+$extra_height]);
    }

}

module lid ()
{
    color ( "blue",0.8 )
    {
        minkowski()
        {
            translate([0.2,0.2,0]){
                cube([110-0.4,50-0.4,1.4]);
            }
            cylinder(d=7.7,0.1);
        }
    }
}

module box ()
{
    difference()
    {
        union()
        {
            if ( $case )  {
                case();
            }
            translate([0,0,33+$extra_height-1.5])
            {
                if ( $lid ) {
                    lid();
                }
            }
        }
        translate([1,1,3]) {
            cylinder(d=3.0,h=40);
            translate([0,50-1.5,0])
                cylinder(d=3.0,h=40);
        }
        translate([110-0.5,1,3]) {
            cylinder(d=3.0,h=40);
            translate([0,50-1.5,0])
                cylinder(d=3.0,h=40);
        }

        // Airvents
        translate([90, 10, -0.1]) {
            minkowski() {
                cube([1, 30, 60]);
                cylinder(d=2,0.1);
            }
        }
        translate([96, 10, -0.1])
            minkowski() {
                cube([1, 30, 60]);
                cylinder(d=2,0.1);
            }
        translate([102, 10, -0.1])
            minkowski() {
                cube([1, 30, 60]);
                cylinder(d=2,0.1);
            }
        translate([108, 10, -0.1])
            minkowski() {
                cube([1, 30, 60]);
                cylinder(d=2,0.1);
            }
    }
}

difference()
{
    box();

    if ( $powerplug )
    {
        translate([15,60,10]) {
            rotate([90,90,0]) {
                cylinder(d=8.0, h=10);
            }
        }
    }
    if ( $usb )
    {
        translate([55-11/2,52,10-2]){
            cube([11, 4,8]);
        }
    }

    if ( $display )
    {
        translate([20,-5.1,10+2]){
            cube([34.5, 4,17.5]);
        }
        if ( false ) {
            translate([20+2.25,0,2+2.5]) {
                rotate([90,0,0]){
                    cylinder(d=3.2,h=10);
                }
            }
            translate([20+2.25+30,0,2+2.5]) {
                rotate([90,0,0]) {
                    cylinder(d=3.2,h=10);
                }
            }
        }
        translate([20+2.25,0,2+2.5+28]) {
            rotate([90,0,0]) {
                cylinder(d=3.2,h=10);
            }
        }
        translate([20+2.25+30,0,2+2.5+28]) {
            rotate([90,0,0]){
                cylinder(d=3.2,h=10);
            }
        }

    }
}
if ( $display )
{
    translate([20,-2.5,1])
        cube([5,2,5]);
    translate([20+34.5-5,-2.5,1])
        cube([5,2,5]);
}


if ( $case ) {
    translate([100,25,0])
       if ( $standoff ) {
        difference()
    
        {
         
            cylinder ( r=6.0, h=10);
            translate([0,0,1])
                cylinder ( d=3.0, h=11);
            }
        }
}

if ($usb)
{
    translate([55-13,17.5,1]){
        difference()
        {
            cube([26,6,8.3]);
            translate([26-3.3,3.6,3])
                cylinder(d=2.0,h=8);
        }
    }
    translate([55-13,46,1]){
        difference(){
            cube([8,6,8.3]);
            translate([3.6,3.5,3])
                cylinder(d=2.0,h=8);
        }
        translate([26-8,0,0])

            cube([8,6,8.3]);

    }
}
