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
