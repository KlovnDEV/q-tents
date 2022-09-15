
-- Hvis du ville ændre logo´et gå til linje 16 i ui.css

-- Hvis du ville ændre farven gå til linje 20 in ui.css

local cycleTime = 3

local restTime = 2

local nameEnabled = true

local name = "TENT'S ROLEPLAY"

local linkEnabled = true

local link = 'Discord.gg/GxQ6B6y7Qj'


-- Ville du ændre logoet skal du huske at bruge samme størelsesforhold og mindst være 128px x 128px
-- Du kan ændre logoere eller tekst ved hjælp ved at skrive /stop simple_watermark og derefter /start simple_watermark eller /restart simple_watermark. 
-- (Når du restarter et script dur det ikke altid)

local logoEnabled = true

------------------------------------

local showWatermark = true

CreateThread(function()
  Wait(1000)
  --print('hello')
  -- send config values to NUI
  SendNuiMessage(json.encode{
    type = 'setup',
    nametext = name,
    linktext = link,
  })
  Wait(2000)
  while true do

    if nameEnabled then
      --print('Name Enabled')
      -- show name
      SendNuiMessage(json.encode{
        type = 'showItem',
        item = 'name',
      })

      Wait(cycleTime * 1000)
      -- hide
      Wait(1000)
    end

    if linkEnabled then
      --print('Link Enabled')
      -- show link
      SendNuiMessage(json.encode{
        type = 'showItem',
        item = 'link',
      })

      Wait(cycleTime * 1000)
      -- hide
      Wait(1000)
    end

    if logoEnabled then
      --print('Logo Enabled')
      -- show logo
      SendNuiMessage(json.encode{
        type = 'showItem',
        item = 'logo',
      })

      Wait(cycleTime * 1000)
      -- hide
      Wait(1000)
    end

    SendNuiMessage(json.encode{
      type = 'showItem',
      item = 'none',
    })

    Wait(restTime * 1000)
  end
end)
