local myName, myRealm = UnitName("player")
local myMark = {}
myMark["Waryo"] = 1
myMark["Blanco"] = 3
myMark["Cooper"] = 4
myMark["Mash"] = 2

if myName == "Mash" then
	local macroBtn = CreateFrame("Button", "MyTestButton", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate")

	macroBtn:SetScript("PreClick", function(self, button, down)
	local myTarget, myRealm = UnitName("target")
	if myTarget == nil then
		myTarget, myRealm = UnitName("mouseover")
	end

	--SetRaidTarget("target", myMark[button])
	C_ChatInfo.SendAddonMessage("SwarmLockon", string.format("%s %s", button, myTarget), "PARTY")

	end)

	SetBindingClick("F1", macroBtn:GetName(), "Mash")
	SetBindingClick("F2", macroBtn:GetName(), "Waryo")
	SetBindingClick("F3", macroBtn:GetName(), "Blanco")
	SetBindingClick("F4", macroBtn:GetName(), "Cooper")

else

	function _G.setLockonTarget(charactor, target)

		if myName == charactor then
			print(string.format("%s --> %s", charactor, target))
			local actionBtn = CreateFrame("Button", "MyActionButton", UIParent, "SecureActionButtonTemplate,ActionButtonTemplate")
			SetBindingClick("F12", actionBtn:GetName())
			actionBtn:SetAttribute("type1", "macro")
			--actionBtn:SetAttribute("macrotext1", "/s " .. target)
			actionBtn:SetAttribute("macrotext1", "/target " .. target .. "\n/cast 诱惑\n" .. "/run SetRaidTarget(\"target\", " .. myMark[charactor] .. ");")
			
		end
	end

	local f = CreateFrame("Frame")
	f:RegisterEvent("CHAT_MSG_ADDON")
	C_ChatInfo.RegisterAddonMessagePrefix("SwarmLockon")
	f:SetScript("OnEvent", function(self, event, prefix, msg, channel, sender)
		if prefix == "SwarmLockon" then
			charactor, target = string.split(" ", msg)
			--print(string.format("[%s] [%s]: %s %s", channel, sender, charactor, target))
			_G.setLockonTarget(charactor, target)
		end
	end)
end
