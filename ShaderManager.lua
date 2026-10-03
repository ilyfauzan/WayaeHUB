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
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(255, 170, 100), Decay = Color3.fromRGB(255, 100, 0), Glare = 1, Haze = 10 })
        CreateEffect("Sky", { SunAngularSize = 15, MoonAngularSize = 11 })
        CreateEffect("SunRaysEffect", { Intensity = 0.5, Spread = 0.8 })
        CreateEffect("BloomEffect", { Intensity = 0.2, Size = 24, Threshold = 2.0 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 180, 80), Cover = 0.6, Density = 0.5 }, Terrain) end

    elseif shaderId == 2 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.15, Saturation = -0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(10, 20, 40), Decay = Color3.fromRGB(5, 10, 20), Glare = 0, Haze = 10 })
        CreateEffect("Sky", { StarCount = 5000, MoonAngularSize = 15, CelestialBodiesShown = true })
        CreateEffect("BloomEffect", { Intensity = 0.2, Size = 15, Threshold = 1.5 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(30, 40, 60), Cover = 0.7, Density = 0.6 }, Terrain) end
        
    elseif shaderId == 3 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(200, 100, 60), Decay = Color3.fromRGB(150, 60, 30), Glare = 0.5, Haze = 10 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.1, FocusDistance = 50, InFocusRadius = 50 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(220, 110, 70), Cover = 0.8, Density = 0.7 }, Terrain) end
        
    elseif shaderId == 4 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = 0.3, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(120, 40, 220), Decay = Color3.fromRGB(255, 50, 150), Glare = 0, Haze = 10 })
        CreateEffect("Sky", { StarCount = 3000 })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 24, Threshold = 0.8 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(200, 50, 255), Cover = 0.6, Density = 0.8 }, Terrain) end
        
    elseif shaderId == 5 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = -0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(180, 220, 255), Decay = Color3.fromRGB(150, 180, 255), Glare = 0.5, Haze = 10 })
        CreateEffect("SunRaysEffect", { Intensity = 0.3, Spread = 0.5 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 255, 255), Cover = 0.9, Density = 0.4 }, Terrain) end
        
    elseif shaderId == 6 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.1, Saturation = 0, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.45, Offset = 0.2, Color = Color3.fromRGB(80, 160, 80), Decay = Color3.fromRGB(50, 100, 50), Glare = 0, Haze = 10 })
        CreateEffect("BlurEffect", { Size = 2 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(120, 200, 100), Cover = 1, Density = 0.9 }, Terrain) end
        
    elseif shaderId == 7 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.5, Saturation = -1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.45, Offset = 0.2, Color = Color3.fromRGB(80, 80, 80), Decay = Color3.fromRGB(50, 50, 50), Glare = 0, Haze = 10 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(100, 100, 100), Cover = 0.8, Density = 0.8 }, Terrain) end
        
    elseif shaderId == 8 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.4, Offset = 0.25, Color = Color3.fromRGB(200, 10, 10), Decay = Color3.fromRGB(150, 0, 0), Glare = 1, Haze = 10 })
        CreateEffect("Sky", { SunAngularSize = 30 })
        CreateEffect("BloomEffect", { Intensity = 0.3, Size = 20, Threshold = 1.5 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 40, 40), Cover = 1, Density = 1 }, Terrain) end
        
    elseif shaderId == 9 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.15, Saturation = 0.1, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(255, 230, 180), Decay = Color3.fromRGB(200, 170, 130), Glare = 2, Haze = 10 })
        CreateEffect("SunRaysEffect", { Intensity = 0.8, Spread = 1.0 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 240, 200), Cover = 0.3, Density = 0.3 }, Terrain) end
        
    elseif shaderId == 10 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.3, Saturation = 0.2, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.4, Offset = 0.25, Color = Color3.fromRGB(0, 0, 0), Decay = Color3.fromRGB(0, 0, 0), Glare = 0, Haze = 10 })
        CreateEffect("Sky", { StarCount = 10000, SunAngularSize = 0, MoonAngularSize = 20, CelestialBodiesShown = true })
        CreateEffect("BloomEffect", { Intensity = 0.5, Size = 30, Threshold = 0.8 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(0, 0, 0), Cover = 0, Density = 0 }, Terrain) end

    elseif shaderId == 11 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.15, Saturation = 0.2, Brightness = 0.05, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.2, Offset = 0.25, Color = Color3.fromRGB(130, 200, 255), Decay = Color3.fromRGB(100, 150, 255), Glare = 0.5, Haze = 1 })
        CreateEffect("Sky", { SunAngularSize = 10 })
        CreateEffect("SunRaysEffect", { Intensity = 0.15, Spread = 0.4 })
        CreateEffect("BloomEffect", { Intensity = 0.1, Size = 15, Threshold = 1.0 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.1, NearIntensity = 0, FocusDistance = 25, InFocusRadius = 50 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 255, 255), Cover = 0.4, Density = 0.3 }, Terrain) end

    elseif shaderId == 12 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.25, Saturation = 0.1, TintColor = Color3.fromRGB(230, 240, 255) })
        CreateEffect("Atmosphere", { Density = 0.3, Offset = 0.25, Color = Color3.fromRGB(20, 60, 100), Decay = Color3.fromRGB(200, 100, 50), Glare = 0.8, Haze = 2 })
        CreateEffect("SunRaysEffect", { Intensity = 0.4, Spread = 0.8 })
        CreateEffect("BloomEffect", { Intensity = 0.3, Size = 24, Threshold = 0.8 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.15, NearIntensity = 0, FocusDistance = 25, InFocusRadius = 50 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(240, 245, 255), Cover = 0.5, Density = 0.5 }, Terrain) end

    elseif shaderId == 13 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = -0.3, Brightness = -0.05, TintColor = Color3.fromRGB(255, 255, 255) })
        CreateEffect("Atmosphere", { Density = 0.45, Offset = 0.2, Color = Color3.fromRGB(100, 110, 120), Decay = Color3.fromRGB(80, 90, 100), Glare = 0, Haze = 5 })
        CreateEffect("Sky", { SunAngularSize = 0 })
        CreateEffect("BloomEffect", { Intensity = 0.2, Size = 20, Threshold = 1.5 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.1, NearIntensity = 0, FocusDistance = 25, InFocusRadius = 50 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(120, 120, 130), Cover = 0.9, Density = 0.8 }, Terrain) end

    elseif shaderId == 14 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.2, Saturation = 0.3, TintColor = Color3.fromRGB(255, 235, 215) })
        CreateEffect("Atmosphere", { Density = 0.35, Offset = 0.25, Color = Color3.fromRGB(255, 120, 50), Decay = Color3.fromRGB(150, 50, 20), Glare = 1.5, Haze = 4 })
        CreateEffect("Sky", { SunAngularSize = 18 })
        CreateEffect("SunRaysEffect", { Intensity = 0.7, Spread = 1.0 })
        CreateEffect("BloomEffect", { Intensity = 0.4, Size = 24, Threshold = 1.2 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.15, NearIntensity = 0, FocusDistance = 25, InFocusRadius = 50 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(255, 150, 100), Cover = 0.6, Density = 0.4 }, Terrain) end

    elseif shaderId == 15 then
        CreateEffect("ColorCorrectionEffect", { Contrast = 0.3, Saturation = 0.1, TintColor = Color3.fromRGB(240, 240, 255) })
        CreateEffect("Atmosphere", { Density = 0.25, Offset = 0.3, Color = Color3.fromRGB(5, 10, 20), Decay = Color3.fromRGB(2, 5, 10), Glare = 0, Haze = 1 })
        CreateEffect("Sky", { StarCount = 8000, MoonAngularSize = 15 })
        CreateEffect("BloomEffect", { Intensity = 0.6, Size = 20, Threshold = 0.5 })
        CreateEffect("DepthOfFieldEffect", { FarIntensity = 0.1, NearIntensity = 0, FocusDistance = 25, InFocusRadius = 50 })
        if Terrain then CreateEffect("Clouds", { Color = Color3.fromRGB(40, 50, 70), Cover = 0.3, Density = 0.2 }, Terrain) end
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✨ SHADER AKTIF", Text = "Shader " .. shaderId .. " berhasil dipasang!", Duration = 3
    })
end

return ShaderManager
