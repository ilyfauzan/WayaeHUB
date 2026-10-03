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
        -- Golden Glow (Golden hour, hangat, pencahayaan dramatis)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.1, Contrast = 0.35, Saturation = 0.4, TintColor = Color3.fromRGB(255, 235, 180) 
        })
        CreateEffect("BloomEffect", { Intensity = 1.2, Size = 24, Threshold = 0.9 })
        CreateEffect("SunRaysEffect", { Intensity = 0.8, Spread = 1.0 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.25, FocusDistance = 30, InFocusRadius = 20 })

    elseif shaderId == 2 then
        -- Midnight Velvet (Gelap misterius, biru dalam, cahaya berpendar kuat)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.15, Contrast = 0.5, Saturation = 0.1, TintColor = Color3.fromRGB(140, 160, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 1.5, Size = 35, Threshold = 1.1 })
        CreateEffect("SunRaysEffect", { Intensity = 0.3, Spread = 0.4 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.5, FocusDistance = 25, InFocusRadius = 15 })
        
    elseif shaderId == 3 then
        -- Autumn Melancholy (Sinematik jingga kemerahan, dreamy, fokus kuat)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.05, Contrast = 0.35, Saturation = 0.6, TintColor = Color3.fromRGB(255, 170, 100) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.9, Size = 22, Threshold = 1.2 })
        CreateEffect("BlurEffect", { Size = 2 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.6, FocusDistance = 20, InFocusRadius = 15 })
        
    elseif shaderId == 4 then
        -- Cyber Neon (Mencolok, cyberpunk, kontras warna ekstrim)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.05, Contrast = 0.6, Saturation = 1.5, TintColor = Color3.fromRGB(255, 150, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 2.5, Size = 50, Threshold = 0.4 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.2, FocusDistance = 40, InFocusRadius = 30 })
        
    elseif shaderId == 5 then
        -- Winter Chill (Tajam, membeku, biru es jernih)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.15, Contrast = 0.45, Saturation = -0.5, TintColor = Color3.fromRGB(190, 240, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 0.8, Size = 15, Threshold = 1.5 })
        CreateEffect("SunRaysEffect", { Intensity = 0.5, Spread = 0.8 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.1, FocusDistance = 50, InFocusRadius = 50 })
        
    elseif shaderId == 6 then
        -- Toxic Wasteland (Kotor, hijau menyala, beracun, pandangan kabur)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.1, Contrast = 0.7, Saturation = 0.4, TintColor = Color3.fromRGB(180, 255, 120) 
        })
        CreateEffect("BloomEffect", { Intensity = 1.3, Size = 28, Threshold = 0.7 })
        CreateEffect("BlurEffect", { Size = 4 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.8, FocusDistance = 15, InFocusRadius = 10 })
        
    elseif shaderId == 7 then
        -- Noir Film (Hitam Putih dramatis, kontras ekstrim layaknya film jadul)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.05, Contrast = 0.9, Saturation = -1, TintColor = Color3.fromRGB(255, 255, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 1.0, Size = 18, Threshold = 0.8 })
        CreateEffect("BlurEffect", { Size = 2 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.4, FocusDistance = 20, InFocusRadius = 20 })
        
    elseif shaderId == 8 then
        -- Hellfire (Apokaliptik, merah menyala, gelap, panas)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.2, Contrast = 0.85, Saturation = 0.9, TintColor = Color3.fromRGB(255, 60, 40) 
        })
        CreateEffect("BloomEffect", { Intensity = 2.0, Size = 40, Threshold = 0.5 })
        CreateEffect("SunRaysEffect", { Intensity = 1.0, Spread = 1.2 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.5, FocusDistance = 25, InFocusRadius = 20 })
        
    elseif shaderId == 9 then
        -- Desert Mirage (Sangat panas terik, silau, blur efek fatamorgana ekstrim)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.25, Contrast = 0.5, Saturation = 0.7, TintColor = Color3.fromRGB(255, 220, 160) 
        })
        CreateEffect("BloomEffect", { Intensity = 1.5, Size = 30, Threshold = 0.7 })
        CreateEffect("SunRaysEffect", { Intensity = 0.9, Spread = 0.9 })
        CreateEffect("BlurEffect", { Size = 5 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.9, FocusDistance = 10, InFocusRadius = 5 })
        
    elseif shaderId == 10 then
        -- Void Galaxy (Hanya objek bercahaya yang terlihat terang benderang)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.3, Contrast = 1.0, Saturation = 0.8, TintColor = Color3.fromRGB(200, 100, 255) 
        })
        CreateEffect("BloomEffect", { Intensity = 3.0, Size = 56, Threshold = 0.2 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.3, FocusDistance = 30, InFocusRadius = 25 })
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✨ SHADER AKTIF", Text = "Shader " .. shaderId .. " berhasil dipasang!", Duration = 3
    })
end

return ShaderManager
