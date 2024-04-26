
function sendDiscordLogs(message)
    
    -- Paste your Discord WebHook here:
    local Discord_WebHook = ""

    local data = {
        content = message
    }
    PerformHttpRequest(Discord_WebHook, function(err, text, headers)
    end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end