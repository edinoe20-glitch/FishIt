-- [[ EDINOE HUB: CHLOE-X EDITION ]] --
local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Stats Tracker (Referensi Chloe-X)
_G.TotalCaught = _G.TotalCaught or 0
_G.SessionStart = _G.SessionStart or os.time()

-- 1. FUNGSI KIRIM WEBHOOK (SANGAT STABIL)
local function SendWebhook(fish, weight)
    local WebhookURL = "https://discord.com/api/webhooks/1456380736641831086/lRLi_uAxOXZ5b2GjBrP370x0EIKA0VPmJNeWkteXGs6xlWPAOjsjFx1PoSMYnkKg4ikJ"
    local ProxyURL = WebhookURL:gsub("discord.com", "webhook.lewisakura.moe")
    
    _G.TotalCaught = _G.TotalCaught + 1
    local playTime = math.floor((os.time() - _G.SessionStart) / 60)
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🎣 Edinoe Hub Log: Ikan Baru!",
            ["description"] = string.format(
                "✅ **Ikan:** %s\n⚖️ **Berat:** %s Kg\n\n**--- Statistik Sesi ---**\n🔢 **Total Ikan:** %d\n⏰ **Lama Main:** %d Menit",
                tostring(fish), tostring(weight), _G.TotalCaught, playTime
            ),
            ["color"] = 0x00ff00,
            ["footer"] = {["text"] = "Logic: Edinoe x Chloe-X • " .. os.date("%X")}
        }}
    }
    
    local request = syn and syn.request or http_request or request or (http and http.request)
    if request then
        pcall(function()
            request({
                Url = ProxyURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(data)
            })
        end)
    end
end

-- 2. GUI PREMIUM (MOBILE FRIENDLY)
if game.CoreGui:FindFirstChild("EdinoePremium") then game.CoreGui.EdinoePremium:Destroy() end
local sg = Instance.new("ScreenGui", game.CoreGui); sg.Name = "EdinoePremium"
local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 180, 0, 110)
f.Position = UDim2.new(0.5, -90, 0.1, 0)
f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
f.Active = true; f.Draggable = true

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30); t.Text = "EDINOE X CHLOE-X"
t.BackgroundColor3 = Color3.fromRGB(255, 170, 0); t.TextColor3 = Color3.new(0,0,0)

local s = Instance.new("TextLabel", f)
s.Size = UDim2.new(1, 0, 0, 80); s.Position = UDim2.new(0,0,0.3,0)
s.Text = "Ready!\nTotal: 0 Ikan"; s.TextColor3 = Color3.new(1,1,1); s.BackgroundTransparency = 1

-- 3. LOGIKA DETEKSI & AUTO-REEL (Metode Remote Hook)
local RS = game:GetService("ReplicatedStorage")
local events = {"CaughtFishVisual", "FishCaught", "ReelFinished"}

for _, name in pairs(events) do
    local ev = RS:FindFirstChild(name, true)
    if ev and ev:IsA("RemoteEvent") then
        ev.OnClientEvent:Connect(function(...)
            local args = {...}
            -- Deteksi jika pancingan selesai (Milik Player)
            if tostring(args[1]) == player.Name or name == "ReelFinished" then
                local fishName = tostring(args[3] or "Ikan")
                local weight = (type(args[4]) == "table" and args[4].Weight) or "N/A"
                
                -- Update GUI
                s.Text = "Dapet: " .. fishName .. "\nTotal: " .. _G.TotalCaught + 1
                
                -- Kirim ke Discord
                task.spawn(function() SendWebhook(fishName, weight) end)
                
                -- Fitur Tambahan: Auto Reel (Tarik Otomatis)
                local finish = RS:FindFirstChild("ReelFinished", true)
                if finish then finish:FireServer(100, true) end
            end
        end)
    end
end

