RegisterCommand('w_way', function(source)
    local blip = GetFirstBlipInfoId(8)
    local blipX = 0.0
    local blipY = 0.0
    
    if (blip ~= 0) then
        local coord = GetBlipCoords(blip)
        local hejspiller = GetPlayerPed(-1)
        blipX = coord.x
        blipY = coord.y
        print(coord)
        print(coord.x, coord.y, 1)
        SetPedCoordsKeepVehicle(hejspiller, coord.x, coord.y, 0.0);
    end 
end)