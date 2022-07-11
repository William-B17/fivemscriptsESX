ScubaToggle = true

RegisterCommand('w_div', function(source)
	local Oxygen = 100.0
	local ped = GetPlayerPed(-1)
	local OxygenTank = Oxygen

	function checkUnderWater()
		while IsPedSwimmingUnderWater(ped) do
			Citizen.Wait(1000)
			if(Oxygen > 0) then
				Oxygen = Oxygen - 1
				print(Oxygen)
				SetEnableScuba(ped, true)
				SetEnableScubaGearLight(ped, true)
				SetPedMaxTimeUnderwater(ped, OxygenTank)
			elseif(Oxygen <= 0) then
				print("Du burde være død")
				ScubaToggle = false
				break
			end
		end
	end

	while ScubaToggle do
		Citizen.Wait(0)
		checkUnderWater()
	end
end)







--[[
Citizen.CreateThread(function()
   while true do
      Wait(0)

        
        local diverPed = {
          --Put the diverped inside here like
         "diverped name",
          -- you can also add all the peds you want it on here!

        }


        local ped = GetPlayerPed(-1)

        if checkSkin() then
           if IsPedSwimmingUnderWater(ped) then
              SetPedDiesInWater(ped, false)
           end
        end

        function CheckSkin(ped)
        	for i = 1, #diverPed do
	           if GetHashKey(skins[i]) == GetEntityModel(ped) then
			   	return true
		       end
	        end
	        return false
         end
    end
end)]]--