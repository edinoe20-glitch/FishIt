-- [[ EDINOE HUB - ANTI SPAM FIX ]] --
local player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

if game.CoreGui:FindFirstChild("EdinoeGui") then game.CoreGui.EdinoeGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "EdinoeGui"
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 100)
Frame.Position = UDim2.new(0.5, -80, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Text = "EDINOE ANTI-SPAM"
Title.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
Title.TextColor3 = Color3.new(1, 1, 1)

local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1, 0, 0, 75)
Status.Position = UDim2.new(0, 0, 0.25, 0)
Status.Text = "Stabilizing..."
Status.TextColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1

-- SISTEM FILTER NOTIF
local function sendToDiscord(fish, weight)
    -- VALIDASI: Jangan kirim kalau namanya sampah atau default
    if fish == "Ikan Misterius" or fish == "Unknown" or weight == "0" then 
        return 
    end

    Status.Text = "🎯 DAPET: " .. fish
    Status.TextColor3 = Color3.new(0, 1, 0)
    
    if _G.Notifier then
        _G.Notifier.Send(fish, weight)
        task.wait(2)
        Status.Text = "Menunggu Ikan..."
        Status.TextColor3 = Color3.new(1, 1, 1)
    end
end

-- CARI EVENT SECARA SPESIFIK (Jangan Bruteforce semua)
local catchEvent = RS:FindFirstChild("CaughtFishVisual", true) or RS:FindFirstChild("FishCaught", true)

if catchEvent then
    Status.Text = "Ready! Mancing lah."
    catchEvent.OnClientEvent:Connect(function(targetPlayer, pos, fishName, data)
        -- Cek apakah event ini ditujukan buat kita
        local targetName = (type(targetPlayer) == "userdata" and targetPlayer.Name) or tostring(targetPlayer)
        
        if targetName == player.Name then
            local weight = "0"
            if type(data) == "table" and data.Weight then
                weight = tostring(data.Weight)
            elseif type(fishName) == "table" and fishName.Weight then
                -- Kadang posisi argumennya ketuker di game ini
                weight = tostring(fishName.Weight)
                fishName = "Fish" 
            end
            
            sendToDiscord(tostring(fishName), weight)
        end
    end)
else
    Status.Text = "❌ Event Not Found!"
    Status.TextColor3 = Color3.new(1, 0, 0)
end

