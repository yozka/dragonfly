/* шарповские инфокрасные сеноры
*/

include <../conf/config.scad>
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // отрисовка инфакрасного сенсора на 10мм    											*
* //------------------------------------------------------------------------------------*
*///
module sharpSensor10mm()
{
	iDepth = 3;
	iShiftZ = 0.5;
	difference()
	{
		union()
		{
			color("darkgreen")	translate([-1.5,0,0])	cube([iDepth, 9, 22], center = true);
			color("DimGray")	translate([2,0,iShiftZ])		cube([4, 7, 13.6], center = true);
			color("DimGray")	translate([2 + 4,0,iShiftZ])	cube([5, 6.14, 13.6], center = true);
			
		}

		translate([-4,0,-9])rotate([0,90,0])cylinder(r = 2.3/2, h = iDepth + 4);
		
	}

}
//-------------------------------------------------------------------------------------//












/* //===================================================================================*
* //                                                                                    *
* // отрисовка ультразвукового сенсора         											*
* //------------------------------------------------------------------------------------*
*///
module render_sharpSensorFront()
{
	translate([gcSharpSensorFrontShiftX, gcSharpSensorFrontShiftY, gcSharpSensorFrontBottom])
	{
		sharpSensor10mm();
	}

	translate([gcSharpSensorFrontShiftX, -gcSharpSensorFrontShiftY, gcSharpSensorFrontBottom])
	{
		sharpSensor10mm();
	}
}
//-------------------------------------------------------------------------------------//










/* //===================================================================================*
* //                                                                                    *
* // отрисовка сенсора положения наличия земли 											*
* //------------------------------------------------------------------------------------*
*///
module render_sharpSensorGround()
{
	translate([gcSharpSensorGroundShiftX, 0, gcSharpSensorGroundBottom])
	rotate([90,90,0])
	{
		sharpSensor10mm();
	}


}
//-------------------------------------------------------------------------------------//











/* //===================================================================================*
* //                                                                                    *
* // отрисовка корпуса держателя сенсора      											*
* //------------------------------------------------------------------------------------*
*///
module sharpSensorFrontMount()
{

	iheight = 9 + gcThicknessChassies * 2;
	ir = 13.4;
	
	difference()
	{
		union()
		{
			translate([-4,0,0]) rotate([90,0,0])cylinder(r = ir, h = iheight, center = true);
			translate([-8,0,0])cube([10,iheight, ir *2], center = true);
		}


		translate([-14.5,0,0]) cube([ir, ir + gcThicknessChassies , ir * 2], center = true);
	}

}
//-------------------------------------------------------------------------------------//










/* //===================================================================================*
* //                                                                                    *
* // отрисовка вырзки нишы		 по сеноср     											*
* //------------------------------------------------------------------------------------*
*///
module sharpSensorFrontMountInside()
{
	iheight = 9 + gcThicknessChassies * 2;
	ir = 15;
	
	union();
	{
		translate([-3.5,-5,-11.5]) cube([4, 10 , 23]);
		translate([0,-4,-6.5]) cube([15, 8 , 14]);

		//translate([-9.5,-4, 7.5]) cube([6, 8 , 10]);
		translate([-9.5,-10/2, 7.5]) cube([6, 10 , 4]);

		translate([0,0,-9])rotate([0,90,0])cylinder(r = 0.8, h = 4);
	}

}
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // отрисовка корпуса держателя сенсора      											*
* //------------------------------------------------------------------------------------*
*///
module chassies_sharpSensorsFront()
{
	translate([gcSharpSensorFrontShiftX, gcSharpSensorFrontShiftY, gcSharpSensorFrontBottom])
	{
		sharpSensorFrontMount();
	}

	translate([gcSharpSensorFrontShiftX, -gcSharpSensorFrontShiftY, gcSharpSensorFrontBottom])
	{
		sharpSensorFrontMount();
	}
}
//-------------------------------------------------------------------------------------//








/* //===================================================================================*
* //                                                                                    *
* // отрисовка выреза для сенсоров     													*
* //------------------------------------------------------------------------------------*
*///
module chassies_sharpSensorsFrontInside()
{
	translate([gcSharpSensorFrontShiftX, gcSharpSensorFrontShiftY, gcSharpSensorFrontBottom])
	{
		sharpSensorFrontMountInside();
	}

	translate([gcSharpSensorFrontShiftX, -gcSharpSensorFrontShiftY, gcSharpSensorFrontBottom])
	{
		sharpSensorFrontMountInside();
	}
}
//-------------------------------------------------------------------------------------//













/* //===================================================================================*
* //                                                                                    *
* // отрисовка корпуса держателя сенсора      											*
* //------------------------------------------------------------------------------------*
*///
module chassies_sharpSensorsGround()
{
	translate([gcSharpSensorGroundShiftX, 0, gcSharpSensorGroundBottom])
	rotate([90,90,0])
	{
		sharpSensorGroundMount();
	}
}
//-------------------------------------------------------------------------------------//




/* //===================================================================================*
* //                                                                                    *
* // корпус деражтеля сенсора для определения земли										*
* //------------------------------------------------------------------------------------*
*///
module sharpSensorGroundMount()
{

	iheight = 9 + gcThicknessChassies * 2;
	iwidth = 32;
	idepth = 13;

	ir = 7;

	itop = -5;


	difference()
	{
		hull()
		{
			translate([itop, -iheight/2, -iwidth / 2])cube([idepth, iheight / 2, iwidth]);
			

			translate([itop, 0, iwidth / 2 - ir])rotate([0,90,0])cylinder(r = ir, h = idepth);
			translate([itop, 0, -iwidth / 2 + ir])rotate([0,90,0])cylinder(r = ir, h = idepth);


			translate([-15,-7,0]) rotate([0,0,90])cylinder(r = 5, h = iwidth + 15, center = true);
			
		}


		//translate([-14.5,0,0]) cube([ir, ir + gcThicknessChassies , ir * 2], center = true);
	}

}
//-------------------------------------------------------------------------------------//
















/* //===================================================================================*
* //                                                                                    *
* // отрисовка корпуса держателя сенсора      											*
* //------------------------------------------------------------------------------------*
*///
module chassies_sharpSensorsGroundInside()
{
	translate([gcSharpSensorGroundShiftX, 0, gcSharpSensorGroundBottom])
	rotate([90,90,0])
	{
		sharpSensorGroundMountInside();
	}
}
//-------------------------------------------------------------------------------------//





/* //===================================================================================*
* //                                                                                    *
* // отрисовка вырзки						 											*
* //------------------------------------------------------------------------------------*
*///
module sharpSensorGroundMountInside()
{
	iheight = 9 + gcThicknessChassies * 2;
	ir = 15;
	
	union();
	{
		translate([-3.5,-5,-11.5]) cube([4, 10 , 23]);
		translate([0,-4,-7.0]) cube([15, 8 , 15]);

		translate([0,0,-9])rotate([0,90,0])cylinder(r = 0.8, h = 4);


		translate([-5.5,-12, 6]) cube([4, 10 , 5]);
	}

}
//-------------------------------------------------------------------------------------//


