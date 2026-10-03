local EmoteSwapper = {}
local rs = game:GetService("ReplicatedStorage")
local starterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

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

        -- Fungsi untuk memisahkan nama huruf besar agar nama UI berubah (Misal: SwagWalk -> Swag Walk)
        local function addSpaces(str)
            return string.gsub(str, "(%l)(%u)", "%1 %2")
        end

        local uiTargetStr = addSpaces(targetName)
        local uiSourceStr = addSpaces(sourceName)

        -- Tahap 2: Ganti Nama di UI (PlayerGui)
        task.spawn(function()
            local localPlayer = Players.LocalPlayer
            local playerGui = localPlayer:WaitForChild("PlayerGui")
            
            -- Lakukan scan selama 10 detik
            for i = 1, 100 do
                task.wait(0.1)
                for _, obj in ipairs(playerGui:GetDescendants()) do
                    if obj:IsA("TextLabel") and obj.Text ~= "" then
                        if string.find(obj.Text, uiTargetStr) and not string.find(obj.Text, uiSourceStr) then
                            obj.Text = string.gsub(obj.Text, uiTargetStr, uiSourceStr)
                        end
                    end
                end
            end
        end)

        starterGui:SetCore("SendNotification", {
            Title = "🔥 SWAP SUKSES",
            Text = "Berhasil menukar " .. targetName .. " menjadi " .. sourceName .. "!",
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
