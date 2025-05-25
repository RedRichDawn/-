function sendDiscordMessage(message, webhookUrl)
    local httpService = game:GetService("HttpService")
    local body = httpService:JSONEncode(message)
    if not body then
        warn("Failed to encode message to JSON")
        return
    end

    local response = httpService:RequestAsync({
        Url = webhookUrl,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = body
    })

    if not response then
        warn("Failed to send message to Discord")
        return
    end
end