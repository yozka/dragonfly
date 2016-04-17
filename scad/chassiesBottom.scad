/* создание шасси нижния часть где установлены двигатели
*/
include <conf/config.scad>
include <vitamins/screws.scad>
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // отрисовка нижней части шасси              											*
* //------------------------------------------------------------------------------------*
*///
module chassiesBottomFull()
{
	//chassiesBottom_clipsRaysFull();
	
	union()
	{
		//верхнее крепление
		hull()
		{
			1_clipsFront();
			mirror([1,0,0])1_clipsFront();
		}

					
		//нижнее крепление
		hull()
		{
			1_clipsRear();
			mirror([1,0,0]) 1_clipsRear();
			
			translate([-gcShassiesBottom_frontWidth / 2, gcShassiesBottom_front, -gcRayClips_depth / 2]) cube([gcShassiesBottom_frontWidth, 10, gcRayClips_depth]);
		}
	}
}
//-------------------------------------------------------------------------------------//






/* //===================================================================================*
* //                                                                                    *
* // передние крепление			              											*
* //------------------------------------------------------------------------------------*
*///
module 1_clipsFront(iScale = 1)
{
	//верхнее крепление
		translate(gRaysFront())
			rotate(gRaysFrontAngle())
				rotate([0,0,90])translate([0, -gRaysFrontLength() - motorESC[1],0])
					scale([iScale, iScale, 1])
					chassiesBottom_clipsRaysFull();
}
//-------------------------------------------------------------------------------------//





/* //===================================================================================*
* //                                                                                    *
* // задние крепление			              											*
* //------------------------------------------------------------------------------------*
*///
module 1_clipsRear(iScale = 1)
{
	translate(gRaysRear())
		rotate(gRaysRearAngle())
			rotate([0,0,90])translate([0, -gRaysRearLength() - motorESC[1],0])
				scale([iScale, iScale, 1])
				chassiesBottom_clipsRaysFull();
}
//-------------------------------------------------------------------------------------//









/* //===================================================================================*
* //                                                                                    *
* // отрисовка нижней части шасси внутрянка вырез										*
* //------------------------------------------------------------------------------------*
*///
module chassiesBottomInside()
{
	iWidth = 120;
	iHeight = 150;
	iScale = 0.9;
	
	iWidthRear = gcShassiesBottom_frontWidth * iScale;
	//chassiesBottomFull();
	union()
	{
		//верхний срез
		translate([-iWidth/2, 0,0]) cube([iWidth, iHeight,15]);
		
		difference()
		{
			translate([0,0, gcShassiesBottom_thickness])
			union()
			{
				//верхнее крепление
				hull()
				{
					1_clipsFront(iScale);
					mirror([1,0,0])1_clipsFront(iScale);
				}

							
				//нижнее крепление
				hull()
				{
					1_clipsRear(iScale);
					mirror([1,0,0]) 1_clipsRear(iScale);
					
					translate([-iWidthRear / 2, gcShassiesBottom_front, -gcRayClips_depth / 2]) cube([iWidthRear, 10, gcRayClips_depth]);
				}
			}
			
			//место под крепление лучей
			1_clipsFront(); mirror([1,0,0])1_clipsFront();
			1_clipsRear();  mirror([1,0,0]) 1_clipsRear();
			
			//место распорок усиливающих
			translate([-2, 0, -15]) cube([4, 82, 20]);
			translate([-1, 78, -15])rotate([0,0,45])cube([4, 80, 20]);
			translate([-1, 78 + 4, -15])rotate([0,0,-45])cube([4, 80, 20]);
		}
	}
}
//-------------------------------------------------------------------------------------//






/* //===================================================================================*
* //                                                                                    *
* // выступ для фиксации верхней части	    											*
* //------------------------------------------------------------------------------------*
*///
/*
module chassies_rays()
{
	//верхний лучь
	translate(gRaysFront())
		rotate(gRaysFrontAngle())
			union()
			{
				translate([motorESC[1],0,0]) rotate([90,0,90]) cylinder(r=gcTube[0]/2, h = gRaysFrontLength());
			}
			
	//нижний лучь
	translate(gRaysRear())
		rotate(gRaysRearAngle())
			union()
			{
				translate([motorESC[1],0,0]) rotate([90,0,90]) cylinder(r=gcTube[0]/2, h = gRaysRearLength());
			}
}*/
//-------------------------------------------------------------------------------------//









/* //===================================================================================*
* //                                                                                    *
* // отрисовка крепления лучей	без внутреннего выреза									*
* //------------------------------------------------------------------------------------*
*///
module chassiesBottom_clipsRaysFull()
{
	iWidth 	= gcRayClips_width;
	iHeight 	= gcRayClips_height;
	iDepth 	= gcRayClips_depth;
	iRadius	= gcRayClips_radius; //радиус закругления клипсы
	
	ix = iWidth / 2 - iRadius;
	
	iTop = -iDepth / 2;
	
	difference()
	{
	hull()
	{
		translate([-ix, iRadius, iTop]) cylinder(r = iRadius, h = iDepth);
		translate([ ix, iRadius, iTop]) cylinder(r = iRadius, h = iDepth);
		translate([-ix, iHeight - iRadius, iTop]) cylinder(r = iRadius, h = iDepth);
		translate([ ix, iHeight - iRadius, iTop]) cylinder(r = iRadius, h = iDepth);
	}
	
	translate([0, - 5, 0])rotate([0,90,90])cylinder(r=6, h =10);
	}
}
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // полная отрисовка всех креплений на шасси											*
* //------------------------------------------------------------------------------------*
*///
/*
module chassiesBottom_clipsRaysAll()
{
	translate([0,0, gcShassiesBottomClips])
	#union()
	{

		//верхнее крепление
		translate(gRaysFront())
			rotate(gRaysFrontAngle())
				union()
				{
					translate([motorESC[1] + gRaysFrontLength(), motorESC[0] *2,0]) rotate([0,0,0]) chassiesBottom_clipsRays();
				}
			
		//нижнее крепление
		translate(gRaysRear())
			rotate(gRaysRearAngle())
				union()
				{
					translate([motorESC[1],0,0]) rotate([00,0,00]) chassiesBottom_clipsRays();
				}
	}

}*/
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // крепление нижней и средней деки шасси												*
* //------------------------------------------------------------------------------------*
*///
/*
module chassies_mountScrews()
{
}
*/
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // вырез отверстий под болты															*
* //------------------------------------------------------------------------------------*
*///
/*
module chassies_mountScrewsInside()
{
}*/
//-------------------------------------------------------------------------------------//










/* //===================================================================================*
* //                                                                                    *
* // отрисовка нижней части шасси              											*
* //------------------------------------------------------------------------------------*
*///
module chassiesBottom()
{
	translate([0,0, gcShassiesBottom_depth])
	difference()
	{
		union()
		{
			chassiesBottomFull();	//само шасси

			//chassiesBottom_clipsRaysAll(); //клипсы
		}
		
		
		chassiesBottomInside();
		
	}
}
//-------------------------------------------------------------------------------------//










/* //===================================================================================*
* //                                                                                    *
* // нижняя часть шасси для печати         												*
* //------------------------------------------------------------------------------------*
*///
module print_chassiesBottom()
{
	chassiesBottom();
}








        
        


