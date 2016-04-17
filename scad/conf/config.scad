
//люфт при печати, уменьшение внутренней деталей для компенсацией печати
eta_motor	= 0.5;	//люфты подкрепления мотора
eta_screw	= 0.4;	//удерживающий мост под болт
eta_tube	= 0.6;	//люфт крепления тубы
eta_tube_compensation = 0.5; //люфт печати компенации овала

eta_layer_height = 0.4;	//толщина слоя




//чистовая ширина шасси
gcRotorFrontWidth				= 450;	//расстояние между ртора спереди
gcRotorRearWidth				= 450;	//расстояние между роторами задними
gcRotorLength					= 400;	//расстояние между пердним и задним ротором

//размер пропеллера
gcPropLength					= 260;	//размер пропеллера



//тип двигателя
// 0 - диаметр
// 1 - высота
// 2 - расстояние 1
// 3 - расстояние 2 крепления болтов от оси
motor = [28,30, 19, 16];


//электроника ESC
// ширина
// длина
// высота
motorESC = [26, 63, 15];



//размер трубок
gcTube = [12, 11]; 


//
// крепление двигателей
//
gcThicknessBracket = 1.5; //толщина брекета крепления мотора
gcThicknessSupport = 3; //толщина поддержки крепления






//
// лучи двигателей
//

//передние
function gRaysFront()			= [gcRotorFrontWidth / 2, gcRotorLength / 2, 0]; //местоположение начало луча
function gRaysFrontAngle()		= [0,0,180 + 21];//поворот луча
function gRaysFrontLength()		= 170;//размер переднего карбонового луча

//задние
function gRaysRear()			= [gcRotorRearWidth / 2, -gcRotorLength / 2, 0]; //местоположение начало луча
function gRaysRearAngle()		= [0,0,180 - 51];//поворот луча
function gRaysRearLength()		= 260;//размер задняго карбонового луча




//
// клипса крепления луча
//
gcRayClips_depth		= gcTube[0] + 3 + 3; //высота крепления клипс
gcRayClips_width		= 30; //ширина клипсы
gcRayClips_height  	= 40; //длина клипсы
gcRayClips_radius 	= 10; //радиус закругления клипсы


//
// нижняя часть шасси
//
gcShassiesBottom_depth		= gcRayClips_depth / 2; //высота шасси
gcShassiesBottom_front		= 100; //отступ передней части
gcShassiesBottom_frontWidth	= 60; //ширина шасси переднего 
gcShassiesBottom_thickness	= 3;




//
//DEBUG
gcDebugMargin               = 0.5;   //растояние между деталями.



