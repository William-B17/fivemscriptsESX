ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('w:sell')
AddEventHandler('w:sell', function(item,minp,maxp,itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tvcount = xPlayer.getInventoryItem(item).count

    local tv1 = xPlayer.getInventoryItem('tv').count
    local tv2 = xPlayer.getInventoryItem('microwave').count
    local tv3 = xPlayer.getInventoryItem('telescope').count
    local tv4 = xPlayer.getInventoryItem('laptop').count
    local tv5 = xPlayer.getInventoryItem('rolex').count
    local tv6 = xPlayer.getInventoryItem('art').count
    local tv7 = xPlayer.getInventoryItem('coffeemaker').count

    if tvcount > 0 then
        local amount = (math.random(minp,maxp) * tvcount)
        xPlayer.removeInventoryItem(item, tvcount)
        xPlayer.addAccountMoney('black_money', amount)
        TriggerClientEvent('w:sound', source)
        local mess = "Du solgte "..tvcount.."x ["..itemname.."] for DKK "..amount
        --TriggerClientEvent('w:success', source, mess)
        if tv1 > 0 or tv2 > 0 or tv3 > 0 or tv4 > 0 or tv5 > 0 or tv6 > 0 or tv7 > 0 then
            TriggerClientEvent('w:success', source, mess)
        end
    elseif tvcount <= 0 then
        TriggerClientEvent('w:fail', source)
    end

end)