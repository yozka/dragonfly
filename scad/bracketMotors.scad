/* Держатель моторов
*/
include <conf/config.scad>
include <vitamins/screws.scad>
//-------------------------------------------------------------------------------------//





function bracketHeight()		= 11 + gcThicknessBracket * 2; //размер по высоте платы
function bracketHeightMount()	= gcTube[0] + 5; //высота крепления
function bracketVaterline()		= bracketHeight() - bracketHeightMount() / 2;//нижняя граница от центральной оси






/* //===================================================================================*
* //                                                                                    *
* // отрисовка держателя мотора наполение      											*
* //------------------------------------------------------------------------------------*
*///
module bracketMotorsFull()
{
	iRadius			= motor[0] / 2 + 2;
	iRadiusOutside	= iRadius + gcThicknessBracket;
	iLength			= motor[1] / 2.5;
	iHeight			= bracketHeight();//размер по высоте платы
	iHeightMount	= bracketHeightMount(); //высота крепления


	//наполнение
	translate([0,0,iHeight - iHeightMount / 2])
	union()
	{
		//крепление двигателя
		cylinder(r=iRadiusOutside, h = iLength);
	
		//крепление платы
		hull()
		{
			translate([0,0,-iHeight])
			cylinder(r=iRadiusOutside, h = iHeight + 5);
			
			translate([motorESC[1] + 15, 0,-iHeight])
			cylinder(r=iRadiusOutside - 4, h = iHeightMount);
		}
		

		translate([iRadius - 5,-gcThicknessBracket/2,0])rotate([0,5,0])cube([motorESC[1]+15, gcThicknessBracket, 10]);
		
	}




	
}
//-------------------------------------------------------------------------------------//














/* //===================================================================================*
* //                                                                                    *
* // внутренния вырезка	под крепление тубуса луча										*
* //------------------------------------------------------------------------------------*
*///
module bracketMotorsClipInside()
{
	iLengthClip = 22; //длинка зажима для тубуса
	union()
	{
		rotate([0,90,0]) translate([0, 0,  motorESC[1]])
		{
			intersection()
			{
				translate([eta_tube_compensation,0,0])cylinder(r=gcTube[0]/2 + eta_tube, h = iLengthClip + 20);
				translate([-eta_tube_compensation,0,0])cylinder(r=gcTube[0]/2 + eta_tube, h = iLengthClip + 20);
			}
			translate([0, 0,  -iLengthClip]) cylinder(r=gcTube[1]/2 - 0.5, h = iLengthClip + 1);
			translate([0, 0,  iLengthClip / 2 + 4]) cylinder(r=gcTube[0]/2 + 1, h = 3);
			translate([0, 0,  iLengthClip / 2 - 4]) cylinder(r=gcTube[0]/2 + 1, h = 3);
		}
		
		//болты
		translate([motorESC[1] + 12, -(gcTube[0]/2 + 3), -15]) screw_double(M3_hex_screw, 30,9.5);
		translate([motorESC[1] + 12,  (gcTube[0]/2 + 3), -15]) screw_double(M3_hex_screw, 30,9.5);
	}

}
//-------------------------------------------------------------------------------------//











/* //===================================================================================*
* //                                                                                    *
* // внутренния вырезка	под мотор														*
* //------------------------------------------------------------------------------------*
*///
module bracketMotorsInside()
{
	iRadius			= motor[0] / 2 + 2;
	iRadiusOutside	= iRadius + gcThicknessBracket;
	iLength			= motor[1] / 2;
	iHeight			= 11;//размер по высоте платы
	iScrewH			= 3; //высота крепления мотора
	
	iHeightESC = motorESC[2];


	iRadiusScrewsMount	= 4.5; //радиус крепление болтов двигателя

	translate([0,0,iHeight])
	union()
	{

		//дырка под мотор
		difference()
		{
			cylinder(r=iRadius, h = iLength);
			
			translate([-motor[2]/2, 0, 0])cylinder(r=iRadiusScrewsMount, h = iScrewH);
			translate([ motor[2]/2, 0, 0]) cylinder(r=iRadiusScrewsMount, h = iScrewH);
			translate([0, -motor[3]/2, 0]) cylinder(r=iRadiusScrewsMount, h = iScrewH);
			translate([0,  motor[3]/2, 0]) cylinder(r=iRadiusScrewsMount, h = iScrewH);
		}

		
		//болты
		translate([-motor[2]/2, 0, -iHeight -12.0]) screw_seat(M3_hex_screw, 28,5);
		translate([ motor[2]/2, 0, -iHeight]) screw_seat(M3_hex_screw, 16,5);
		translate([0, -motor[3]/2, -iHeight]) screw_seat(M3_hex_screw, 16,5);
		translate([0,  motor[3]/2, -iHeight]) screw_seat(M3_hex_screw, 16,5);
		
		
		//под провода
		/*
		difference()
		{
			hull()
			{
				translate([-8.5,-8.5,	-(iHeightESC - iHeight) - iHeight])cylinder(r=3.9, h = iHeightESC);
				translate([-6,-12,		-(iHeightESC - iHeight) - iHeight])cylinder(r=2.5, h = iHeightESC);
			}
			translate([-14,-18, -iHeight + iHeightESC / 2 + eta_layer_height])cube([14,14, eta_layer_height]);
		}
		*/
		translate([-15,-15,	iScrewH + 4]) rotate([-45,90,0]) cylinder(r=4, h = 10);
		translate([-15,-15,	-iHeight]) rotate([-45,90,0]) cylinder(r=2.5, h = 10);
		
	}

}
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // внутренния вырезка	под регулятор													*
* //------------------------------------------------------------------------------------*
*///
module bracketMotorsESCInside()
{

	
	iWidth = motorESC[1] + 1;
	iHeight = motorESC[0] ;
	iDepth = motorESC[2];
	
