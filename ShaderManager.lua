local ShaderManager = {}
local Lighting = game:GetService("Lighting")

local function ClearShaders()
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:GetAttribute("WayaeShader") then
            obj:Destroy()
        end
    end
end

local function CreateEffect(className, properties)
    local effect = Instance.new(className)
    for k, v in pairs(properties) do
        effect[k] = v
    end
    effect:SetAttribute("WayaeShader", true)
    effect.Parent = Lighting
end

function ShaderManager.Apply(shaderId)
    ClearShaders()
    
    if shaderId == 0 then
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Shader", Text = "Shader dimatikan.", Duration = 3})
        return
    end

    if shaderId == 1 then
        -- Golden Glow (Fokus pada langit senja, awan hangat)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.3, Offset = 0.25, Color = Color3.fromRGB(255, 170, 100), Decay = Color3.fromRGB(255, 100, 0), Glare = 1, Haze = 1 })
        CreateEffect("Sky", { SunAngularSize = 15, MoonAngularSize = 11 })
        CreateEffect("SunRaysEffect", { Intensity = 0.5, Spread = 0.8 })
        CreateEffect("BloomEffect", { Intensity = 0.2, Size = 24, Threshold = 2.0 })

    elseif shaderId == 2 then
        -- Midnight Velvet (Langit malam berbintang, gelap jernih)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.15, Saturation = -0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.3, Color = Color3.fromRGB(20, 30, 60), Decay = Color3.fromRGB(10, 15, 30), Glare = 0, Haze = 0 })
        CreateEffect("Sky", { StarCount = 5000, MoonAngularSize = 15, CelestialBodiesShown = true })
        CreateEffect("BloomEffect", { Intensity = 0.2, Size = 15, Threshold = 1.5 })
        
    elseif shaderId == 3 then
        -- Autumn Melancholy (Langit jingga pudar, horizon dramatis)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.4, Color = Color3.fromRGB(200, 120, 80), Decay = Color3.fromRGB(150, 70, 40), Glare = 0.5, Haze = 1.5 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.1, FocusDistance = 50, InFocusRadius = 50 })
        
    elseif shaderId == 4 then
        -- Cyber Neon (Kabut ungu/biru, menonjolkan cahaya neon)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = 0.3, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Color = Color3.fromRGB(100, 50, 200), Decay = Color3.fromRGB(255, 50, 150), Glare = 0, Haze = 1 })
        CreateEffect("Sky", { StarCount = 3000 })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 24, Threshold = 0.8 })
        
    elseif shaderId == 5 then
        -- Winter Chill (Langit pagi musim dingin yang cerah dan dingin)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = -0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.4, Color = Color3.fromRGB(200, 230, 255), Decay = Color3.fromRGB(150, 180, 255), Glare = 0.5, Haze = 2 })
        CreateEffect("SunRaysEffect", { Intensity = 0.3, Spread = 0.5 })
        
    elseif shaderId == 6 then
        -- Toxic Wasteland (Kabut hijau beracun di kejauhan)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.5, Color = Color3.fromRGB(100, 150, 100), Decay = Color3.fromRGB(50, 80, 50), Glare = 0, Haze = 3 })
        CreateEffect("BlurEffect", { Size = 2 })
        
    elseif shaderId == 7 then
        -- Noir Film (Estetika film klasik tanpa merusak warna UI, kabut tebal)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.5, Saturation = -1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.4, Color = Color3.fromRGB(100, 100, 100), Decay = Color3.fromRGB(50, 50, 50), Glare = 0, Haze = 2 })
        
    elseif shaderId == 8 then
        -- Hellfire (Langit kiamat, merah dan berhaze tinggi)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.6, Color = Color3.fromRGB(150, 30, 20), Decay = Color3.fromRGB(80, 10, 10), Glare = 1, Haze = 2 })
        CreateEffect("Sky", { SunAngularSize = 25 })
        CreateEffect("BloomEffect", { Intensity = 0.3, Size = 20, Threshold = 1.5 })
        
    elseif shaderId == 9 then
        -- Desert Mirage (Cahaya silau, horizon berdebu/panas)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.15, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.3, Color = Color3.fromRGB(255, 230, 180), Decay = Color3.fromRGB(200, 170, 130), Glare = 2, Haze = 3 })
        CreateEffect("SunRaysEffect", { Intensity = 0.8, Spread = 1.0 })
        
    elseif shaderId == 10 then
        -- Void Galaxy (Luar angkasa, jarak pandang bersih tapi gelap)
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.3, Saturation = 0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.8, Color = Color3.fromRGB(5, 5, 10), Decay = Color3.fromRGB(0, 0, 5), Glare = 0, Haze = 0 })
        CreateEffect("Sky", { StarCount = 10000, SunAngularSize = 0, MoonAngularSize = 20, CelestialBodiesShown = true })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 30, Threshold = 0.8 })
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✨ SHADER AKTIF", Text = "Shader " .. shaderId .. " berhasil dipasang!", Duration = 3
    })
end

return ShaderManager
