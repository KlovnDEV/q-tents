--Kazumi Developments Police Garage System. DISCORD > https://discord.gg/V78FzkbBjA
local QBCore = exports['qb-core']:GetCoreObject()

vehPropsfromClient = {}

QBCore.Functions.CreateCallback('dontyoubelookingatme', function(_, cb)
    cb(Config)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        MySQL.Async.fetchAll("SELECT * FROM `barnfind`", function(ex)
            if ex[1] ~= nil then
                if ex[1]['owner'] ~= nil then
                    Config.IsClaimed = true 
                    Config.WinnerCid = ex[1]['owner']
                end
            end
        end)
    end 
end)

RegisterNetEvent('oneofone:server:claim')
AddEventHandler('oneofone:server:claim', function()
    local pedloc = GetEntityCoords(GetPlayerPed(source), false)
    local dist = find_distance(pedloc.x, pedloc.y, Config.VehicleLoc.x, Config.VehicleLoc.y)
    if dist <= 5 then
        Config.IsClaimed = true
        Config.Winner = source
        Config.WinnerCid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        TriggerClientEvent('oneofone:client:claim', -1, Config.Winner, true)
    else
        print('ban this pleb')
    end
end)

RegisterNetEvent('oneofone:server:winner')
AddEventHandler('oneofone:server:winner', function()
    if source == Config.Winner then
        TriggerClientEvent('QBCore:Notify', source, "You have claimed the car, The car is being transported to the new location on your GPS!")
        TriggerClientEvent('oneofone:client:waypoint', source)
        local WinnerPerson = QBCore.Functions.GetPlayer(source)
        local WinnerCitid = WinnerPerson.PlayerData.citizenid
        MySQL.Async.insert("INSERT INTO `barnfind` (`owner`, `model`, `copper`, `aluminum`, `steel`, `plastic`, `glass`, `rubber`) VALUES ('"..WinnerCitid.."', '"..Config.VehicleName.."', '"..Config.VehicleCost.copper.."', '"..Config.VehicleCost.aluminum.."', '"..Config.VehicleCost.steel.."', '"..Config.VehicleCost.plastic.."', '"..Config.VehicleCost.glass.."', '"..Config.VehicleCost.rubber.."')")
    end
    if source ~= Config.Winner then
        print('ban this pleb')      --ADD YOUR BAN FUNCTION HERE  
    end
end)

--[[RegisterNetEvent('oneofone:server:complete')
AddEventHandler('oneofone:server:complete', function(props)
    local cid = QBCore.Functions.GetPlayer(source)
    if cid.PlayerData.citizenid == Config.WinnerCid then
        if props then
            local nig = {damage = 10, fuel = 98}

            --NOTE!!!!
            --THIS WAS USED WITH BB GARAGES! YOU WILL NEED TO CONVERT THIS TO HOWEVER YOUR SERVER SAVES VEHICLES TO THE DATABASE.
            MySQL.Async.insert("INSERT INTO `bbvehicles` (`citizenid`, `plate`, `model`, `props`, `stats`, `state`) VALUES ('"..Config.WinnerCid.."', '"..props.plate.."', '"..Config.VehicleName.."', '"..json.encode(props).."', '"..json.encode(nig).."', 'unknown')")
        else    
            TriggerClientEvent("vehiclekeys:client:SetOwner", source)
        end
    end
end)]]

