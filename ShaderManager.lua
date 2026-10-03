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
        -- Golden Glow (Realistis, sedikit hangat, bloom elegan, DepthOfField)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.1, Contrast = 0.3, Saturation = 0.5, TintColor = Color3.fromRGB(255, 220, 150) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.8, Size = 30, Threshold = 0.8 })
        CreateEffect("SunRaysEffect", { Intensity = 0.6, Spread = 0.7 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.2, FocusDistance = 40, InFocusRadius = 40 })

    elseif shaderId == 2 then
        -- Midnight Velvet (Dingin elegan, biru malam)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.1, Contrast = 0.4, Saturation = -0.2, TintColor = Color3.fromRGB(150, 170, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 20, Threshold = 1.0 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.4, FocusDistance = 20, InFocusRadius = 20 })
        
    elseif shaderId == 3 then
        -- Autumn Melancholy (Sinematik, jingga kemerahan, fokus DOF kuat)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.05, Contrast = 0.3, Saturation = 0.4, TintColor = Color3.fromRGB(255, 180, 120) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.4, Size = 20, Threshold = 1.5 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.3, FocusDistance = 25, InFocusRadius = 15 })
        
    elseif shaderId == 4 then
        -- Cyber Neon (Sangat mencolok, neon menyala)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.05, Contrast = 0.5, Saturation = 1.2, TintColor = Color3.fromRGB(255, 200, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 1.5, Size = 40, Threshold = 0.5 })
        CreateEffect("SunRaysEffect", { Intensity = 0.3, Spread = 0.6 })
        
    elseif shaderId == 5 then
        -- Winter Chill (Tajam, jernih, biru es)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.1, Contrast = 0.4, Saturation = -0.4, TintColor = Color3.fromRGB(180, 230, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.6, Size = 15, Threshold = 1.0 })
        CreateEffect("BlurEffect", { Size = 1 })
        
    elseif shaderId == 6 then
        -- Toxic Wasteland (Kotor, hijau menyala)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.1, Contrast = 0.6, Saturation = 0.3, TintColor = Color3.fromRGB(160, 255, 140) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.7, Size = 25, Threshold = 0.8 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.5, FocusDistance = 15, InFocusRadius = 20 })
        
    elseif shaderId == 7 then
        -- Black & White (Hitam Putih Klasik dengan kontras tinggi)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0, Contrast = 0.7, Saturation = -1, TintColor = Color3.fromRGB(255, 255, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 20, Threshold = 0.9 })
        CreateEffect("BlurEffect", { Size = 2 })
        
    elseif shaderId == 8 then
        -- Hellfire (Kontras ekstrim, merah menyala)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.15, Contrast = 0.7, Saturation = 0.8, TintColor = Color3.fromRGB(255, 100, 80) 
        })
        CreateEffect("BloomEffect", { Intensity = 1.2, Size = 35, Threshold = 0.6 })
        CreateEffect("SunRaysEffect", { Intensity = 0.8, Spread = 1.0 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.3, FocusDistance = 20, InFocusRadius = 30 })
        
    elseif shaderId == 9 then
        -- Desert Mirage (Nuansa panas terik dengan efek blur ekstrim)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.15, Contrast = 0.4, Saturation = 0.6, TintColor = Color3.fromRGB(255, 210, 140) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.6, Size = 20, Threshold = 0.9 })
        CreateEffect("SunRaysEffect", { Intensity = 0.7, Spread = 0.9 })
        CreateEffect("BlurEffect", { Size = 3 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.6, FocusDistance = 10, InFocusRadius = 10 })
        
    elseif shaderId == 10 then
        -- Void Galaxy (Gelap pekat, objek bercahaya menyala ungu/biru terang)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.25, Contrast = 0.8, Saturation = 0.5, TintColor = Color3.fromRGB(180, 100, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 2.0, Size = 50, Threshold = 0.4 })
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✨ SHADER AKTIF", Text = "Shader " .. shaderId .. " berhasil dipasang!", Duration = 3
    })
end

return ShaderManager
