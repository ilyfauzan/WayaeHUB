local AvatarMod = {}
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local function applyHeadless(char)
    if char and char:FindFirstChild("Head") then
        char.Head.Transparency = 1
        if char.Head:FindFirstChild("face") then
            char.Head.face.Transparency = 1
        end
        if char.Head:FindFirstChild("FaceControls") then
            char.Head.FaceControls:Destroy()
        end
    end
end

local function applyKorblox(char)
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.RigType == Enum.HumanoidRigType.R15 then
            local rul = char:FindFirstChild("RightUpperLeg")
            local rll = char:FindFirstChild("RightLowerLeg")
            local rf = char:FindFirstChild("RightFoot")
            
            if rul and rll and rf then
                rul.MeshId = "rbxassetid://902942093"
                rll.MeshId = "rbxassetid://902942093"
                rf.MeshId = "rbxassetid://902942089"
                
                rul.TextureID = "rbxassetid://902843398"
                rll.TextureID = "rbxassetid://902843398"
                rf.TextureID = "rbxassetid://902843398"
                
                rul.Transparency = 0
                rll.Transparency = 0
                rf.Transparency = 0
            end
        end
    end
end

-- === SINGLE PLAYER === --
function AvatarMod.Headless()
    local player = Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("Head") then
        applyHeadless(char)
        StarterGui:SetCore("SendNotification", { Title = "AVATAR", Text = "Headless (Self) diaktifkan!", Duration = 3 })
    else
        StarterGui:SetCore("SendNotification", { Title = "ERROR", Text = "Karakter/Kepala tidak ditemukan!", Duration = 3 })
    end
end

function AvatarMod.Korblox()
    local player = Players.LocalPlayer
    local char = player.Character
    if char then
        applyKorblox(char)
        StarterGui:SetCore("SendNotification", { Title = "AVATAR", Text = "Korblox (Self) diaktifkan!", Duration = 3 })
    end
end

-- === ALL PLAYERS === --
local headlessAllConn = nil
local korbloxAllConn = nil

function AvatarMod.HeadlessAll()
    if headlessAllConn then
        headlessAllConn:Disconnect()
        headlessAllConn = nil
    end
    
    local function doHeadless(player)
        if player.Character then applyHeadless(player.Character) end
        player.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            applyHeadless(char)
        end)
    end

    for _, p in pairs(Players:GetPlayers()) do
        doHeadless(p)
    end

    headlessAllConn = Players.PlayerAdded:Connect(function(p)
        doHeadless(p)
    end)
    
    StarterGui:SetCore("SendNotification", { Title = "AVATAR", Text = "Headless untuk SEMUA ORANG diaktifkan!", Duration = 3 })
end

function AvatarMod.KorbloxAll()
    if korbloxAllConn then
        korbloxAllConn:Disconnect()
        korbloxAllConn = nil
    end
    
    local function doKorblox(player)
        if player.Character then applyKorblox(player.Character) end
        player.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            applyKorblox(char)
        end)
    end

    for _, p in pairs(Players:GetPlayers()) do
        doKorblox(p)
    end

    korbloxAllConn = Players.PlayerAdded:Connect(function(p)
        doKorblox(p)
    end)
    
    StarterGui:SetCore("SendNotification", { Title = "AVATAR", Text = "Korblox untuk SEMUA ORANG diaktifkan!", Duration = 3 })
end

return AvatarMod
