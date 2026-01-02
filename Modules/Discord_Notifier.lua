local HttpService = game:GetService("HttpService")
local Module = {}

function Module.Send(fishName, weight)
    -- GANTI URL DI BAWAH DENGAN WEBHOOK LO JIKA BERBEDA
    local WebhookURL = "https://discord.com/api/webhooks/1456380736641831086/lRLi_uAxOXZ5b2GjBrP370x0EIKA0VPmJNeWkteXGs6xlWPAOjsjFx1PoSMYnkKg4ikJ"
    
    -- Mengubah discord.com jadi proxy agar tidak diblokir Roblox
    local ProxyURL = WebhookURL:gsub("discord.com", "webhook.lewisakura.moe")
    
    local headers = {
        ["Content-Type"] = "application/json"
    }
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🎣 Ikan Baru Tertangkap!",
            ["description"] = "**Nama:** " .. tostring(fishName) .. "\n**Berat:** " .. tostring(weight) .. " Kg",
            ["color"] = 65280, -- Warna Hijau
            ["footer"] = {["text"] = "Edinoe Hub • " .. os.date("%X")}
        }}
    }

    -- Kirim Request
    local request = syn and syn.request or http_request or request or (http and http.request)
    if request then
        pcall(function()
            request({
                Url = ProxyURL,
                Method = "POST",
                Headers = headers,
                Body = HttpService:JSONEncode(data)
            })
        end)
    end
end

return Module

