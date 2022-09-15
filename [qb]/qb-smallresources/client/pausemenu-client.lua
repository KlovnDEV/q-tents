function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

-- Uncomment if you want add Players Steam or connected players

local id = PlayerId()
local serverID = GetPlayerServerId(PlayerId())
players = {}
for i = 0, 255 do
    if NetworkIsPlayerActive( i ) then
        table.insert( players, i )
    end
end

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~r~Tents - Test Server')
  AddTextEntry('PM_PANE_LEAVE', '~r~Disconnect')
  AddTextEntry('PM_PANE_QUIT', '~r~Leave The City')
  AddTextEntry('PM_SCR_MAP', '~g~Map')
  AddTextEntry('PM_SCR_GAM', '~g~Game')
  AddTextEntry('PM_SCR_INF', '~g~Info')
  AddTextEntry('PM_SCR_SET', '~g~Settings')
  AddTextEntry('PM_SCR_STA', '~g~Statistics')
  AddTextEntry('PM_SCR_RPL', '~g~Publisher ∑')
end)
