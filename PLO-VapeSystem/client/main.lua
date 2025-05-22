-- Written by Negative | @ngtive
local IsPlayerAbleToVape = false
local Vaping = false

TriggerEvent('chat:addSuggestion', '/' .. Config.Command.CommandName .. '', "Start vaping by using the command", "/" .. Config.Command.CommandName .. " <" .. Config.Command.Start .. "/" .. Config.Command.Stop .. ">")

RegisterNetEvent("PloudVapeSystem:StartVaping")
AddEventHandler("PloudVapeSystem:StartVaping", function(source)
	if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
		if IsPedOnFoot(PlayerPedId()) then
			if IsPlayerAbleToVape == false then
				StartVaping()
				Notify(Config.StartVape)
			else
				Notify(Config.AlreadyUsing)
			end
		else
			Notify(Config.ErrorVehicle)
		end
	else
		Notify(Config.ErrorDead)
	end
end)

RegisterNetEvent("PloudVapeSystem:StartVapingItem")
AddEventHandler("PloudVapeSystem:StartVapingItem", function(source)
	if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
		if IsPedOnFoot(PlayerPedId()) then
			if IsPlayerAbleToVape == false then
				StartVaping()
				Notify(Config.StartVape)
			else
				Notify(Config.AlreadyUsing)
			end
		else
			Notify(Config.ErrorVehicle)
		end
	else
		Notify(Config.ErrorDead)
	end
end)
 
