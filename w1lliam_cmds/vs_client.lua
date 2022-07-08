CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

RegisterCommand('w_way', function(source)
    local blip = GetFirstBlipInfoId(8)
    local blipX = 0.0
    local blipY = 0.0
    
    if (blip ~= 0) then
        local coord = GetBlipCoords(blip)
        local playerped = GetPlayerPed(-1)
        blipX = coord.x
        blipY = coord.y
        print(coord)
        print(coord.x, coord.y, 1)
        SetPedCoordsKeepVehicle(playerped, coord.x, coord.y, 0.0);
    end 
end)

RegisterCommand('w_bomb', function(source)
    AddExplosion(5062.88, -5771.07, 14.70256, 2, 0, 1, 0, 1065353216)
    --local model = "uj_cayom_pool_litter"
    --local modelhashed = GetHashKey(model)
   -- DeleteObject("uj_cayom_pool_door")
    --RequestModel(modelhashed)
   -- CreateObject(481240831, 5062.88, -5771.07, 17.70256, false, false, false)
    local object = "uj_cayom_pool_door"
    DeleteEntity(object)

end)


RegisterCommand('w_copywc', function(source)
	local coords = GetEntityCoords(PlayerPedId())
	SendNUIMessage({
		coords = ""..coords.x..","..coords.y..","..coords.z..""
	})
    print(coords)
end)

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(15000)
        end
        Citizen.Wait(100) -- Wait 0 seconds to prevent crashing.
        SetBlackout(blackout)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(0)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('vSync:requestSync')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/w_vejr', 'Skift vejret.', {{ name="weatherType", help="Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
    TriggerEvent('chat:addSuggestion', '/w_tid', 'Skift tidspunktet.', {{ name="hours", help="A number between 0 - 23"}, { name="minutes", help="A number between 0 - 59"}})
    TriggerEvent('chat:addSuggestion', '/w_frystid', 'Frys / optø tid.')
    TriggerEvent('chat:addSuggestion', '/w_frysvejr', 'Trænd/sluk dynamisk vejr.')
    TriggerEvent('chat:addSuggestion', '/w_morgen', 'Set tid til 09:00')
    TriggerEvent('chat:addSuggestion', '/w_dag', 'Set tid til 12:00')
    TriggerEvent('chat:addSuggestion', '/w_aften', 'Set tid til 18:00')
    TriggerEvent('chat:addSuggestion', '/w_nat', 'Set tid til 23:00')
    TriggerEvent('chat:addSuggestion', '/w_blackout', 'Skift blackout.')
end)

-- Display a notification above the minimap.
function ShowNotification(text, blink)
    if blink == nil then blink = false end
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(blink, false)
end

RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message, blink)
    ShowNotification(message, blink)
end)

