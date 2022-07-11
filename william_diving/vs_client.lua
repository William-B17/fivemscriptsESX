
ScubaToggle = true

RegisterCommand('w_div', function(source)
	local Oxygen = 11.0
	local ped = GetPlayerPed(-1)
	local OxygenTank = Oxygen

	function removeRebreather()
		SetPedComponentVariation(ped, 1, 0, 0, 0)
		SetPedComponentVariation(ped, 8, 0, 0, 0)
		SetEnableScuba(ped, false)
		SetEnableScubaGearLight(ped, false)
	end

	function giveRebreather()
		SetPedComponentVariation(ped, 1, 36, 0, 0)
		SetPedComponentVariation(ped, 8, 123, 0, 0)
		SetEnableScuba(ped, true)
		SetEnableScubaGearLight(ped, true)
	end

	function checkUnderWater()
		while IsPedSwimmingUnderWater(ped) do
			Citizen.Wait(1000)
			if(Oxygen > 10) then
				giveRebreather()
				Oxygen = Oxygen - 1
			elseif(Oxygen > 0) then
				Oxygen = Oxygen - 1
				print(Oxygen)
				SetPedMaxTimeUnderwater(ped, OxygenTank)
			elseif(Oxygen <= 0) then
				print("Hej hej luft")
				ScubaToggle = false
				removeRebreather()
				break
			end
		end
	end


	while ScubaToggle do
		Citizen.Wait(0)
		checkUnderWater()
	end
end)
