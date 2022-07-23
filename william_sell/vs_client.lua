
function DrawText3D(x,y,z, text, scalex)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(scalex, scalex)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


RegisterNetEvent('w:sound')
AddEventHandler('w:sound', function(source)
    PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", true)
end)

failstate = false

RegisterNetEvent('w:fail')
AddEventHandler('w:fail', function(source)
    if failstate == false then
        failstate = true
        PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", true)
        exports['mythic_notify']:DoHudText('inform', "Du har ikke nogen (Tv, Mikrobølgeovn, Teleskop, Bærbar, Rolex, Kunst eller Kaffemaskine)", { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
        Citizen.Wait(1400)
        failstate = false
    end
end)

RegisterNetEvent('w:success')
AddEventHandler('w:success', function(source)
    PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", true)
    --print(type(besk))
    exports['mythic_notify']:DoHudText('inform', source, { ['background-color'] = '#00A300', ['color'] = '#ffffff' })
end)

sellstuff = function()
    --TriggerServerEvent('w:checkinv')
    selltv = function(source)
        TriggerServerEvent('w:sell', "tv", 1500, 3000, "Tv")
        Citizen.Wait(200)
        TriggerServerEvent('w:sell', "microwave", 100, 500, "Mikrobølgeovn")
        Citizen.Wait(200)
        TriggerServerEvent('w:sell', "telescope", 500, 2500, "Teleskop")
        Citizen.Wait(200)
        TriggerServerEvent('w:sell', "laptop", 1000, 3000, "Bærbar")
        Citizen.Wait(200)
        TriggerServerEvent('w:sell', "rolex", 2500, 3000, "Rolex")
        Citizen.Wait(200)
        TriggerServerEvent('w:sell', "art", 1500, 2000, "Kunst")
        Citizen.Wait(200)
        TriggerServerEvent('w:sell', "coffeemaker", 500, 1500, "Kaffemaskine")
        Citizen.Wait(200)
    end

    -- add fail function here

    selltv()

end

Citizen.CreateThread(function()
    while true do
        Wait(5)
        local PlayerPos = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(PlayerPos, 471.64, -1323.00, 29.15, true) <= 5 then	
            DrawText3D(471.64, -1323.00, 29.15 + 0.2, "~b~[E]~w~ Sælg stjålne vare", 0.45)
            if IsControlJustPressed(1, 38) then
                sellstuff()
            end
        end	
    end
end)


RefreshPed = function(spawn)
    local Location = { ["x"] = 471.33, ["y"] = -1322.55, ["z"] = 29.15, ["h"] = 220.0, ["hash"] = "s_m_m_snowcop_01" }
   -- LoadModels({ GetHashKey(Location["hash"]) })
    RequestModel(GetHashKey(Location["hash"]))
    local pedId = CreatePed(5, Location["hash"], Location["x"], Location["y"], Location["z"] - 0.985, Location["h"], true)
    SetPedCombatAttributes(pedId, 46, true)                     
    SetPedFleeAttributes(pedId, 0, 0)                      
    SetBlockingOfNonTemporaryEvents(pedId, true)
    
    SetEntityAsMissionEntity(pedId, true, true)
    SetEntityInvincible(pedId, true)
    FreezeEntityPosition(pedId, true)

end

RefreshPed(true)