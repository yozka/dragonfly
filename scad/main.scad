include <conf/config.scad>
use <vitamins/motors.scad>
use <bracketMotors.scad>
use <chassiesBottom.scad>

/*
include <vitamins/wheel.scad>
include <chassiesDeck.scad>
include <chassiesBody.scad>
include <chassiesFace.scad>
*/

/* обычная отрисовка для экрана
*/ 


//-------------------------------------------------------------------------------------//











/* //===================================================================================*
* //                                                                                    *
* // отрисовка двигателей в сборе		     											*
* //------------------------------------------------------------------------------------*
*///
module render_motors()
{
	bracketMotors();
	translate([0,0,13])motor();
}
//-------------------------------------------------------------------------------------//









/* //===================================================================================*
* //                                                                                    *
* // отрисовка правой стороны лучей		      											*
* //------------------------------------------------------------------------------------*
*///
module render_rays()
{
	//верхний лучь
	translate(gRaysFront())
		rotate(gRaysFrontAngle())
			union()
			{
				translate([motorESC[1],0,0]) color("black") rotate([90,0,90]) cylinder(r=gcTube[0]/2 + 0.5, h = gRaysFrontLength());
				render_motors();
			}
			
	//нижний лучь
	translate(gRaysRear())
		rotate(gRaysRearAngle())
			union()
			{
				translate([motorESC[1],0,0]) color("black") rotate([90,0,90]) cylinder(r=gcTube[0]/2 + 0.5, h = gRaysRearLength());
				render_motors();
			}
}
//-------------------------------------------------------------------------------------//







union()
{
	
	/*
	difference()
	{
		union()
		{
			translate([0,0, -bracketHeightMount()/2]) print_bracketMotorsBottom();
			print_bracketMotorsTop();
		}
		//#translate([-20,0,0])cube([100,50,50]);
	}
	*/


/*
	print_bracketMotorsBottom();
	translate([0,-50,0]) print_bracketMotorsTop();
*/


	
	//отрисовка лучей с моторами
	
	render_rays();
	mirror([1,0,0]) render_rays();
	
	
	
	translate([0, 0, -gcShassiesBottom_depth])
	chassiesBottom();
	
	
	
	
	/*
	difference()
	{
		bracketMotors();
		translate([-20,0,0])cube([100,50,50]);
	}
	*/
	/*
	translate([9.5,0,8]) color( "Blue") cylinder( r = 1.5, h = 10);
	translate([-9.5,0, -7]) color( "Blue") cylinder( r = 1.5, h = 25);
	
	translate([75, -10,-7]) color( "Blue") cylinder( r = 1.5, h = 16);
	*/

}
