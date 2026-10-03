local ShaderManager = {}
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChild("Terrain")

local function ClearShaders()
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:GetAttribute("WayaeShader") then
            obj:Destroy()
        end
    end
    if Terrain then
        for _, obj in ipairs(Terrain:GetChildren()) do
            if obj:GetAttribute("WayaeShader") then
                obj:Destroy()
            end
        end
    end
    -- Bersihkan juga objek 3D meme di workspace
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:GetAttribute("WayaeShader") then
            obj:Destroy()
        end
    end
end

local function CreateEffect(className, properties, parent)
    local effect = Instance.new(className)
    for k, v in pairs(properties) do
        effect[k] = v
    end
    effect:SetAttribute("WayaeShader", true)
    effect.Parent = parent or Lighting
    return effect
end

function ShaderManager.Apply(shaderId)
    ClearShaders()
    
    if shaderId == 0 then
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Shader", Text = "Shader dimatikan.", Duration = 3})
        return
    end

    if shaderId == 1 then
        -- Golden Glow (Senja penuh di seluruh langit)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(255, 170, 100), Decay = Color3.fromRGB(255, 100, 0), Glare = 1, Haze = 10 })
        CreateEffect("Sky", { SunAngularSize = 15, MoonAngularSize = 11 })
        CreateEffect("SunRaysEffect", { Intensity = 0.5, Spread = 0.8 })
        CreateEffect("BloomEffect", { Intensity = 0.2, Size = 24, Threshold = 2.0 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 180, 80), Cover = 0.6, Density = 0.5 }, Terrain) end

    elseif shaderId == 2 then
        -- Midnight Velvet (Malam gelap seluruh langit biru tua)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.15, Saturation = -0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(10, 20, 40), Decay = Color3.fromRGB(5, 10, 20), Glare = 0, Haze = 10 })
        CreateEffect("Sky", { StarCount = 5000, MoonAngularSize = 15, CelestialBodiesShown = true })
        CreateEffect("BloomEffect", { Intensity = 0.2, Size = 15, Threshold = 1.5 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(30, 40, 60), Cover = 0.7, Density = 0.6 }, Terrain) end
        
    elseif shaderId == 3 then
        -- Autumn Melancholy (Jingga sampai ke atas)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(200, 100, 60), Decay = Color3.fromRGB(150, 60, 30), Glare = 0.5, Haze = 10 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.1, FocusDistance = 50, InFocusRadius = 50 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(220, 110, 70), Cover = 0.8, Density = 0.7 }, Terrain) end
        
    elseif shaderId == 4 then
        -- Cyber Neon (Langit ungu/pink penuh)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = 0.3, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(120, 40, 220), Decay = Color3.fromRGB(255, 50, 150), Glare = 0, Haze = 10 })
        CreateEffect("Sky", { StarCount = 3000 })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 24, Threshold = 0.8 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(200, 50, 255), Cover = 0.6, Density = 0.8 }, Terrain) end
        
    elseif shaderId == 5 then
        -- Winter Chill (Dingin putih/biru muda di semua awan)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = -0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(180, 220, 255), Decay = Color3.fromRGB(150, 180, 255), Glare = 0.5, Haze = 10 })
        CreateEffect("SunRaysEffect", { Intensity = 0.3, Spread = 0.5 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 255, 255), Cover = 0.9, Density = 0.4 }, Terrain) end
        
    elseif shaderId == 6 then
        -- Toxic Wasteland (Langit hijau beracun)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.45, Offset = 0.2, Color = Color3.fromRGB(80, 160, 80), Decay = Color3.fromRGB(50, 100, 50), Glare = 0, Haze = 10 })
        CreateEffect("BlurEffect", { Size = 2 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(120, 200, 100), Cover = 1, Density = 0.9 }, Terrain) end
        
    elseif shaderId == 7 then
        -- Noir Film (Kelabu total)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.5, Saturation = -1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.45, Offset = 0.2, Color = Color3.fromRGB(80, 80, 80), Decay = Color3.fromRGB(50, 50, 50), Glare = 0, Haze = 10 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(100, 100, 100), Cover = 0.8, Density = 0.8 }, Terrain) end
        
    elseif shaderId == 8 then
        -- Hellfire (Langit kiamat, SANGAT MERAH sampai atas, awan merah)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.4, Offset = 0.25, Color = Color3.fromRGB(200, 10, 10), Decay = Color3.fromRGB(150, 0, 0), Glare = 1, Haze = 10 })
        CreateEffect("Sky", { SunAngularSize = 30 })
        CreateEffect("BloomEffect", { Intensity = 0.3, Size = 20, Threshold = 1.5 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 40, 40), Cover = 1, Density = 1 }, Terrain) end
        
    elseif shaderId == 9 then
        -- Desert Mirage (Cerah terik, awan putih kekuningan)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.15, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(255, 230, 180), Decay = Color3.fromRGB(200, 170, 130), Glare = 2, Haze = 10 })
        CreateEffect("SunRaysEffect", { Intensity = 0.8, Spread = 1.0 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 240, 200), Cover = 0.3, Density = 0.3 }, Terrain) end
        
    elseif shaderId == 10 then
        -- Void Galaxy (Gelap gulita di seluruh langit, awan hilang)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.3, Saturation = 0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.4, Offset = 0.25, Color = Color3.fromRGB(0, 0, 0), Decay = Color3.fromRGB(0, 0, 0), Glare = 0, Haze = 10 })
        CreateEffect("Sky", { StarCount = 10000, SunAngularSize = 0, MoonAngularSize = 20, CelestialBodiesShown = true })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 30, Threshold = 0.8 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(0, 0, 0), Cover = 0, Density = 0 }, Terrain) end
        
    elseif shaderId == 11 then
        -- Meme Pecel Ayam (Efek Deep Fried + Spawner Spanduk Pecel Ayam)
        -- 1. Efek "Deep Fried" Meme: Kontras tinggi, kuning over-saturated
        CreateEffect("ColorCorrectionEffect", { Contrast = 1.5, Saturation = 2.0, TintColor = Color3.fromRGB(255, 180, 50) })
        CreateEffect("BloomEffect", { Intensity = 1.5, Size = 50, Threshold = 0.5 })
        
        -- 2. Memunculkan papan raksasa Pecel Ayam di depan player
        local player = game:GetService("Players").LocalPlayer
        if player and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local banner = Instance.new("Part")
                banner.Size = Vector3.new(30, 15, 1) -- Ukuran spanduk raksasa
                -- Posisikan di depan atas player
                banner.CFrame = CFrame.new(hrp.Position + hrp.CFrame.LookVector * 40 + Vector3.new(0, 25, 0), hrp.Position)
                banner.Anchored = true
                banner.CanCollide = false
                banner:SetAttribute("WayaeShader", true)
                banner.Parent = workspace
                
                -- GANTI ID INI DENGAN ID GAMBAR PECEL AYAM DARI ROBLOX LIBRARY
                local pecelAyamAssetId = "rbxassetid://13113422872" 
                
                local decalFront = Instance.new("Decal")
                decalFront.Texture = pecelAyamAssetId
                decalFront.Face = Enum.NormalId.Front
                decalFront.Parent = banner
                
                local decalBack = Instance.new("Decal")
                decalBack.Texture = pecelAyamAssetId
                decalBack.Face = Enum.NormalId.Back
                decalBack.Parent = banner
            end
        end
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✨ SHADER AKTIF", Text = "Shader " .. shaderId .. " berhasil dipasang!", Duration = 3
    })
end

return ShaderManager