SQL = function(query, parameters, cb)
    local res = nil
    local IsBusy = true
    if string.find(query, "SELECT") then
        MySQL.Async.fetchAll(query, parameters, function(result)
            if cb then
                cb(result)
            else
                res = result
                IsBusy = false
            end
        end)
    else
        MySQL.Async.execute(query, parameters, function(result)
            if cb then
                cb(result)
            else
                res = result
                IsBusy = false
            end
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return res
  end

RegisterNetEvent('oneofone:server:complete')
AddEventHandler('oneofone:server:complete', function(mods)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local vehicle = QBCore.Shared.Vehicles[Config.VehicleName]['hash']
    local result = SQL('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    if Player.PlayerData.citizenid == Config.WinnerCid then
        if mods then
            if result[1] == nil then
                SQL('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                Player.PlayerData.license,
                Config.WinnerCid,
                Config.VehicleName,
                GetHashKey(vehicle),
                json.encode(mods),
                mods.plate,
                0
                })
            end
        else
            TriggerClientEvent("vehiclekeys:client:SetOwners", src)
        end
    end
end)

RegisterCommand("check", function(source, args, raw)
    print(json.encode(vehPropsfromClient))
    local SCid = QBCore.Functions.GetPlayer(source)
    if SCid.PlayerData.citizenid == Config.WinnerCid then
        local ploc = GetEntityCoords(GetPlayerPed(source), false)
        local dist = find_distance(ploc.x, ploc.y, Config.ShopLoc.x, Config.ShopLoc.y)
        if dist <= 2.8 then
            MySQL.Async.fetchAll("SELECT * FROM `barnfind` WHERE `owner` = '"..Config.WinnerCid.."'", function(ex)
                if ex[1] ~= nil then
                    if ex[1]['owner'] == SCid.PlayerData.citizenid then
                        if ex[1]['copper'] == 0 and ex[1]['aluminum'] == 0 and ex[1]['steel'] == 0 and ex[1]['plastic'] == 0 and ex[1]['glass'] == 0 and ex[1]['rubber'] == 0 then
                            Config.Bop = true
                            TriggerClientEvent('oneofone:client:claim', -1, Config.Winner, false)
                            MySQL.Async.execute("DELETE FROM `barnfind` WHERE `owner` = '"..Config.WinnerCid.."'")
                        else
                            TriggerClientEvent('QBCore:Notify', source, "<b>Resources Needed:</b><br><b>Copper</b> : "..ex[1]['copper'].."<br><b>Aluminum</b> : "..ex[1]['aluminum'].."<br><b>Steel</b> : "..ex[1]['steel'].."<br><b>Plastic</b> : "..ex[1]['plastic'].."<br><b>Glass</b> : "..ex[1]['glass'].."<br><b>Rubber</b> : "..ex[1]['rubber'].."")
                        end    
                    end
                end
            end)
        end
    end
end)

RegisterCommand("copper", function(source, args, raw)
    local SCid = QBCore.Functions.GetPlayer(source)
    if SCid.PlayerData.citizenid == Config.WinnerCid then
        local ploc = GetEntityCoords(GetPlayerPed(source), false)
        local dist = find_distance(ploc.x, ploc.y, Config.ShopLoc.x, Config.ShopLoc.y)
        if dist <= 2.8 then
            MySQL.Async.fetchAll("SELECT * FROM `barnfind` WHERE `owner` = '"..Config.WinnerCid.."'", function(ex)
                if ex[1] ~= nil then
                    if ex[1]['owner'] == SCid.PlayerData.citizenid then
                        if SCid.Functions.GetItemByName('copper') ~= nil then
                            local amountofc = SCid.Functions.GetItemByName('copper').amount
                            local amounttouse = tonumber(args[1])
                            if amounttouse == nil or type(amounttouse) ~= 'number' then
                                print('invalid input')
                            else
                                if amounttouse > amountofc then
                                    TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Copper!", 'error')
                                else
                                    if amounttouse > ex[1]['copper'] then
                                        TriggerClientEvent('QBCore:Notify', source, "The Car Doesn't Need This Much Copper!", 'error')
                                    else
                                        local RemoveFromDataBase = (ex[1]['copper'] - amounttouse)
                                        TriggerClientEvent('QBCore:Notify', source, "You Applied "..amounttouse.." Copper!")
                                        SCid.Functions.RemoveItem('copper', amounttouse, SCid.Functions.GetItemByName('copper').slot)
                                        MySQL.Sync.fetchAll("UPDATE `barnfind` SET `copper` = '"..RemoveFromDataBase.."' WHERE `owner` = '"..Config.WinnerCid.."'")
                                    end
                                end
                            end
                        else
                            TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Copper!", 'error')
                        end
                    end
                end
            end)
        end
    end
end)

RegisterCommand("aluminum", function(source, args, raw)
    local SCid = QBCore.Functions.GetPlayer(source)
    if SCid.PlayerData.citizenid == Config.WinnerCid then
        local ploc = GetEntityCoords(GetPlayerPed(source), false)
        local dist = find_distance(ploc.x, ploc.y, Config.ShopLoc.x, Config.ShopLoc.y)
        if dist <= 2.8 then
            MySQL.Async.fetchAll("SELECT * FROM `barnfind` WHERE `owner` = '"..Config.WinnerCid.."'", function(ex)
                if ex[1] ~= nil then
                    if ex[1]['owner'] == SCid.PlayerData.citizenid then
                        if SCid.Functions.GetItemByName('aluminum') ~= nil then
                            local amountofc = SCid.Functions.GetItemByName('aluminum').amount
                            local amounttouse = tonumber(args[1])
                            if amounttouse == nil or type(amounttouse) ~= 'number' then
                                print('invalid input')
                            else
                                if amounttouse > amountofc then
                                    TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Aluminum!", 'error')
                                else
                                    if amounttouse > ex[1]['aluminum'] then
                                        TriggerClientEvent('QBCore:Notify', source, "The Car Doesn't Need This Much Aluminum!", 'error')
                                    else
                                        local RemoveFromDataBase = (ex[1]['aluminum'] - amounttouse)
                                        TriggerClientEvent('QBCore:Notify', source, "You Applied "..amounttouse.." Aluminum!")
                                        SCid.Functions.RemoveItem('aluminum', amounttouse, SCid.Functions.GetItemByName('aluminum').slot)
                                        MySQL.Sync.fetchAll("UPDATE `barnfind` SET `aluminum` = '"..RemoveFromDataBase.."' WHERE `owner` = '"..Config.WinnerCid.."'")
                                    end
                                end
                            end
                        else
                            TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Aluminum!", 'error')
                        end
                    end
                end
            end)
        end
    end
end)

RegisterCommand("steel", function(source, args, raw)
    local SCid = QBCore.Functions.GetPlayer(source)
    if SCid.PlayerData.citizenid == Config.WinnerCid then
        local ploc = GetEntityCoords(GetPlayerPed(source), false)
        local dist = find_distance(ploc.x, ploc.y, Config.ShopLoc.x, Config.ShopLoc.y)
        if dist <= 2.8 then
            MySQL.Async.fetchAll("SELECT * FROM `barnfind` WHERE `owner` = '"..Config.WinnerCid.."'", function(ex)
                if ex[1] ~= nil then
                    if ex[1]['owner'] == SCid.PlayerData.citizenid then
                        if SCid.Functions.GetItemByName('steel') ~= nil then
                            local amountofc = SCid.Functions.GetItemByName('steel').amount
                            local amounttouse = tonumber(args[1])
                            if amounttouse == nil or type(amounttouse) ~= 'number' then
                                print('invalid input')
                            else
                                if amounttouse > amountofc then
                                    TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Steel!", 'error')
                                else
                                    if amounttouse > ex[1]['steel'] then
                                        TriggerClientEvent('QBCore:Notify', source, "The Car Doesn't Need This Much Steel!", 'error')
                                    else
                                        local RemoveFromDataBase = (ex[1]['steel'] - amounttouse)
                                        TriggerClientEvent('QBCore:Notify', source, "You Applied "..amounttouse.." Steel!")
                                        SCid.Functions.RemoveItem('steel', amounttouse, SCid.Functions.GetItemByName('steel').slot)
                                        MySQL.Sync.fetchAll("UPDATE `barnfind` SET `steel` = '"..RemoveFromDataBase.."' WHERE `owner` = '"..Config.WinnerCid.."'")
                                    end
                                end
                            end
                        else
                            TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Steel!", 'error')
                        end
                    end
                end
            end)
        end
    end
end)

RegisterCommand("plastic", function(source, args, raw)
    local SCid = QBCore.Functions.GetPlayer(source)
    if SCid.PlayerData.citizenid == Config.WinnerCid then
        local ploc = GetEntityCoords(GetPlayerPed(source), false)
        local dist = find_distance(ploc.x, ploc.y, Config.ShopLoc.x, Config.ShopLoc.y)
        if dist <= 2.8 then
            MySQL.Async.fetchAll("SELECT * FROM `barnfind` WHERE `owner` = '"..Config.WinnerCid.."'", function(ex)
                if ex[1] ~= nil then
                    if ex[1]['owner'] == SCid.PlayerData.citizenid then
                        if SCid.Functions.GetItemByName('plastic') ~= nil then
                            local amountofc = SCid.Functions.GetItemByName('plastic').amount
                            local amounttouse = tonumber(args[1])
                            if amounttouse == nil or type(amounttouse) ~= 'number' then
                                print('invalid input')
                            else
                                if amounttouse > amountofc then
                                    TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Plastic!", 'error')
                                else
                                    if amounttouse > ex[1]['plastic'] then
                                        TriggerClientEvent('QBCore:Notify', source, "The Car Doesn't Need This Much Plastic!", 'error')
                                    else
                                        local RemoveFromDataBase = (ex[1]['plastic'] - amounttouse)
                                        TriggerClientEvent('QBCore:Notify', source, "You Applied "..amounttouse.." Plastic!")
                                        SCid.Functions.RemoveItem('plastic', amounttouse, SCid.Functions.GetItemByName('plastic').slot)
                                        MySQL.Sync.fetchAll("UPDATE `barnfind` SET `plastic` = '"..RemoveFromDataBase.."' WHERE `owner` = '"..Config.WinnerCid.."'")
                                    end
                                end
                            end
                        else
                            TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Plastic!", 'error')
                        end
                    end
                end
            end)
        end
    end
end)

RegisterCommand("glass", function(source, args, raw)
    local SCid = QBCore.Functions.GetPlayer(source)
    if SCid.PlayerData.citizenid == Config.WinnerCid then
        local ploc = GetEntityCoords(GetPlayerPed(source), false)
        local dist = find_distance(ploc.x, ploc.y, Config.ShopLoc.x, Config.ShopLoc.y)
        if dist <= 2.8 then
            MySQL.Async.fetchAll("SELECT * FROM `barnfind` WHERE `owner` = '"..Config.WinnerCid.."'", function(ex)
                if ex[1] ~= nil then
                    if ex[1]['owner'] == SCid.PlayerData.citizenid then
                        if SCid.Functions.GetItemByName('glass') ~= nil then
                            local amountofc = SCid.Functions.GetItemByName('glass').amount
                            local amounttouse = tonumber(args[1])
                            if amounttouse == nil or type(amounttouse) ~= 'number' then
                                print('invalid input')
                            else
                                if amounttouse > amountofc then
                                    TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Glass!", 'error')
                                else
                                    if amounttouse > ex[1]['glass'] then
                                        TriggerClientEvent('QBCore:Notify', source, "The Car Doesn't Need This Much Glass!", 'error')
                                    else
                                        local RemoveFromDataBase = (ex[1]['glass'] - amounttouse)
                                        TriggerClientEvent('QBCore:Notify', source, "You Applied "..amounttouse.." Glass!")
                                        SCid.Functions.RemoveItem('glass', amounttouse, SCid.Functions.GetItemByName('glass').slot)
                                        MySQL.Sync.fetchAll("UPDATE `barnfind` SET `glass` = '"..RemoveFromDataBase.."' WHERE `owner` = '"..Config.WinnerCid.."'")
                                    end
                                end
                            end
                        else
                            TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Glass!", 'error')
                        end
                    end
                end
            end)
        end
    end
end)

RegisterCommand("rubber", function(source, args, raw)
    local SCid = QBCore.Functions.GetPlayer(source)
    if SCid.PlayerData.citizenid == Config.WinnerCid then
        local ploc = GetEntityCoords(GetPlayerPed(source), false)
        local dist = find_distance(ploc.x, ploc.y, Config.ShopLoc.x, Config.ShopLoc.y)
        if dist <= 2.8 then
            MySQL.Async.fetchAll("SELECT * FROM `barnfind` WHERE `owner` = '"..Config.WinnerCid.."'", function(ex)
                if ex[1] ~= nil then
                    if ex[1]['owner'] == SCid.PlayerData.citizenid then
                        if SCid.Functions.GetItemByName('rubber') ~= nil then
                            local amountofc = SCid.Functions.GetItemByName('rubber').amount
                            local amounttouse = tonumber(args[1])
                            if amounttouse == nil or type(amounttouse) ~= 'number' then
                                print('invalid input')
                            else
                                if amounttouse > amountofc then
                                    TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Rubber!", 'error')
                                else
                                    if amounttouse > ex[1]['rubber'] then
                                        TriggerClientEvent('QBCore:Notify', source, "The Car Doesn't Need This Much Rubber!", 'error')
                                    else
                                        local RemoveFromDataBase = (ex[1]['rubber'] - amounttouse)
                                        TriggerClientEvent('QBCore:Notify', source, "You Applied "..amounttouse.." Rubber!")
                                        SCid.Functions.RemoveItem('rubber', amounttouse, SCid.Functions.GetItemByName('rubber').slot)
                                        MySQL.Sync.fetchAll("UPDATE `barnfind` SET `rubber` = '"..RemoveFromDataBase.."' WHERE `owner` = '"..Config.WinnerCid.."'")
                                    end
                                end
                            end
                        else
                            TriggerClientEvent('QBCore:Notify', source, "You Don't Have Enough Rubber!", 'error')
                        end
                    end
                end
            end)
        end
    end
end)

function find_distance(xorigin, yorigin, xdestination, ydestination)
    if xorigin > xdestination then
        xdistance = xorigin - xdestination
    elseif xorigin < xdestination then
        xdistance = xdestination - xorigin
    end
    
    if yorigin > ydestination then
        ydistance = yorigin - ydestination
    elseif yorigin < ydestination then
        ydistance = ydestination - yorigin
    end
    
    return math.sqrt(xdistance ^ 2 + ydistance ^ 2)
end