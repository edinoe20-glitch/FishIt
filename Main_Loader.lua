-- [[ EDINOE GLITCH - UNIVERSAL LOADER ]] --
local placeId = game.PlaceId
local baseUrl = "https://raw.githubusercontent.com/edinoe20-glitch/FishIt/main/"

-- Daftar Game (ID Game = Nama File di Folder Games)
local gameFiles = {
    [121864768012064] = "Fish_It.lua" 
}

-- Fungsi untuk mengambil script
local function getScript(path)
    local success, content = pcall(function()
        return game:HttpGet(baseUrl .. path)
    end)
    if success and content ~= "" then
        return content
    end
    return nil
end

-- 1. Load Module Notifikasi Terlebih Dahulu
local notifierCode = getScript("Modules/Discord_Notifier.lua")
if notifierCode then
    _G.Notifier = loadstring(notifierCode)()
    print("✅ Module Notifier Ready!")
end

-- 2. Load Script Game Berdasarkan PlaceId
local fileName = gameFiles[placeId]
if fileName then
    local gameCode = getScript("Games/" .. fileName)
    if gameCode then
        print("🚀 Loading Script for: " .. fileName)
        loadstring(gameCode)()
    else
        warn("❌ Gagal mendownload script game.")
    end
else
    warn("🚫 Game tidak terdaftar di database lo.")
end
