/* �������
*/

include <../conf/config.scad>
//-------------------------------------------------------------------------------------//










/* //===================================================================================*
* //                                                                                    *
* // �������							                        						*
* //------------------------------------------------------------------------------------*
*/// 
module speaker()
{
	color("red")cylinder(r=8, h=3);


	
}
//-------------------------------------------------------------------------------------//














/* //===================================================================================*
* //                                                                                    *
* // ��������� ��������								            						*
* //------------------------------------------------------------------------------------*
*/// 
module render_speaker()
{
	translate([-22, -30, 52]) rotate([30,-30,0])speaker();
}