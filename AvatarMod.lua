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
                rul.Transparency = 1
                rll.Transparency = 1
                rf.Transparency = 1
                
                for _, v in pairs({rul, rll, rf}) do
                    for _, obj in pairs(v:GetChildren()) do
                        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("WrapTarget") then
                            if obj:IsA("WrapTarget") then obj:Destroy() else obj.Transparency = 1 end
                        end
                    end
                end

                for _, acc in pairs(char:GetChildren()) do
                    if acc:IsA("Accessory") and acc:FindFirstChild("Handle") then
                        local att = acc.Handle:FindFirstChildWhichIsA("Attachment")
                        if att and (string.find(att.Name, "RightFoot") or string.find(att.Name, "RightLowerLeg") or string.find(att.Name, "RightUpperLeg")) then
                            acc:Destroy()
                        end
                    end
                end

                if char:FindFirstChild("FakeKorbloxLeg") then char.FakeKorbloxLeg:Destroy() end
                
                local fakeLeg = Instance.new("Part")
                fakeLeg.Name = "FakeKorbloxLeg"
                fakeLeg.Size = Vector3.new(1, 1, 1)
                fakeLeg.CanCollide = false
                fakeLeg.Massless = true
                fakeLeg.Transparency = 0
                
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshType = Enum.MeshType.FileMesh
                mesh.MeshId = "rbxassetid://902942093"
                mesh.TextureId = "rbxassetid://902843398"
                mesh.Scale = Vector3.new(1, 1, 1)
                mesh.Parent = fakeLeg
                
                local weld = Instance.new("Weld")
                weld.Part0 = rul
                weld.Part1 = fakeLeg
                weld.C0 = CFrame.new(0, -0.2, 0)
                weld.Parent = fakeLeg
                
                fakeLeg.Parent = char
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
