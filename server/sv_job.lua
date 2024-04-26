local ESX = exports['es_extended']:getSharedObject()

lib.locale()

if HS.Updates then
    lib.versionCheck('HorizonScripts/hs-deliveryjob')
end

RegisterNetEvent('hs-deliveryjob:reward')
AddEventHandler('hs-deliveryjob:reward', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local count = math.random(HS.reward.min, HS.reward.max)
    local item = 'money' -- Money item

    if HS.oxInventory then
        exports.ox_inventory:AddItem(_source, item, count)
    else
        xPlayer.addInventoryItem(item, count)
    end

    -- Discord Logs:
    if HS.discordLogs then
        playerName = GetPlayerName(source)
        local logMessage = string.format(locale('discord_log_message'), playerName, count)
        sendDiscordLogs(logMessage)
    end

end)