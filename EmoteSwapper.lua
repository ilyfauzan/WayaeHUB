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
                    for uiTgt, uiSrc in pairs(_G.ActiveWayaeSwaps) do
                        -- Menggunakan perbandingan EXACT (==) agar tidak terjadi bug tumpang tindih
                        -- Contoh: "Rockin Stride" tidak akan tertiban oleh "Stride"
                        if obj.Text == uiTgt then
                            obj.Text = uiSrc
                        end
                    end
                end
            end
        end
    end)
end

function EmoteSwapper.Swap(targetName, uiTarget, sourceName, uiSource)
    if targetName == "" or sourceName == "" then
        starterGui:SetCore("SendNotification", {Title = "ERROR", Text = "Harap isi Variabel Target & Source!", Duration = 3})
        return
    end

    -- Jika input UI Display Name dikosongkan, gunakan nama variabelnya
    if uiTarget == "" then uiTarget = targetName end
    if uiSource == "" then uiSource = sourceName end

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

        -- Daftarkan nama asli tersebut ke dalam loop background agar di-rename secara permanen
        _G.ActiveWayaeSwaps[uiTarget] = uiSource

        starterGui:SetCore("SendNotification", {
            Title = "🔥 SWAP SUKSES",
            Text = "Berhasil menukar " .. uiTarget .. " menjadi " .. uiSource .. "!",
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
