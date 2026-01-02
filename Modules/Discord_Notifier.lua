local HttpService = game:GetService("HttpService")
local Module = {}

function Module.Send(fishName, weight)
    -- 1. SETTING WEBHOOK & PROXY
    local WebhookURL = "https://discord.com/api/webhooks/1456380736641831086/lRLi_uAxOXZ5b2GjBrP370x0EIKA0VPmJNeWkteXGs6xlWPAOjsjFx1PoSMYnkKg4ikJ"
    local ProxyURL = WebhookURL:gsub("discord.com", "webhook.lewisakura.moe") 
    
    -- 2. DATA YANG DIKIRIM
    local data = {
        ["content"] = "🎣 **EDINOE LOG**",
        ["embeds"] = {{
            ["title"] = "Ikan Baru Tertangkap!",
            ["description"] = "Nama Ikan: " .. tostring(fishName) .. "\nBerat: " .. tostring(weight) .. " Kg",
            ["color"] = 0x00ff00,
            ["footer"] = {["text"] = "Time: " .. os.date("%X")}
        }}
    }

    -- 3. EKSEKUSI KIRIM (Multi-Executor Support)
    local requestFunc = syn and syn.request or http_request or request or (http and http.request)
    
    if requestFunc then
        local success, response = pcall(function()
            return requestFunc({
                Url = ProxyURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(data)
            })
        end)
        
        if success then
            print("✅ Berhasil kirim ke Discord!")
        else
            warn("❌ Gagal kirim: " .. tostring(response))
        end
    else
        warn("❌ Executor lo gak support HTTP Request!")
    end
end

return Module

