local macroBtn = CreateFrame("CheckButton", "MyTestButton", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate")

SetBindingClick("F1", macroBtn:GetName(), "Mash")
SetBindingClick("F2", macroBtn:GetName(), "Waryo")
SetBindingClick("F3", macroBtn:GetName(), "Blanco")
SetBindingClick("F4", macroBtn:GetName(), "Cooper")

macroBtn:SetScript("PreClick", function(self, button, down)
-- As we have not specified the button argument to SetBindingClick,
-- the binding will be mapped to a LeftButton click.
-- if myName ~= button then
-- SendAddonMessage("SwarmLockon", UnitGUID("target"), button )
-- string.format("%s -> %s", button, myTarget)
myTarget, myRealm = UnitName("target")
myName, myRealm = UnitName("player")

if myName == "Mash" then
	C_ChatInfo.SendAddonMessage("SwarmLockon", string.format("%s %s", button, myTarget), "PARTY")
end
end)

local actionBtn = CreateFrame("CheckButton", "MyActionButton", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate")
SetBindingClick("`", actionBtn:GetName())

function _G.setLockonTarget(charactor, myTarget)
	--print("/target " .. myTarget)
	myName, myRealm = UnitName("player")
	if myName == charactor then
		print("/target " .. myTarget)
		actionBtn:SetAttribute("type1", "macro")
		actionBtn:SetAttribute("macrotext1", "/target " .. myTarget)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_ADDON")
C_ChatInfo.RegisterAddonMessagePrefix("SwarmLockon")
f:SetScript("OnEvent", function(self, event, prefix, msg, channel, sender)
	if prefix == "SwarmLockon" then
		
		charactor, target = string.split(" ", msg)
		print(string.format("[%s] [%s]: %s %s", channel, sender, charactor, target))
		_G.setLockonTarget(charactor, target)
	end
end)
