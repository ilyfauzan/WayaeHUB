local ShaderManager = {}
local Lighting = game:GetService("Lighting")

-- Fungsi untuk menghapus semua efek shader buatan WayaeHUB sebelumnya agar tidak bertumpuk
local function ClearShaders()
    for _, obj in ipairs(Lighting:GetChildren()) do
        -- Kita menghapus efek yang ditandai dengan attribute "WayaeShader"
        if obj:GetAttribute("WayaeShader") then
            obj:Destroy()
        end
    end
end

-- Fungsi pembantu untuk membuat efek dengan cepat dan menandainya
local function CreateEffect(className, properties)
    local effect = Instance.new(className)
    for k, v in pairs(properties) do
        effect[k] = v
    end
    effect:SetAttribute("WayaeShader", true) -- Ini kuncinya agar nanti gampang dihapus
    effect.Parent = Lighting
end

function ShaderManager.Apply(shaderId)
    ClearShaders() -- Selalu bersihkan efek lama sebelum pasang yang baru
    
    if shaderId == 0 then
        -- Hanya mematikan shader (Clear)
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Shader", Text = "Shader dimatikan.", Duration = 3})
        return
    end

    if shaderId == 1 then
        -- Golden Glow (Terinspirasi dari Minecraft Shader saat Sunset)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.05, 
            Contrast = 0.15, 
            Saturation = 0.4,
            TintColor = Color3.fromRGB(255, 225, 205) -- Warna senja (Golden-Pinkish)
        })
        CreateEffect("BloomEffect", { 
            Intensity = 0.6, 
            Size = 35, 
            Threshold = 1.2 
        })
        CreateEffect("SunRaysEffect", { 
            Intensity = 0.15, 
            Spread = 0.7 
        })
        
    elseif shaderId == 2 then
        -- Midnight Velvet (Suasana Malam Biru Elegan & Dingin)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.15, 
            Contrast = 0.35, 
            Saturation = 0.1,
            TintColor = Color3.fromRGB(160, 180, 255)
        })
        CreateEffect("BloomEffect", { 
            Intensity = 0.7, 
            Size = 24, 
            Threshold = 1.0 
        })
        
    elseif shaderId == 3 then
        -- Autumn Melancholy (Sinematik Pudar / Drama Movie)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = -0.05, 
            Contrast = 0.45, 
            Saturation = -0.5,
            TintColor = Color3.fromRGB(240, 220, 200)
        })
        CreateEffect("BlurEffect", { 
            Size = 2.5
        })
        
    elseif shaderId == 4 then
        -- Cyber Neon (Super Vibrant, Glow Kuat, Estetika Neon/Magenta)
        CreateEffect("ColorCorrectionEffect", { 
            Brightness = 0.05, 
            Contrast = 0.25, 
            Saturation = 1.3,
            TintColor = Color3.fromRGB(255, 240, 255)
        })
        CreateEffect("BloomEffect", { 
            Intensity = 1.2, 
            Size = 45,
            Threshold = 1.5 
        })
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✨ SHADER AKTIF",
        Text = "Shader " .. shaderId .. " berhasil dipasang!",
        Duration = 3
    })
end

return ShaderManager
