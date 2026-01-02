-- [[ EDINOE GLITCH - FISH IT MAIN SCRIPT ]] --
print("🎣 Skrip Fish It Aktif!")

local player = game.Players.LocalPlayer

-- Fungsi utama buat nangkep data ikan
local function monitorCatcher()
    -- Cari remote event di jeroan game
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name == "CaughtFishVisual" then
            print("🎯 Target Sinyal Terkunci: " .. v:GetFullName())
            
            v.OnClientEvent:Connect(function(user, pos, fishName, data)
                -- Cek apakah ini buat kita
                if tostring(user) == player.Name then
                    local weight = (type(data) == "table" and data.Weight) or "N/A"
                    
                    print("🚨 DAPET IKAN: " .. tostring(fishName))
                    
                    -- PANGGIL MODULE NOTIFIER YANG UDAH KITA LOAD DI MAIN_LOADER
                    if _G.Notifier and _G.Notifier.Send then
                        _G.Notifier.Send(fishName, weight)
                    else
                        warn("⚠️ Module Notifier belum siap!")
                    end
                end
            end)
            break
        end
    end
end

-- Jalankan pengintaian
task.spawn(monitorCatcher)

-- Kasih notif di layar HP biar tahu skrip jalan
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Edinoe Glitch",
    Text = "Fish It Script Loaded! 🚀",
    Duration = 5
})

