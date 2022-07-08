RegisterCommand('w_bomb', function(source)
    function DeleteJackhammer()
        local object = GetClosestObjectOfType(5062.88, -5771.07, 14.70256, 15.0, GetHashKey("uj_cayom_pool_door"), false, false, false)
        if object ~= 0 then
            DeleteObject(object)
        end
    end
    function smokey()
        if not HasNamedPtfxAssetLoaded("core") then
				RequestNamedPtfxAsset("core")
				while not HasNamedPtfxAssetLoaded("core") do
					Wait(1)
				end
			end
		SetPtfxAssetNextCall("core")
        StartParticleFxLoopedAtCoord("exp_water", 5062.88, -5771.07, 13.7, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
        StartParticleFxLoopedAtCoord("exp_grd_grenade", 5062.88, -5771.07, 13.7, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    end               
    smokey()
    AddExplosion(5062.88, -5771.07, 14.70256, 2, 0, 1, 0, 1065353216)
    Citizen.Wait(10.5)
    DeleteJackhammer()
    Citizen.Wait(50.5)
    CreateObject(1938855353, 5062.88, -5771.07, 14.0, false, false, false)
end)

RegisterCommand('w_lid', function(source)
    function DeleteJackhammer2()
        local object = GetClosestObjectOfType(5062.88, -5771.07, 14.70256, 15.0, GetHashKey("uj_cayom_pool_litter"), false, false, false)
        if object ~= 0 then
            DeleteObject(object)
        end
    end
   CreateObject(481240831, 5062.88, -5771.07, 14.70256, false, false, false)
   DeleteJackhammer2()
end)