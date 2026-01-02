-- [[ MODULE: DISCORD NOTIFIER ]] --
local HttpService = game:GetService("HttpService")

local Module = {}

function Module.Send(fishName, weight)
    local WebhookURL = "https://discord.com/api/webhooks/1456380736641831086/lRLi_uAxOXZ5b2GjBrP370x0EIKA0VPmJNeWkteXGs6xlWPAOjsjFx1PoSMYnkKg4ikJ"
    local ProxyURL = WebhookURL:gsub("discord.com", "webhook.lewisakura.moe") 
    
    local payload = HttpService:JSONEncode({
        ["embeds"] = {{
            ["title"] = "🎣 NEW CATCH!",
            ["description"] = "Ikan: " .. tostring(fishName) .. "\nBerat: " .. tostring(weight) .. " Kg",
            ["color"] = 3066993
        }}
    })
    
    local req = request or http_request or (syn and syn.request)
    if req then
        pcall(function()
            req({
                Url = ProxyURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = payload
            })
        end)
    end
end

return Module

