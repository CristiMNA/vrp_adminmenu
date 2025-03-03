Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

local cvRP = module("vrp", "client/vRP")
vRP = cvRP()

local pvRP = {}

pvRP.loadScript = module
Proxy.addInterface("vRP", pvRP)

local cfg = module("vrp_adminmenu", "cfg/cfg")

local AdminMenu = class("AdminMenu", vRP.Extension)

function AdminMenu:__construct()
	vRP.Extension.__construct(self)
end

------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------INFINITE STAMINA-------------------------------------------------------------

local infiniteStamina = false

function AdminMenu:toggleStamina()
	infiniteStamina = not infiniteStamina

	if infiniteStamina then
		vRP.EXT.Base:notify("Infinite Stamina ON!")
	else
		vRP.EXT.Base:notify("Infinite Stamina OFF!")
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if infiniteStamina then
			RestorePlayerStamina(PlayerId(), 1.0)
		else
			Citizen.Wait(5000)
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------GODMODE-------------------------------------------------------------------

local godMode = false

function AdminMenu:toggleGodmode()

	godMode = not godMode
	
	if godMode then
		vRP.EXT.Base:notify("Godmode ON!")
	end
	
	if not godMode then
		vRP.EXT.Base:notify("Godmode OFF!")
	end

end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if godMode then
      local ped = PlayerPedId()
      SetEntityInvincible(ped, true)
      SetPlayerInvincible(PlayerId(), true)
      SetPedCanRagdoll(ped, false)
      ClearPedBloodDamage(ped)
      ResetPedVisibleDamage(ped)
      ClearPedLastWeaponDamage(ped)
      SetEntityProofs(ped, true, true, true, true, true, true, true, true)
      SetEntityOnlyDamagedByPlayer(ped, false)
      SetEntityCanBeDamaged(ped, false)
    else
      local ped = PlayerPedId()
      SetEntityInvincible(ped, false)
      SetPlayerInvincible(PlayerId(), false)
      SetPedCanRagdoll(ped, true)
      ClearPedLastWeaponDamage(ped)
      SetEntityProofs(ped, false, false, false, false, false, false, false, false)
      SetEntityOnlyDamagedByPlayer(ped, false)
      SetEntityCanBeDamaged(ped, true)
      Citizen.Wait(5000)
    end 
  end
end)

AdminMenu.tunnel = {}

AdminMenu.tunnel.toggleStamina = AdminMenu.toggleStamina
AdminMenu.tunnel.toggleGodmode = AdminMenu.toggleGodmode

vRP:registerExtension(AdminMenu)