	translate([0,0,0.5])
	difference()
	{
		hull()
		{
			//сама плата внутренняя
			translate([-5.5 + iWidth / 2, -iHeight/2, -iDepth/2])
				cube([iWidth / 2, iHeight, iDepth]);
		
			//переход на трубку
			translate([iWidth - 3.5,0,0])rotate([90,0,90])cylinder(r=gcTube[1]/2,h=1);


			//на держателя двигателя
			translate([-0.5, 0, -iDepth/2])cylinder(r=motor[0]/2 + gcThicknessBracket, h = iDepth);
		}

		//крепление нижнией части и стойка для крепления двигателя
		translate([-motor[2]/2, 0, -iDepth/2]) 
		hull()
		{
			cylinder(r=5, h = iDepth);
			translate([-6,0,0])cylinder(r=2, h = iDepth);
		}

	}
}
//-------------------------------------------------------------------------------------//






/* //===================================================================================*
* //                                                                                    *
* // внутренния вырезка	под щели охлаждения												*
* //------------------------------------------------------------------------------------*
*///
module bracketMotorsVentInside()
{

	
	iWidth = motorESC[1];
	iHeight = 8;
	iRadius = 4;
	
	translate([1,0,0])
	union()
	{
		hull()
		{
			translate([iWidth - 8, -iHeight + 1, -11])cylinder(r=iRadius, h=30);
			translate([19, -iHeight,-11])cylinder(r=iRadius, h=30);
		}
		
		hull()
		{
			translate([iWidth - 8, iHeight - 1,-11])cylinder(r=iRadius, h=30);
			translate([19, iHeight,-11])cylinder(r=iRadius, h=30);
		}
	}
	
	
	/*
	for ( i = [0 : 3] )
	{
		translate([i * 16,25,0])rotate([90,0,0])cylinder(r=4, h=50);
	}
	*/
	
}
//-------------------------------------------------------------------------------------//






/* //===================================================================================*
* //                                                                                    *
* // отрисовка держателя мотора              											*
* //------------------------------------------------------------------------------------*
*///
module bracketMotors()
{
	difference()
	{
		union()
		{
			bracketMotorsFull();	//сам поддон
		}


		//вырезающие части
		bracketMotorsClipInside();//вырезка под клипсу крепления
		bracketMotorsInside();//выерзка под мотор
		bracketMotorsESCInside();//вырезка под регулятор
		bracketMotorsVentInside();
	}
}
//-------------------------------------------------------------------------------------//













/* //===================================================================================*
* //                                                                                    *
* // отрисовка для печати, вехняя часть держателя										*
* //------------------------------------------------------------------------------------*
*///
module print_bracketMotorsTop()
{
	difference()
	{
		bracketMotors();
		translate([-30,-25,-30])cube([130,50,30]);
	}
	
	//отрисовка подпорки
	wi = motorESC[1] + 0;
	hi = motorESC[0] + 0;
	ti = motorESC[2] / 2 + eta_layer_height;
	translate([-3, -hi / 2, ti])cube([wi,hi, eta_layer_height]);

	#for ( i = [[-10,16,0],[-10,-16,0],[85,16,0], [85,-16,0]] )
	{
		translate(i)cylinder(r=9, h=eta_layer_height);
	}
}
//-------------------------------------------------------------------------------------//







/* //===================================================================================*
* //                                                                                    *
* // отрисовка для печати, нижняя часть держателя										*
* //------------------------------------------------------------------------------------*
*///
module print_bracketMotorsBottom()
{
	wi = motorESC[1] + 3;
	hi = motorESC[0] + 3;
	ti = gcThicknessBracket + 0.3;

	union()
	{
		translate([0,0, bracketHeightMount()/2])
		difference()
		{
			bracketMotors();
			translate([-30,-25,0])cube([130,50,30]);
		}
		//отрисовка подпорки
		//#translate([-5, -hi / 2, ti])cube([wi,hi, 0.7]);


	}
}
//-------------------------------------------------------------------------------------//

