local EmoteSwapper = {}
local rs = game:GetService("ReplicatedStorage")
local starterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local CustomNames = {
    ["Broom"] = "Broom of Doom",
    ["BroomOfDoom"] = "Broom of Doom",
    ["RockinStride"] = "Rockin' Stride",
    ["Cyberbroom"] = "Cyberbroom",
    ["CyberBroom"] = "Cyberbroom",
    ["GhastlyGrimoire"] = "Ghastly Grimoire",
    ["GhastlyGrimiore"] = "Ghastly Grimoire",
    ["WerewolfHowl"] = "Werewolf Howl",
    ["WarewolfHowl"] = "Werewolf Howl",
    ["MysticalTree"] = "Mystical Tree",
    ["AngelicRedemption"] = "Angelic Redemption"
}

if not _G.ActiveWayaeSwaps then
    _G.ActiveWayaeSwaps = {}
    task.spawn(function()
        local localPlayer = Players.LocalPlayer
        local playerGui = localPlayer:WaitForChild("PlayerGui")
        
        while task.wait(0.1) do
            for _, obj in ipairs(playerGui:GetDescendants()) do
                if obj:IsA("TextLabel") and obj.Text ~= "" then
                    for uiTgt, uiSrc in pairs(_G.ActiveWayaeSwaps) do
                        if obj.Text == uiTgt then
                            obj.Text = uiSrc
                        end
                    end
                end
            end
        end
    end)
end

local function getRealDisplayName(rawName)
    if CustomNames[rawName] then
        return CustomNames[rawName]
    end
    return string.gsub(rawName, "(%l)(%u)", "%1 %2")
end

function EmoteSwapper.Swap(targetName, sourceName)
    if targetName == "" or sourceName == "" then
        starterGui:SetCore("SendNotification", {Title = "ERROR", Text = "Harap isi Variabel Target & Source!", Duration = 3})
        return
    end

    local uiTarget = getRealDisplayName(targetName)
    local uiSource = getRealDisplayName(sourceName)

    local targetObj = nil
    local sourceObj = nil

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

    if targetObj and sourceObj then
        for _, child in ipairs(targetObj:GetChildren()) do
            child:Destroy()
        end
        for _, child in ipairs(sourceObj:GetChildren()) do
            child:Clone().Parent = targetObj
        end

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

        _G.ActiveWayaeSwaps[uiTarget] = uiSource

        starterGui:SetCore("SendNotification", {
            Title = "🔥 SWAP SUKSES",
            Text = "Berhasil menukar " .. uiTarget .. " menjadi " .. uiSource .. "!",
            Duration = 5
        })
    else
        if not targetObj then
            starterGui:SetCore("SendNotification", {Title = "GAGAL", Text = "Emote asal ("..targetName..") tidak ditemukan!", Duration = 5})
        elseif not sourceObj then
            starterGui:SetCore("SendNotification", {Title = "GAGAL", Text = "Emote pengganti ("..sourceName..") tidak ditemukan!", Duration = 5})
        end
    end
end

return EmoteSwapper
