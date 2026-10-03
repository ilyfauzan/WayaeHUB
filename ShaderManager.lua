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
            Contrast = 0.1, Saturation = 0.2, TintColor = Color3.fromRGB(255, 248, 240) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.2, Size = 24, Threshold = 2.0 })
        CreateEffect("SunRaysEffect", { Intensity = 0.15, Spread = 0.5 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.1, FocusDistance = 50, InFocusRadius = 50 })

    elseif shaderId == 2 then
        -- Midnight Velvet (Dingin elegan, tidak sekedar biru pekat)
        CreateEffect("ColorCorrectionEffect", { 
            Contrast = 0.2, Saturation = -0.1, TintColor = Color3.fromRGB(240, 245, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.15, Size = 15, Threshold = 1.5 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.15, FocusDistance = 25, InFocusRadius = 30 })
        
    elseif shaderId == 3 then
        -- Autumn Melancholy (Sinematik, agak redup, fokus DOF kuat)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.05, Contrast = 0.15, Saturation = -0.3, TintColor = Color3.fromRGB(255, 250, 240) 
        })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.2, FocusDistance = 20, InFocusRadius = 20 })
        
    elseif shaderId == 4 then
        -- Cyber Neon (Mencolok tapi tidak merusak mata)
        CreateEffect("ColorCorrectionEffect", { 
            Contrast = 0.2, Saturation = 0.6, TintColor = Color3.fromRGB(250, 245, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.35, Size = 35, Threshold = 1.0 })
        
    elseif shaderId == 5 then
        -- Winter Chill (Tajam, jernih, kontras tinggi)
        CreateEffect("ColorCorrectionEffect", { 
            Contrast = 0.3, Saturation = -0.1, TintColor = Color3.fromRGB(245, 250, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.1, Size = 10 })
        
    elseif shaderId == 6 then
        -- Toxic Wasteland (Nuansa kotor/gritty, hijau sangat tipis)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.05, Contrast = 0.25, Saturation = -0.2, TintColor = Color3.fromRGB(245, 255, 240) 
        })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.15, FocusDistance = 30, InFocusRadius = 40 })
        
    elseif shaderId == 7 then
        -- Black & White (Film Hitam Putih Klasik)
        CreateEffect("ColorCorrectionEffect", { 
            Contrast = 0.4, Saturation = -1, TintColor = Color3.fromRGB(255, 255, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.1, Size = 14 })
        
    elseif shaderId == 8 then
        -- Hellfire (Kontras ekstrim, merah sangat tipis agar objek tetap terlihat natural)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.1, Contrast = 0.4, Saturation = 0.3, TintColor = Color3.fromRGB(255, 240, 235) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.25, Size = 20, Threshold = 1.8 })
        
    elseif shaderId == 9 then
        -- Desert Mirage (Nuansa panas terik dengan efek blur DepthOfField ekstrim di kejauhan)
        CreateEffect("ColorCorrectionEffect", { 
            Contrast = 0.1, Saturation = 0.2, TintColor = Color3.fromRGB(255, 250, 230) 
        })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.25, FocusDistance = 15, InFocusRadius = 15 })
        CreateEffect("SunRaysEffect", { Intensity = 0.25, Spread = 0.8 })
        
    elseif shaderId == 10 then
        -- Void Galaxy (Gelap elegan, objek bercahaya/bloom akan menyala sangat terang)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.15, Contrast = 0.35, Saturation = 0.2, TintColor = Color3.fromRGB(250, 245, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 30, Threshold = 0.8 })
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✨ SHADER AKTIF", Text = "Shader " .. shaderId .. " berhasil dipasang!", Duration = 3
    })
end

return ShaderManager
