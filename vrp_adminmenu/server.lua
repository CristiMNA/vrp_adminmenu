local AdminMenu = class("AdminMenu", vRP.Extension)
local lang = vRP.lang

function AdminMenu:__construct()
	vRP.Extension.__construct(self)
	
	self.cfg = module("vrp_adminmenu", "cfg/cfg")
end

local function m_heal(menu)
	local user = menu.user
	local id = parseInt(user:prompt("ID you want to heal:",""))
	local tuser = vRP.users[id] 

	if tuser then
		vRP.EXT.Survival.remote._varyHealth(tuser.source, 200)
		vRP.EXT.Base.remote._notify(user.source, ""..tuser.name.." ["..tuser.id.."] healed.")
	else
		vRP.EXT.Base.remote._notify(user.source, "This user is not connected to the server!")
	end

end

local function m_healall(menu)

	if menu.user:request("Do you want to heal all players connected?",15) then
		for _, user in pairs(vRP.users) do
			vRP.EXT.Survival.remote._varyHealth(user.source,200)
			vRP.EXT.Base.remote._notify(user.source, "All players healed.")
		end
	end

end

local function m_armour(menu)
	local user = menu.user
	local id = parseInt(user:prompt("ID you want to give armour:",""))
	local tuser = vRP.users[id] 

	if tuser then
		vRP.EXT.PlayerState.remote._setArmour(tuser.source, 100)
		vRP.EXT.Base.remote._notify(user.source, ""..tuser.name.." ["..tuser.id.."] armoured.")
	else
		vRP.EXT.Base.remote._notify(user.source, "This user is not connected to the server!")
	end

end

local function m_resetvitals(menu)
	local user = menu.user
	local id = parseInt(user:prompt("ID you want to reset vitals:",""))
	local tuser = vRP.users[id] 

	if tuser then
		tuser:setVital("water", 1)
        tuser:setVital("food", 1)
		vRP.EXT.Base.remote._notify(user.source, "Reseted vitals to "..tuser.name.." ["..tuser.id.."]")
	else
		vRP.EXT.Base.remote._notify(user.source, "This user is not connected to the server!")
	end

end

local function m_infinitestamina(menu)
	local user = menu.user
	self.remote._toggleStamina(menu.user.source)
end

local function m_godmode(menu)
	local user = menu.user
	self.remote._toggleGodmode(menu.user.source)
end

vRP.EXT.GUI:registerMenuBuilder("admin", function(menu)
	local user = menu.user

	if user:hasPermission(self.cfg.healpermission) then
		menu:addOption("➕ Heal", m_heal)
	end

	if user:hasPermission(self.cfg.healallpermission) then
		menu:addOption("➕ Heal ALL", m_healall)
	end

	if user:hasPermission(self.cfg.armourpermission) then
		menu:addOption("🎽 Armura", m_armour)
	end

	if user:hasPermission(self.cfg.resetvitalspermission) then
		menu:addOption("🍎 Reset vitals", m_resetvitals)
	end

	if user:hasPermission(self.cfg.infinitestaminapermission) then
		menu:addOption("➕ Toggle Infinite Stamina", m_infinitestamina)
	end

	if user:hasPermission(self.cfg.godmodepermission) then
		menu:addOption("➕ Toggle GodMode", m_godmode)
	end

end)


vRP:registerExtension(AdminMenu)