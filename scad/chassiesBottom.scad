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
	iHeight = 150; //всего длина
	iRadius = 8; //радиус боковин

	iDepth = gcShassiesBottomDepth;
	iDepthClips = gcShassiesBottomClips;

	iFrontWidth		= 80; //ширина передней части
	iFrontHeight	= 45; //длина передней части
	iFrontEarsWidth = 9; //выступ ушей за пределы ширины
	iFrontEarsTop	= 31; //расположение ушей относительно передней части
	iFrontEarsInWidth = -20; //выступ внутренней стороны крепления;
	iFrontEarsInTop = 7;


	iRearWidth		= 80; //ширина задней части
	iRearEarsWidth	= 20; //выступ ушей в ширину
	iRearEarsBottom = 24; //отступ снизу
	

	union()
	{
		//передняя часть
		hull()
		{
			//передняя часть
			translate([-iFrontWidth/2, iHeight/2 - iFrontHeight, 0])cube([iFrontWidth, iFrontHeight, iDepth]);

			//уши справа передней части
			translate([ iFrontWidth/2, iHeight/2 - iRadius, 0])cylinder(r = iRadius, h = iDepth);
			translate([ iFrontWidth/2 + iFrontEarsWidth, iHeight/2 - iFrontEarsTop, 0])cylinder(r = iRadius, h = iDepth);

			//уши слева
			translate([ -iFrontWidth/2, iHeight/2 - iRadius, 0])cylinder(r = iRadius, h = iDepth);
			translate([ -iFrontWidth/2 - iFrontEarsWidth, iHeight/2 - iFrontEarsTop, 0])cylinder(r = iRadius, h = iDepth);
		} 

		//задняя часть
		hull()
		{
			translate([-iRearWidth/2, -(iHeight / 2), 0])cube([iRearWidth, iHeight - iFrontHeight, iDepth]);

			//уши справа
			translate([ iRearWidth/2, -iHeight/2 + iRadius, 0])cylinder(r = iRadius, h = iDepth);
			translate([ iRearWidth/2 + iRearEarsWidth, -iHeight/2 + iRearEarsBottom , 0])cylinder(r = iRadius, h = iDepth);

			//уши слева
			translate([ -iRearWidth/2, -iHeight/2 + iRadius, 0])cylinder(r = iRadius, h = iDepth);
			translate([ -iRearWidth/2 - iRearEarsWidth, -iHeight/2 + iRearEarsBottom , 0])cylinder(r = iRadius, h = iDepth);

		}

		//
		//крепления
		//
		translate([0,0,iDepth])
		union()
		{
			//верхняя часть
			hull()
			{
				//уши справа передней части
				translate([ iFrontWidth/2, iHeight/2 - iRadius, 0])cylinder(r = iRadius, h = iDepthClips);
				translate([ iFrontWidth/2 + iFrontEarsWidth, iHeight/2 - iFrontEarsTop, 0])cylinder(r = iRadius, h = iDepthClips);

				translate([ iFrontWidth/2 + iFrontEarsInWidth, iHeight/2 - iFrontEarsInTop -  iRadius, 0])cylinder(r = iRadius, h = iDepthClips);
				translate([ iFrontWidth/2 + iFrontEarsInWidth + iFrontEarsWidth, iHeight/2 - iFrontEarsInTop - iFrontEarsTop - 4, 0])cylinder(r = iRadius, h = iDepthClips);
			}

			hull()
			{
				//шуи слева			
				translate([ -iFrontWidth/2, iHeight/2 - iRadius, 0])cylinder(r = iRadius, h = iDepthClips);
				translate([ -iFrontWidth/2 - iFrontEarsWidth, iHeight/2 - iFrontEarsTop, 0])cylinder(r = iRadius, h = iDepthClips);

				translate([ -iFrontWidth/2 - iFrontEarsInWidth, iHeight/2 - iFrontEarsInTop -  iRadius, 0])cylinder(r = iRadius, h = iDepthClips);
				translate([ -iFrontWidth/2 - iFrontEarsInWidth - iFrontEarsWidth, iHeight/2 - iFrontEarsInTop - iFrontEarsTop - 4, 0])cylinder(r = iRadius, h = iDepthClips);
			}


		}

	}

}
//-------------------------------------------------------------------------------------//






/* //===================================================================================*
* //                                                                                    *
* // выступ для фиксации верхней части	    											*
* //------------------------------------------------------------------------------------*
*///
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
}
//-------------------------------------------------------------------------------------//









/* //===================================================================================*
* //                                                                                    *
* // отрисовка крепления лучей			       											*
* //------------------------------------------------------------------------------------*
*///
module chassiesBottom_clipsRays()
{
	iWidth = 40;
	iHeight = 30;
	iDepth = gcShassiesBottomClips;

	translate([-iWidth/2,-iHeight/2,0])cube([iWidth, iHeight, iDepth]);
}
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // полная отрисовка всех креплений на шасси											*
* //------------------------------------------------------------------------------------*
*///
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

}
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // крепление нижней и средней деки шасси												*
* //------------------------------------------------------------------------------------*
*///
module chassies_mountScrews()
{
}
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // вырез отверстий под болты															*
* //------------------------------------------------------------------------------------*
*///
module chassies_mountScrewsInside()
{
}
//-------------------------------------------------------------------------------------//










/* //===================================================================================*
* //                                                                                    *
* // отрисовка нижней части шасси              											*
* //------------------------------------------------------------------------------------*
*///
module chassiesBottom()
{
	difference()
	{
		union()
		{
			chassiesBottomFull();	//само шасси

			//chassiesBottom_clipsRaysAll(); //клипсы
		}
		
		
		//направляющие лучи
		translate([0,-gcShassiesBottomRearIndent, gcShassiesBottomClips])
		union()
		{
			chassies_rays();
			mirror([1,0,0]) chassies_rays();
		}
		
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








        
        


