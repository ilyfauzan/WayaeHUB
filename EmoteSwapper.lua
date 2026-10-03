local EmoteSwapper = {}
local rs = game:GetService("ReplicatedStorage")
local starterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

-- Inisialisasi loop pengganti nama UI secara permanen (hanya berjalan 1 kali di background)
if not _G.ActiveWayaeSwaps then
    _G.ActiveWayaeSwaps = {}
    task.spawn(function()
        local localPlayer = Players.LocalPlayer
        local playerGui = localPlayer:WaitForChild("PlayerGui")
        
        while task.wait(0.1) do
            for _, obj in ipairs(playerGui:GetDescendants()) do
                if obj:IsA("TextLabel") and obj.Text ~= "" then
                    for uiTargetStr, uiSourceStr in pairs(_G.ActiveWayaeSwaps) do
                        if string.find(obj.Text, uiTargetStr) and not string.find(obj.Text, uiSourceStr) then
                            obj.Text = string.gsub(obj.Text, uiTargetStr, uiSourceStr)
                        end
                    end
                end
            end
        end
    end)
end

-- Fungsi cerdas untuk mengekstrak Nama Asli/Display Name dari dalam properties file
local function getRealDisplayName(obj, defaultName)
    local name = defaultName
    
    -- 1. Jika itu ModuleScript, coba require dan cari properties Name / ItemName
    if obj:IsA("ModuleScript") then
        pcall(function()
            local data = require(obj)
            if type(data) == "table" then
                name = data.Name or data.DisplayName or data.ItemName or data.Title or name
            end
        end)
    end
    
    -- 2. Jika bukan di dalam tabel, mungkin berupa StringValue di dalam objek
    if name == defaultName then
        local val = obj:FindFirstChild("DisplayName") or obj:FindFirstChild("Name") or obj:FindFirstChild("ItemName")
        if val and val:IsA("StringValue") then
            name = val.Value
        end
    end
    
    -- 3. Cara terakhir (Fallback): Memisahkan huruf besar dengan spasi
    if name == defaultName then
        name = string.gsub(defaultName, "(%l)(%u)", "%1 %2")
    end
    
    return name
end

function EmoteSwapper.Swap(targetName, sourceName)
    if targetName == "" or sourceName == "" then
        starterGui:SetCore("SendNotification", {Title = "ERROR", Text = "Harap isi kedua kotak!", Duration = 3})
        return
    end

    local targetObj = nil
    local sourceObj = nil

    -- Mencari Target dan Source di ReplicatedStorage
    for _, obj in ipairs(rs:GetDescendants()) do
        if not targetObj and obj.Name == targetName and obj:IsA("ModuleScript") then
            targetObj = obj
        end
        if not sourceObj and obj.Name == sourceName then
            if (obj:IsA("Folder") or obj:IsA("ModuleScript")) and (obj:FindFirstChildWhichIsA("Animation", true) or obj:FindFirstChildWhichIsA("Sound", true) or obj:FindFirstChild("Animation")) then
                sourceObj = obj
            end
        end
    end

    -- Jika dua-duanya ketemu, lakukan Pembedahan & Swap
    if targetObj and sourceObj then
        for _, child in ipairs(targetObj:GetChildren()) do
            child:Destroy()
        end
        for _, child in ipairs(sourceObj:GetChildren()) do
            child:Clone().Parent = targetObj
        end

        -- Salin Sound eksplisit jika tersedia
        local sourceSound = sourceObj:FindFirstChildWhichIsA("Sound", true)
        local targetSound = targetObj:FindFirstChildWhichIsA("Sound", true)
        if sourceSound then
            if targetSound then
                targetSound.SoundId = sourceSound.SoundId
                targetSound.Volume = sourceSound.Volume
                targetSound.PlaybackSpeed = sourceSound.PlaybackSpeed
            else
                local clonedSound = sourceSound:Clone()
                clonedSound.Parent = targetObj
            end
        end

        -- Mengambil nama tampilan asli (Display Name) dari dalam properties
        local uiTargetStr = getRealDisplayName(targetObj, targetName)
        local uiSourceStr = getRealDisplayName(sourceObj, sourceName)

        -- Daftarkan nama asli tersebut ke dalam loop background agar di-rename secara permanen
        _G.ActiveWayaeSwaps[uiTargetStr] = uiSourceStr

        starterGui:SetCore("SendNotification", {
            Title = "🔥 SWAP SUKSES",
            Text = "Berhasil menukar " .. uiTargetStr .. " menjadi " .. uiSourceStr .. "!",
            Duration = 5
        })
    else
        -- Pesan Error
        if not targetObj then
            starterGui:SetCore("SendNotification", {Title = "GAGAL", Text = "Emote asal ("..targetName..") tidak ditemukan!", Duration = 5})
        elseif not sourceObj then
            starterGui:SetCore("SendNotification", {Title = "GAGAL", Text = "Emote pengganti ("..sourceName..") tidak ditemukan!", Duration = 5})
        end
    end
end

return EmoteSwapper
