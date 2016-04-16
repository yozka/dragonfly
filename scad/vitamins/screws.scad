/*
�����
*/


include <../conf/config.scad>


M3_hex_screw   = ["HX030", "M3 hex screw", 
		3,			//������� �����
		6.4,		//������� ������� ��� ������������
		2.125,		//������� ���� ������
		6,			//������� ������ ������
		4			//������ ������ �����
		];



//����� ��� ���� � ������
module screw_seat(type, length, lengthHead)
{
	head_rad = type[3] / 2;
	rad = type[2] / 2;
	lh = lengthHead + eta_screw;

	cylinder(r = head_rad, h = lengthHead, $fn = 6);
	translate([0,0, lh])cylinder(r = rad, h = length - lh);
}



//����� ��� ���� � ��������
module screwHead_seat(type, length, lengthHead)
{
	head_rad = type[5] / 2;
	rad = type[2] / 2;
	lh = lengthHead + eta_screw;

	cylinder(r = head_rad, h = lengthHead);
	translate([0,0, lh])cylinder(r = rad, h = length - lh);
}




//����� ��� ���� � ������
module screw_double(type, length, lengthHead)
{
	head_rad = type[3] / 2;
	rad = type[2] / 2;
	lh = lengthHead + eta_screw;

	cylinder(r = head_rad, h = lengthHead, $fn = 6);
	translate([0,0, lh])cylinder(r = rad, h = length - lh * 2 - eta_screw);
	translate([0,0, length - lh]) cylinder(r = head_rad, h = lengthHead, $fn = 6);
}

