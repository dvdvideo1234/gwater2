---@diagnostic disable: inject-field
AddCSLuaFile()

if SERVER or not gwater2 then return end

local function draw_main_background(x, y, w, h)
	surface.SetDrawColor(0, 0, 0, 125)
	surface.DrawRect(x, y, w, h)

	surface.SetDrawColor(255, 255, 255)
	surface.DrawOutlinedRect(x, y, w, h)
end

local function draw_main_background_outline(x, y, w, h)
	surface.SetDrawColor(255, 255, 255)
	surface.DrawOutlinedRect(x, y, w, h)
end

local function define_scrollbar(sbar)
	function sbar:Paint(w, h)
	end
	function sbar.btnUp:Paint(w, h)
		draw_main_background(0, 0, w, h) draw_main_background(0, 0, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawLine(3, h-h/8-3, w/2, h-h/2-h/8)
		surface.DrawLine(w-3, h-h/8-3, w/2, h-h/2-h/8)
	end
	function sbar.btnDown:Paint(w, h)
		draw_main_background(0, 0, w, h) draw_main_background(0, 0, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawLine(3, 3+h/8, w/2, h/2+h/8)
		surface.DrawLine(w-3, 3+h/8, w/2, h/2+h/8)
	end
	function sbar.btnGrip:Paint(w, h)
		draw_main_background(0, 0, w, h)
	end
end
local function create_blocking_frame(mainFrame)
	local frame = vgui.Create("DFrame", mainFrame)
	frame:SetSize(400, 200)
	frame:Center()
	frame:SetTitle("gwater2 (" .. gwater2.VERSION .. ")")
	frame:MakePopup()
	frame:SetBackgroundBlur(true)	-- doesn't actually blur the background
	frame:SetScreenLock(true)
	--frame:ShowCloseButton(false)

	function frame:Paint(w, h)
		-- Blur background
		local rt = render.GetRenderTarget()
		render.UpdateScreenEffectTexture()
		render.BlurRenderTarget(render.GetScreenEffectTexture(), 5, 5, 1)
		render.SetRenderTarget(rt)	-- blurrendertarget doesnt restore the rt
		render.DrawScreenQuad()

		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, 0, w, h)
	
		draw_main_background_outline(0, 0, w, h)
	end
	return frame
end

return {
	create_blocking_frame = create_blocking_frame, 
	draw_main_background = draw_main_background, 
	define_scrollbar = define_scrollbar,
	draw_main_background_outline = draw_main_background_outline
}