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
        -- Placeholder Shader 1 (Realism)
        CreateEffect("ColorCorrectionEffect", { Brightness = 0.05, Contrast = 0.2, Saturation = 0.5 })
        CreateEffect("BloomEffect", { Intensity = 0.4, Size = 24 })
        CreateEffect("SunRaysEffect", { Intensity = 0.05, Spread = 0.5 })
        
    elseif shaderId == 2 then
        -- Placeholder Shader 2 (Vibrant / Terang)
        CreateEffect("ColorCorrectionEffect", { Brightness = 0.1, Contrast = 0.1, Saturation = 1.2 })
        
    elseif shaderId == 3 then
        -- Placeholder Shader 3 (Dark Mode / Horor)
        CreateEffect("ColorCorrectionEffect", { Brightness = -0.2, Contrast = 0.5, Saturation = -0.6 })
        
    elseif shaderId == 4 then
        -- Placeholder Shader 4 (Cinematic Blur)
        CreateEffect("ColorCorrectionEffect", { Brightness = -0.05, Contrast = 0.4, Saturation = 0.2 })
        CreateEffect("BlurEffect", { Size = 2 })
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✨ SHADER AKTIF",
        Text = "Shader " .. shaderId .. " berhasil dipasang!",
        Duration = 3
    })
end

return ShaderManager
