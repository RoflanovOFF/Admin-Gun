script_name('ADMIN GUN')
script_author('Roflanov')

require 'moonloader'
require 'sampfuncs'
local hook = require 'lib.samp.events'
local imgui = require 'imgui'
local key = require 'vkeys'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local guns = {
    [1]= "������",
    [2]= "������ ��� ������",
    [3]= "����������� �������",
    [4]= "���",
    [5]= "����������� ����",
    [6]= "������",
    [7]= "���",
    [8]= "������",
    [9]= "���������",
    [10] = "������������� �����",
    [11] = "�����",
    [12] = "��������",
    [13] = "���������� ��������",
    [14] = "����� ������",
    [15] = "������",
    [16] = "�������",
    [17] = "������������ ���",
    [18] = "������� ��������",
    [22] = "�������� 9��",
    [23] = "�������� 9�� (����)",
    [24] = "�������� ������ ���",
    [25] = "������� ��������",
    [26] = "�����",
    [27] = "�������������� ��������",
    [28] = "���",
    [29] = "��5",
    [30] = "��",
    [31] = "�4",
    [32] = "TEC-9",
    [33] = "��������� �����",
    [34] = "����������� ��������",
    [35] = "���",
    [36] = "���������",
    [37] = "�������",
    [38] = "�������",
    [39] = "������",
    [40] = "���������",
    [41] = "��������",
    [42] = "������������",
    [43] = "�����������",
    [44] = "���",
    [45] = "����������",
    [46] = "�������"
}
local color1 = '0x1D54DE'
local tag = '[Admin Gun]{FFFFFF} '
local sw, sh = getScreenResolution()
local ammoWindow = imgui.ImInt(10000)

imgui.Process = false
local gunWindowState = imgui.ImBool(false)

function main()
    if not isSampLoaded() then
        return
    end
    while not isSampAvailable() do
        wait(0)
    end
    imgui.SwitchContext()
    setStyle()
    sampRegisterChatCommand('gunsa', gunWindow)
    sampRegisterChatCommand('guna', gunCmd)
    while true do
        wait(0)
    	if not gunWindowState.v then
    		imgui.Process = false
    	end
    end
end

function gunWindow()
    gunWindowState.v = not gunWindowState.v
    imgui.Process = gunWindowState.v
end

function gunCmd(arg)
	if #arg > 0 then
		id, ammo = string.match(arg, '(%d+) (%d+)')
        id, ammo = tonumber(id), tonumber(ammo)
		if id <= 46 and id >= 1 then
			giveWeaponToChar(playerPed, id, ammo)
			sampAddChatMessage(tag..'������ {1D54DE}'..guns[id]..'{FFFFFF} ������� ������!', color1)
		else
		   sampAddChatMessage(tag..'�����������: /guna [1 - 46] [�������]', color1)
		end
	else
		sampAddChatMessage(tag..'�����������: /guna [id ������] [�������]', color1)
	end
end

function imgui.OnDrawFrame()
    imgui.SetNextWindowSize(imgui.ImVec2(860, 400), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.Begin('ADMIN GUN', gunWindowState, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)

    imgui.InputInt(u8"���������� ��������", ammoWindow, 100, 100)

    local gcount = 1
    for gunid, guntitle in pairs(guns) do
        if imgui.Button(u8:encode(guntitle), imgui.ImVec2(200, 100)) then
            givegun(gunid, ammoWindow.v)
        end
        if gcount % 4 ~= 0  then
            imgui.SameLine()
        end
        gcount = gcount + 1
    end
    imgui.End()
end

function givegun(gunid, ammo)
	giveWeaponToChar(playerPed, gunid, ammo)
	sampAddChatMessage(tag..'������ {1D54DE}'..guns[gunid]..'{FFFFFF} ������� ������!', color1)
	imgui.Process = false
	gunWindowState.v = false
end

function setStyle()
  	local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    style.FrameRounding = 2
    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX(width/2-calc.x/2)
    imgui.Text(text)
end