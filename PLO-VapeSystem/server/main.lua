-- Written by Negative | @ngtive
ESX = nil

TriggerEvent(Config.SharedObject, function(obj) ESX = obj end)

CreateThread(function()
	local expectedName = "PLO-VapeSystem"
    local actualName = GetCurrentResourceName()
    if actualName ~= expectedName then
        print("^1[ERROR] Esm Script Avaz Shode ! "..actualName.." Ra Be "..expectedName.." Taghir Dahid^0")
        print("^1[SHUTTING DOWN SERVER]^0")
        StopResource(actualName)

    else
        print("^2[PLO-VapeSystem] Script Run Shod - Written by Negative | @ngtive^0")
    end
end)

if Config.UseWithItem == false then
	RegisterCommand(Config.Command.CommandName, function(source, args)
		local xPlayer = ESX.GetPlayerFromId(source)
		if Config.VapePermission == true then
			if xPlayer.group == Config.PermissionsGroup then
				if tostring(args[1]) == Config.Command.Start then
					TriggerClientEvent("PloudVapeSystem:StartVaping", source, 0)
				elseif tostring(args[1]) == Config.Command.Stop then
					TriggerClientEvent("PloudVapeSystem:StopVaping", source, 0)
				elseif tostring(args[1]) ~= nil then
					TriggerClientEvent("chatMessage", source, "^1VapeSystem : Command Eshtebah Ast. Az /vape <start/stop> Estefade Konid")
				end
			else
				TriggerClientEvent("PloudVapeSystem:Notify", source, Config.ErrorPermissionMissing)
			end
		else
			if tostring(args[1]) == Config.Command.Start then
				TriggerClientEvent("PloudVapeSystem:StartVaping", source, 0)
			elseif tostring(args[1]) == Config.Command.Stop then
				TriggerClientEvent("PloudVapeSystem:StopVaping", source, 0)
			elseif tostring(args[1]) ~= nil then
				TriggerClientEvent("PloudVapeSystem:Notify", source, "~r~VapeSystem: ~w~Az /vape start/stop Estefade Konid")
			end
		end
	end)
else 
	ESX.RegisterUsableItem(Config.ItemName, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent("PloudVapeSystem:StartVapingItem", source, 0)
		xPlayer.removeInventoryItem(Config.ItemName, 1)
		-- ExecutiveCommand("vape start")
	end)
end


RegisterServerEvent('PloudVapeSystem:StopVapingWithItem')
AddEventHandler('PloudVapeSystem:StopVapingWithItem', function(source)
	xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("PloudVapeSystem:StopVaping", source, 0)
    if xPlayer.getInventoryItem("vape").count == 0 then
        -- TriggerEvent('PloudVapeSystem:GiveVape', source)
        xPlayer.addInventoryItem(Config.ItemName, 1)
    end

end)
RegisterServerEvent("PloudVapeSystem:StartSmokeSv")
AddEventHandler("PloudVapeSystem:StartSmokeSv", function(entity)
    TriggerClientEvent("PloudVapeSystem:StartSmokeCl", -1, entity)
end)
-- Written by Negative | @ngtive