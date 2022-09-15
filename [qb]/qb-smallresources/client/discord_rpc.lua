
---CONFIG
local QBCore = exports["qb-core"]:GetCoreObject()
local ApplicationID = 957546883524472832
local serverName = "TENT'S || TEST SERVER"
local mainTextType = 2

--[[
1 = Shows the total playercount of the server the client is playing on.
2 = Will scroll through the maintext1-5 below. This depends on what you set mainTextScroll to. setting to 3 will have it go through mainText 1-3.
3 = Show player's health.
]]

local mainTextScroll = 4 --setting this to 1 will only display mainText1
local mainText1 = "JOIN THIS SERVER CLICK!"
local mainText2 = "TENT'S || TEST SERVER"
local mainText3 = "OPENING SOON SERVER"
local mainText4 = "Join our DISCORD"
local mainText5 = "TEST SERVER"

local enableButton1 = true
local buttonText = "Connect"
local buttonLink = "fivem://connect/cfx.re/join/a9kdbk"

-- Put a 2nd button below the first one.
local enableButton2 = true
local buttonText2 = "DISCORD"
local buttonLink2 = "https://discord.io/GxQ6B6y7Qj"

-- Put a 3rd button below the 2nd one.
local enableButton3 = false
local buttonText3 = "forums"
local buttonLink3 = "https://google.com"

local allowHide = true
-- people can use /hiderpc to mask their status, if they want.

-- Disable whichever actions you dont want to show up here
local showStation = true
local showAreas = true 
-- local showDeath = true
local clientHide = false
-- playerCount = 0
local scrollCount = 0

RegisterCommand('rpchide', function(source, args)
	if allowHide == true then
		if clientHide == true then
			clientHide = false
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = false,
				args = {"^7^*[^4DiscordRPC^7] ^r^7Your Discord status is now ^2^*Shown^r^7!"}
			  })	
		elseif clientHide == false then
			clientHide = true
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = false,
				args = {"^7^*[^4DiscordRPC^7] ^r^7Your Discord status is now ^1^*Hidden^r^7!"}
			  })		
		end
	else
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = false,
			args = {"^7^*[^4DiscordRPC^7] ^r^7This feature has been ^1^*disabled^r^7!"}
		  })	
	end
end, false)

-- RegisterNetEvent("rpc:sendCount")
-- AddEventHandler("rpc:sendCount", function(playerTotal)
--     playerCount = playerTotal
-- end)


