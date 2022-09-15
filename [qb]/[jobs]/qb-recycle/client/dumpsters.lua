local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)

local searched = {34343435323} -- No Touch.
local canSearch = true -- No touch.
local searchTime = 3000 -- How long after successful skill check the serach takes
local dumpsters = { 218085040, 666561306, -58485588, -206690185, 1511880420, 682791951, 1437508529, 2051806701, -246439655, 74073934, -654874323, 651101403, 909943734, 1010534896, 1614656839, -130812911, -93819890,
1329570871, 1143474856, -228596739, -468629664, -1426008804, -1187286639, -1096777189, -413198204, 437765445, -1830793175, -329415894, -341442425, -2096124444, 122303831, 1748268526, 998415499,
-5943724, -317177646, 1380691550, -115771139, -85604259, 1233216915, 375956747, 673826957, 354692929, -14708062, 811169045, -96647174, 1919238784, 275188277, 16567861, -1224639730, -1414390795, }

--Loading/Unloading Asset Functions
function loadAnimDict(dict)	if Config.Debug then print("^5Debug^7: ^2Loading Anim Dictionary^7: '^6"..dict.."^7'") end while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Wait(5) end end
function unloadAnimDict(dict) if Config.Debug then print("^5Debug^7: ^2Removing Anim Dictionary^7: '^6"..dict.."^7'") end RemoveAnimDict(dict) end

CreateThread(function()
	--Dumpster Third Eye
	exports['qb-target']:AddTargetModel(dumpsters, { options = { { event = "jim-recycle:Dumpsters:Search", icon = "fas fa-dumpster", label = Loc[Config.Lan].target["search_trash"], }, }, distance = 1.5 })
end)

--Search animations
local function startSearching(coords)
    canSearch = false
    --Calculate if you're facing the trash--
    if #(coords - GetEntityCoords(PlayerPedId())) > 1.5 then TaskGoStraightToCoord(PlayerPedId(), coords, 0.4, 200, 0.0, 0) Wait(300) end
    lookEnt(coords)
    --    if not IsPedHeadingTowardsPosition(PlayerPedId(), coords, 20.0) then TaskTurnPedToFaceCoord(PlayerPedId(), coords, 1500) Wait(1500) end
    local dict = 'amb@prop_human_bum_bin@base'
    local anim = 'base'
    loadAnimDict(dict)
    --Play Serach animation
    TaskPlayAnim(PlayerPedId(), dict, anim, 2.0, 2.0, searchTime, 1, 1, 0, 0, 0)
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(searchTime)
    --Stop Animation
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    --Allow a new search
    canSearch = true
    unloadAnimDict(dict)
    --Give rewards
    TriggerServerEvent("jim-recycle:Dumpsters:Reward")
end

RegisterNetEvent('jim-recycle:Dumpsters:Search', function()
    if canSearch then
        local dumpsterFound = false
        for i = 1, #dumpsters do
            local dumpster = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, dumpsters[i], false, false, false)
            if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(dumpster)) < 1.8 then
                if Config.Debug then print("^5Debug^7: ^2Starting Search of entity^7: '^6"..dumpster.."^7'") end
                for i = 1, #searched do
                    if searched[i] == dumpster then dumpsterFound = true end -- Theres a dumpster nearby
                    if i == #searched and dumpsterFound then TriggerEvent("QBCore:Notify", Loc[Config.Lan].error["searched"], "error") return -- Let player know already searched
                    elseif i == #searched and not dumpsterFound then -- If hasn't been searched yet
                        local dict = "anim@amb@machinery@speed_drill@"
                        local anim = "look_around_left_02_amy_skater_01"
                        loadAnimDict(dict)
                        TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 1.0, 3500, 1.5, 5, 0, 0, 0)
                        if Config.useQBLock then
                            local success = exports['qb-lock']:StartLockPickCircle(math.random(2,4), math.random(10,15), success)
                            if success then
                                TriggerEvent("QBCore:Notify", Loc[Config.Lan].success["get_trash"], "success")
                                startSearching(GetEntityCoords(dumpster))
                                searched[i+1] = dumpster
                            else
                                TriggerEvent("QBCore:Notify", Loc[Config.Lan].error["nothing"], "error")
                                searched[i+1] = dumpster
                                ClearPedTasks(PlayerPedId())
                            end
                        else
                            local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
                            Skillbar.Start({
                                duration = math.random(2500,5000),
                                pos = math.random(10, 30),
                                width = math.random(10, 20),
                            }, function()
                                TriggerEvent("QBCore:Notify", Loc[Config.Lan].success["get_trash"], "success")
                                startSearching(GetEntityCoords(dumpster))
                                searched[i+1] = dumpster
                                Citizen.Wait(1000)
                            end, function()
                                TriggerEvent("QBCore:Notify", Loc[Config.Lan].error["nothing"], "error")
                                searched[i+1] = dumpster
                                ClearPedTasks(PlayerPedId())
                                Citizen.Wait(1000)
                            end)
                        end
                        break
                    end
                end
            end
        end
    end
end)