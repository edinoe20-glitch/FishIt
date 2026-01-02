-- [[ EDINOE HUB - STABLE VERSION ]] --
local player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- Bersihkan GUI lama
if game.CoreGui:FindFirstChild("EdinoeGui") then game.CoreGui.EdinoeGui:Destroy() end

-- 1. BIKIN UI INDIKATOR
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "EdinoeGui"
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 100)
Frame.Position = UDim2.new(0.5, -80, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Text = "EDINOE STABLE"
Title.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Title.TextColor3 = Color3.new(1, 1, 1)

local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1, 0, 0, 75)
Status.Position = UDim2.new(0, 0, 0.25, 0)
Status.Text = "Mencari Event..."
Status.TextColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1

-- 2. FUNGSI KIRIM NOTIF
local function sendToDiscord(fish, weight)
    if not fish or fish == "" or fish:find("Animation") then return end
    
    Status.Text = "🎯 DAPET: " .. fish
    Status.TextColor3 = Color3.new(0, 1, 0)
    
    if _G.Notifier then
        _G.Notifier.Send(fish, weight or "0")
        task.wait(2)
        Status.Text = "Menunggu Ikan..."
        Status.TextColor3 = Color3.new(1, 1, 1)
    end
end

-- 3. NYARI REMOTE EVENT (Sangat Spesifik)
-- Kita langsung tembak ke folder Events, jangan cari di folder Animations!
local possibleEvents = {
    RS:FindFirstChild("CaughtFishVisual", true),
    RS:FindFirstChild("FishCaught", true)
}

for _, ev in pairs(possibleEvents) do
    if ev and ev:IsA("RemoteEvent") then -- VALIDASI: Harus RemoteEvent
        ev.OnClientEvent:Connect(function(...)
            local args = {...}
            -- Pastikan argumen pertama adalah player kita
            if tostring(args[1]) == player.Name then
                local name = tostring(args[3] or "Ikan")
                local weight = "0"
                if type(args[4]) == "table" then 
                    weight = tostring(args[4].Weight or "0") 
                end
                sendToDiscord(name, weight)
            end
        end)
        Status.Text = "Ready! Siap Mancing"
    end
end

