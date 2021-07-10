ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("grandmaitemsorgusu")
AddEventHandler("grandmaitemsorgusu", function()
	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("grandmapill").count >= 2 then
		
		TriggerClientEvent("grandmatedavi", source)
	else
		TriggerClientEvent('notification', source, 'Üzerinde gerekli eşyalar yok', 2)
	end
end)

RegisterServerEvent("grandmaitemsilme")
AddEventHandler("grandmaitemsilme", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
    xPlayer.removeInventoryItem("grandmapill", 2)
end)