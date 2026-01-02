-- [[ EDINOE HUB - ULTIMATE FIX ]] --
local player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- Hapus GUI lama biar gak numpuk
if game.CoreGui:FindFirstChild("EdinoeGui") then game.CoreGui.EdinoeGui:Destroy() end

-- 1. BIKIN UI YANG LEBIH JELAS
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "EdinoeGui"
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 160, 0, 100)
Frame.Position = UDim2.new(0.5, -80, 0.1, 0) -- Tengah atas biar keliatan
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Text = "EDINOE FIX v2"
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Title.TextColor3 = Color3.new(1, 1, 1)

local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1, 0, 0, 75)
Status.Position = UDim2.new(0, 0, 0.25, 0)
Status.Text = "Menunggu Ikan..."
Status.TextColor3 = Color3.new(1, 1, 1)
Status.BackgroundTransparency = 1

-- 2. SISTEM PENGINTAI OTOMATIS (BRUTEFORCE EVENT)
local function sendToDiscord(fish, weight)
    Status.Text = "Dapet: " .. fish .. "\nKirim ke Discord..."
    Status.TextColor3 = Color3.new(1, 1, 0)
    
    if _G.Notifier then
        _G.Notifier.Send(fish, weight)
        task.wait(1)
        Status.Text = "✅ Berhasil Kirim!\nMancing lagi..."
        Status.TextColor3 = Color3.new(0, 1, 0)
    else
        Status.Text = "❌ Notifier Gagal!\nCek Module!"
        Status.TextColor3 = Color3.new(1, 0, 0)
    end
end

-- Cari semua RemoteEvent yang mungkin dipake game ini
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        -- Game Fish It biasanya pake CaughtFishVisual atau FishCaught
        if v.Name:find("Caught") or v.Name:find("Fish") then
            v.OnClientEvent:Connect(function(...)
                local args = {...}
                local fishName = "Ikan Misterius"
                local weight = "0"
                
                -- Deteksi data di dalam argumen (contek skrip dewa)
                for i, arg in pairs(args) do
                    if type(arg) == "string" and #arg > 2 then fishName = arg end
                    if type(arg) == "table" and arg.Weight then weight = tostring(arg.Weight) end
                end
                
                sendToDiscord(fishName, weight)
            end)
        end
    end
end

print("🔥 Edinoe Fix v2 Loaded!")

