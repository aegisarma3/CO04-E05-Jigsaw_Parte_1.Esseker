if (!isServer && hasInterface ) exitWith {};
  // filter for only East units,
  // {if (side _x = east) then
  // You could filter using alternative methods, eg  IsKindof "Man" etc. In this instance filter for all units not on players side.
		{if (side _x != playerSide) then
				// Remove NV GOGGLES based on Side
				{if (_x IsKindof "Man")
						then {
							if ("NVGoggles_OPFOR" in assignedItems _x) then {_x unlinkitem "NVGoggles_OPFOR";_x removeitem "NVGoggles_OPFOR";};
							if ("NVGoggles_INDEP" in assignedItems _x) then {_x unlinkitem "NVGoggles_INDEP";_x removeitem "NVGoggles_INDEP";};
							if ("NVGoggles" in assignedItems _x) then {_x unlinkitem "NVGoggles";_x removeitem "NVGoggles";};
							};
				//Now add Flashlight only if it"s night..
				_GiveFlashlight = sunOrMoon;
				if (_GiveFlashlight < 1)
					then {
						_x enableGunLights "ForceOn";
						/*_x setskill ["spotDistance",(0 + random 0.2)];// Reduced for night time
						_x setskill ["spotTime",(0 + random 0.2)];// ditto*/
						};
			};
		} forEach allUnits;
