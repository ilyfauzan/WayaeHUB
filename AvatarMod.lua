local AvatarMod = {}
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

function AvatarMod.Headless()
    local player = Players.LocalPlayer
    local char = player.Character
    
    if char and char:FindFirstChild("Head") then
        char.Head.Transparency = 1
        if char.Head:FindFirstChild("face") then
            char.Head.face.Transparency = 1
        end
        if char.Head:FindFirstChild("FaceControls") then
            char.Head.FaceControls:Destroy()
        end
        StarterGui:SetCore("SendNotification", {
            Title = "AVATAR",
            Text = "Headless berhasil diaktifkan!",
            Duration = 3
        })
    else
        StarterGui:SetCore("SendNotification", {Title = "ERROR", Text = "Karakter/Kepala tidak ditemukan!", Duration = 3})
    end
end

function AvatarMod.Korblox()
    local player = Players.LocalPlayer
    local char = player.Character
    
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
                
                StarterGui:SetCore("SendNotification", {
                    Title = "AVATAR",
                    Text = "Korblox (Kaki Kanan) berhasil diaktifkan!",
                    Duration = 3
                })
            else
                StarterGui:SetCore("SendNotification", {Title = "ERROR", Text = "Kaki kanan R15 tidak lengkap!", Duration = 3})
            end
        else
            StarterGui:SetCore("SendNotification", {Title = "ERROR", Text = "Harus menggunakan avatar R15!", Duration = 3})
        end
    end
end

return AvatarMod
