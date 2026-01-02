-- [[ EDINOE HUB - FINAL STABLE FIX ]] --
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
Title.Text = "EDINOE FIXED"
Title.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
Title.TextColor3 = Color3.new(1, 1, 1)

local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1, 0, 0, 75)
Status.Position = UDim2.new(0, 0, 0.25, 0)
Status.Text = "Mencari Sinyal..."
Status.TextColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1

-- Fungsi Kirim Notif (Hanya kalau data Valid)
local function sendToDiscord(fish, weight)
    if not fish or fish == "" or fish == "Ikan Misterius" then return end
    
    Status.Text = "🎯 DAPET: " .. fish
    if _G.Notifier then
        _G.Notifier.Send(fish, weight or "0")
        task.wait(2)
        Status.Text = "Menunggu Ikan..."
    end
end

-- CARI REMOTE EVENT YANG VALID (Bukan Animation!)
local function findCorrectEvent()
    for _, v in pairs(RS:GetDescendants()) do
        -- Syarat: Harus RemoteEvent DAN Namanya mengandung Fish/Caught
        if v:IsA("RemoteEvent") and (v.Name:find("Caught") or v.Name:find("Fish")) then
            v.OnClientEvent:Connect(function(...)
                local args = {...}
                -- Validasi: Pastikan argumen pertama adalah Player kita
                if tostring(args[1]) == player.Name then
                    local name = tostring(args[3] or "Ikan")
                    local weight = "0"
                    if type(args[4]) == "table" then weight = tostring(args[4].Weight or "0") end
                    
                    sendToDiscord(name, weight)
                end
            end)
        end
    end
end

findCorrectEvent()
Status.Text = "Ready! Siap Mancing"