RegisterNetEvent("PloudVapeSystem:VapeAnimFix")
AddEventHandler("PloudVapeSystem:VapeAnimFix", function(source)
	local ad = "anim@heists@humane_labs@finale@keycards"
	local anim = "ped_a_enter_loop"
	while not HasAnimDictLoaded(ad) do
		RequestAnimDict(ad)
	  	Wait(1)
	end
	TaskPlayAnim(PlayerPedId(), ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
end)

RegisterNetEvent("PloudVapeSystem:StopVaping")
AddEventHandler("PloudVapeSystem:StopVaping", function(source)
	if IsPlayerAbleToVape == true then
		PlayerIsUnableToVape()
		Vaping = false
		Notify(Config.StopVape)
	
	end
end)

RegisterNetEvent("PloudVapeSystem:StopVapingItem")
AddEventHandler("PloudVapeSystem:StopVaping", function(source)
	if IsPlayerAbleToVape == true then
		PlayerIsUnableToVape()
		Vaping = false
		Notify(Config.StopVape)
		playeridd = PlayerPedId()
		TriggerServerEvent("PloudVapeSystem:GiveVape", playeridd)
	
	end
end)

RegisterNetEvent("PloudVapeSystem:ExplosionVape")
AddEventHandler("PloudVapeSystem:ExplosionVape", function()
	if IsPlayerAbleToVape then
		local PedPos = GetEntityCoords(PlayerPedId())
		local ad = "mp_player_inteat@burger"
		local anim = "mp_player_int_eat_burger"
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			while not HasAnimDictLoaded(ad) do
			  Wait(1)
				RequestAnimDict(ad)
			end
			local VapeFailure = math.random(1,Config.FailureOdds)
			if VapeFailure == 1 then
				TaskPlayAnim(PlayerPedId(), ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
				PlaySoundFrontend(-1, Config.Sound, Config.DictionaryForTheSound, 1)
				Wait(250)
				AddExplosion(PedPos.x, PedPos.y, PedPos.z+1.00, 34, 0.00, true, false, 1.00)
				ApplyDamageToPed(PlayerPedId(), 200, false)
			else
				TaskPlayAnim(PlayerPedId(), ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
				PlaySoundFrontend(-1, Config.Sound, Config.DictionaryForTheSound, 1)
			  		Wait(950)
				TriggerServerEvent("PloudVapeSystem:StartSmokeSv", PedToNet(PlayerPedId()))
			  		Wait(Config.VapeHangTime-1000)
				TriggerEvent("PloudVapeSystem:VapeAnimFix", 0)
			end
		end
	end
end)

RegisterNetEvent("PloudVapeSystem:StartSmokeCl")
AddEventHandler("PloudVapeSystem:StartSmokeCl", function(c_ped)
	for _,bones in pairs(Config.SmokeLocationBone) do
		if DoesEntityExist(NetToPed(c_ped)) and not IsEntityDead(NetToPed(c_ped)) then
			createdSmoke = UseParticleFxAssetNextCall("core")
			createdPart = StartParticleFxLoopedOnEntityBone(Config.SmokeParticle, NetToPed(c_ped), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(NetToPed(c_ped), bones), Config.SmokeSize, 0.0, 0.0, 0.0)
			Wait(Config.VapeHangTime)
			while DoesParticleFxLoopedExist(createdSmoke) do
				StopParticleFxLooped(createdSmoke, 1)
			  Wait(0)
			end
			while DoesParticleFxLoopedExist(createdPart) do
				StopParticleFxLooped(createdPart, 1)
			  Wait(0)
			end
			while DoesParticleFxLoopedExist(Config.SmokeParticle) do
				StopParticleFxLooped(Config.SmokeParticle, 1)
			  Wait(0)
			end
			while DoesParticleFxLoopedExist("core") do
				StopParticleFxLooped("core", 1)
			  Wait(0)
			end
			Wait(Config.VapeHangTime*3)
			RemoveParticleFxFromEntity(NetToPed(c_ped))
			break
		end
	end
end)

CreateThread(function()
	while true do
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			PlayerIsEnteringVehicle()
		end
		if IsPlayerAbleToVape then
			if IsControlPressed(0, Config.TakeAHitButton) then
			  Wait(250)
				if IsControlPressed(0, Config.TakeAHitButton) then
					TriggerEvent("PloudVapeSystem:ExplosionVape", 0)
					end
				Wait(Config.VapeCoolDownTime)
				end
			if IsControlPressed(0, Config.StopVapeButton) then
				if Config.UseWithItem == false then 
					ExecuteCommand(Config.Command.CommandName..' '..Config.Command.Stop)
					Wait(1000)
				else
					print('kkoiosd')
					source  = GetPlayerServerId(PlayerId())
					TriggerServerEvent('PloudVapeSystem:StopVapingWithItem', source)
				end
			end
		end
	  Wait(1)
	end
end)

CreateThread(function()
	while true do
		if IsPlayerAbleToVape then
				local pedPos = GetEntityCoords(PlayerPedId())
				if Vaping then
						Draw3DTextOnScreen(pedPos.x, pedPos.y, pedPos.z+0.99, Config.HitVape)
						Draw3DTextOnScreen(pedPos.x, pedPos.y, pedPos.z+0.85, Config.CancelVape)
					end
			end
	  Wait(1)
		end
end)

function StartVaping()
	IsPlayerAbleToVape = true
	local ad = "anim@heists@humane_labs@finale@keycards"
	local anim = "ped_a_enter_loop"
	Vaping = true
	while not HasAnimDictLoaded(ad) do
		Wait(1)
		RequestAnimDict(ad)
	end
	TaskPlayAnim(PlayerPedId(), ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local prop_name = "ba_prop_battle_vape_01"
	VapeMod = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(VapeMod, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.08, -0.00, 0.03, -150.0, 90.0, -10.0, true, true, false, true, 1, true)
end

function PlayerIsEnteringVehicle()
	IsPlayerAbleToVape = false
	local ad = "anim@heists@humane_labs@finale@keycards"
	DeleteObject(VapeMod)
	TaskPlayAnim(PlayerPedId(), ad, "exit", 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
end

function PlayerIsUnableToVape()
	IsPlayerAbleToVape = false
	DeleteObject(VapeMod)
	ClearPedTasksImmediately(PlayerPedId())
	ClearPedSecondaryTask(PlayerPedId())
end


function Draw3DTextOnScreen(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(Config.VapeDrawTextScaleAboveHead, Config.VapeDrawTextScaleAboveHead)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 55)
	SetTextEdge(8, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent('PloudVapeSystem:Notify')
AddEventHandler('PloudVapeSystem:Notify', function(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end)
-- Written by Negative | @ngtive