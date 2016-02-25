If ((currentWeapon player == primaryWeapon player) or (currentWeapon player == handgunWeapon player)) then
{
_Sound_Effect = "Land_HelipadEmpty_F" createVehicle position player;
_Sound_Effect say3D "Sewer_Tail";

Sleep 5;

deleteVehicle _Sound_Effect;}