CreateThread(function()
	while true do
		local ped = PlayerPedId()
		SetDiscordAppId(ApplicationID) --LETS GET THIS STARTED IN HERE
		if mainTextType == 1 then
			Wait(100)
			QBCore.Functions.TriggerCallback('smallresources:server:GetCurrentPlayers', function(result)
				SetRichPresence('Players: '..result..'/50')
			end)
		elseif mainTextType == 2 then
			scrollCount = scrollCount + 1
			if scrollCount > mainTextScroll then
				scrollCount = 1
			end
			if scrollCount == 1 then
		
				QBCore.Functions.TriggerCallback('smallresources:server:GetCurrentPlayers', function(result)
					SetRichPresence('Players: '..result..'/50')
				end)
			elseif scrollCount == 2 then
				SetRichPresence(mainText2)
			elseif scrollCount == 3 then
				SetRichPresence(mainText3)
			elseif scrollCount == 4 then
				SetRichPresence(mainText4)
			else
				SetRichPresence(mainText5)
			end
		else
			local currHealth = GetEntityHealth(ped)
			local maxHealth = GetPedMaxHealth(ped)
			if currHealth ~= 1 then
				SetRichPresence("Health: " .. currHealth .. "/" .. maxHealth .. "") --male peds have 200, females have 100. ROCKSTAR = MISOGYNISTS
			else
				SetRichPresence("Dead...")
			end
		end

		SetDiscordRichPresenceAsset('tentsbig')
		SetDiscordRichPresenceAssetText(serverName)
		--SetDiscordRichPresenceAssetSmall('sjrpsmall')

		if clientHide == true then 
			SetDiscordRichPresenceAssetSmall('hidden')
			SetDiscordRichPresenceAssetSmallText("Status hidden")
			Wait(5000)
		else
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(ped,true))))
			local areaName = GetLabelText(GetNameOfZone(table.unpack(GetEntityCoords(ped,true))))
			local altitude = math.floor(GetEntityHeightAboveGround(ped, true))

			if (showAreas == true and areaName == "Galileo Observatory") then
				SetDiscordRichPresenceAssetSmall('observatory')
				SetDiscordRichPresenceAssetSmallText("At the Galileo Observatory")
			elseif (showAreas == true and areaName == "GWC and Golfing Society") then
				SetDiscordRichPresenceAssetSmall('golfing')
				SetDiscordRichPresenceAssetSmallText("Golfing at LS Golf Club")
			elseif (showAreas == true and areaName == "Mount Chiliad" or areaName == "Mount Josiah" or areaName == "Mount Gordo") then
				SetDiscordRichPresenceAssetSmall('mountain')
				SetDiscordRichPresenceAssetSmallText("Climbing " .. areaName .. "")
			elseif (showAreas == true and areaName == "Los Santos International Airport") then
				SetDiscordRichPresenceAssetSmall('airport')
				SetDiscordRichPresenceAssetSmallText("At Los Santos International Airport")
			elseif (showAreas == true and GetDistanceBetweenCoords(GetEntityCoords(ped), 118.3, -1288.4, 28.2, true) <= 40.000) then
				SetDiscordRichPresenceAssetSmall('stripclub')
				SetDiscordRichPresenceAssetSmallText("At the stripclub!?")
			elseif (showAreas == true and GetDistanceBetweenCoords(GetEntityCoords(ped), -74.94, -819.1, 326.1, true) <= 40.000) then
				SetDiscordRichPresenceAssetSmall('building')
				SetDiscordRichPresenceAssetSmallText("Ontop the Mazebank Tower")
			elseif (showAreas == true and areaName == "Del Perro Beach" or areaName == "Vespucci Beach") then
				SetDiscordRichPresenceAssetSmall('pier')
				SetDiscordRichPresenceAssetSmallText("At " .. areaName .. "")
			elseif (showAreas == true and areaName == "Fort Zancudo") then
				SetDiscordRichPresenceAssetSmall('zancudo')
				SetDiscordRichPresenceAssetSmallText("At Fort Zancudo")
			elseif (showStation == true and GetDistanceBetweenCoords(GetEntityCoords(ped), 1853.20, 3690.7, 39.0, true) <= 60.000) then
				SetDiscordRichPresenceAssetSmall('policestation')
				SetDiscordRichPresenceAssetSmallText("Nearby Sandy SO")
			elseif (showStation == true and GetDistanceBetweenCoords(GetEntityCoords(ped), 455.9, -992.8, 30.7, true) <= 100.000) then
				SetDiscordRichPresenceAssetSmall('policestation')
				SetDiscordRichPresenceAssetSmallText("Nearby Missionrow PD")
			elseif (showStation == true and GetDistanceBetweenCoords(GetEntityCoords(ped), -1096.3, -840.1, 37.6, true) <= 100.000) then
				SetDiscordRichPresenceAssetSmall('policestation')
				SetDiscordRichPresenceAssetSmallText("Nearby Vespucci PD")
			elseif (showStation == true and GetDistanceBetweenCoords(GetEntityCoords(ped), -450.6, 6006.7, 36.6, true) <=70.000) then
				SetDiscordRichPresenceAssetSmall('policestation')
				SetDiscordRichPresenceAssetSmallText("Nearby Paleto PD")
			elseif (showStation == true and GetDistanceBetweenCoords(GetEntityCoords(ped), 1687.1, 2604.1, 45.5, true) <= 125.000) then
				SetDiscordRichPresenceAssetSmall('injail')
				SetDiscordRichPresenceAssetSmallText("In prison :(")
			--If you want to add more locations, remove the --'s from the next 3 lines, and remove this line you're reading
			--elseif GetDistanceBetweenCoords(GetEntityCoords(ped), X, Y, Z, false) < 125.000 then
			--	SetDiscordRichPresenceAssetSmall('ICON_NAME')
			--	SetDiscordRichPresenceAssetSmallText("HOVER_TEXT")
			elseif IsPedOnFoot(ped) == false then
				local vehicle = GetVehiclePedIsIn(ped, false)
				local vehicleClass = GetVehicleClass(vehicle)
				local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(ped))))
				local vehspeed = math.floor(GetEntitySpeed(vehicle)*2.236936)
				if (vehicle == nil or vehicle == "" or vehicle == "NULL") then 
					SetDiscordRichPresenceAssetSmall('vehicle')
					if vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a " .. vehicleName .. "\n at " .. streetName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Driving a " .. vehicleName .. "\n" .. vehspeed .. "mph down " .. streetName .. "")
					end
				elseif (vehicleClass == 8 or vehicleClass == 13) then
					SetDiscordRichPresenceAssetSmall('motorcycle')
					if vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a " .. vehicleName .. "\n at " .. streetName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Driving a " .. vehicleName .. "\n" .. vehspeed .. "mph down " .. streetName .. "")
					end
				elseif vehicleClass == 15 then
					SetDiscordRichPresenceAssetSmall('helicopter')
					if altitude >= 15 then
						SetDiscordRichPresenceAssetSmallText("Piloiting a " .. vehicleName .. "\n " .. altitude .. "m above " .. areaName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Grounded in a " .. vehicleName .. "\n at " .. areaName .. "")
					end
				elseif (vehicleClass == 16) then
						SetDiscordRichPresenceAssetSmall('plane')
					if altitude >= 15 then
						SetDiscordRichPresenceAssetSmallText("Piloiting a " .. vehicleName .. "\n " .. altitude .. "m above " .. areaName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Grounded in a " .. vehicleName .. "\n at " .. areaName .. "")
					end
				elseif IsPedInAnySub(ped) == true then
					SetDiscordRichPresenceAssetSmall('submarine')
					SetDiscordRichPresenceAssetSmallText("Using a " .. vehicleName .. "\n in " .. areaName .. "")
				elseif vehicleClass == 14 then
					SetDiscordRichPresenceAssetSmall('boat')
					SetDiscordRichPresenceAssetSmallText("Sailing in a " .. vehicleName .. "\n" .. vehspeed .. "mph in " .. areaName .. "")
				elseif (IsPlayerRidingTrain(ped) or vehicleClass == 21) then
					SetDiscordRichPresenceAssetSmall('train')
					if vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a train at " .. areaName .. "")
					else
					SetDiscordRichPresenceAssetSmallText("Using a train \n" .. vehspeed .. "mph in " .. areaName .. "")
					end
				elseif vehicleClass == 18 then
					SetDiscordRichPresenceAssetSmall('emergency')
					if IsVehicleSirenOn(vehicle) then 
						if vehspeed <= 2 then
							SetDiscordRichPresenceAssetSmallText("Code 3, parked at " .. streetName .. "")
						else
							SetDiscordRichPresenceAssetSmallText("Code 3 going " .. vehspeed .. "mph down " .. streetName .. "")
						end
					elseif vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a " .. vehicleName .. "\n at " .. streetName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Driving a " .. vehicleName .. "\n" .. vehspeed .. "mph down " .. streetName .. "")
					end
				else
					SetDiscordRichPresenceAssetSmall('vehicle')
					if vehspeed <= 2 then
						SetDiscordRichPresenceAssetSmallText("Parked in a " .. vehicleName .. "\n at " .. streetName .. "")
					else
						SetDiscordRichPresenceAssetSmallText("Driving a " .. vehicleName .. "\n" .. vehspeed .. "mph down " .. streetName .. "")
					end
				end
			elseif IsEntityDead(ped) ~= false then
				SetDiscordRichPresenceAssetSmall('dead')
				SetDiscordRichPresenceAssetSmallText("Dead in " .. areaName .. "")
			elseif GetInteriorFromEntity(ped) ~= 0 and areaName == "San Andreas" then
				SetDiscordRichPresenceAssetSmall('interior')
				SetDiscordRichPresenceAssetSmallText("In an interior")
			elseif GetInteriorFromEntity(ped) ~= 0 then
				SetDiscordRichPresenceAssetSmall('interior')
				SetDiscordRichPresenceAssetSmallText("In an interior at " .. areaName .. "")
			elseif (IsPedSwimming(ped) or IsPedSwimmingUnderWater(ped)) then
				SetDiscordRichPresenceAssetSmall('swimming')
				SetDiscordRichPresenceAssetSmallText("Swimming in " .. areaName .. "")
			elseif GetPedParachuteState(ped) > 0 then
				SetDiscordRichPresenceAssetSmall('parachute')
				SetDiscordRichPresenceAssetSmallText("Parachuting over " .. areaName .. " at " .. altitude .. "m")
			elseif (altitude >= 400 and altitude <= 600) then
				SetDiscordRichPresenceAssetSmall('clouds')
				SetDiscordRichPresenceAssetSmallText("In the clouds")
			elseif altitude >= 601 then
				SetDiscordRichPresenceAssetSmall('space')
				SetDiscordRichPresenceAssetSmallText("In the Atmosphere?!")
			else
				SetDiscordRichPresenceAssetSmall('walking')
				SetDiscordRichPresenceAssetSmallText("On foot in " .. areaName .. "")
			end
			if enableButton1 == true then	
				SetDiscordRichPresenceAction(0, buttonText, buttonLink)
			end
			if enableButton2 == true then
				SetDiscordRichPresenceAction(1, buttonText2, buttonLink2)
			end
			if enableButton3 == true then
				SetDiscordRichPresenceAction(2, buttonText3, buttonLink3)
			end
			--Every 5 seconds the location and display will update
			Wait(5000)
		end
	end --whiletrue end
end)