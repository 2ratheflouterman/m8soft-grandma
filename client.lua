local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(PlayerPedId())
		local wait = 2000

		if GetDistanceBetweenCoords(coords, 2437.71, 4961.57, 46.8105, true) < 2.8 then
			ESX.ShowHelpNotification("Tedavi olmak için ~INPUT_PICKUP~ basın")
			wait = 1

			if IsControlJustReleased(0, Keys['E']) then
				if IsEntityPlayingAnim(PlayerPedId(), "dead", "dead_a", 1) then
					TriggerServerEvent("grandmaitemsorgusu", source)
				else
					TriggerEvent('notification', 'Tıbbi yardıma ihtiyacınız yok!', 2)
				end
			end
		end
	end
end)

RegisterNetEvent("grandmatedavi")
AddEventHandler("grandmatedavi", function()
	TriggerEvent("mythic_progbar:client:progress", {
		name = "tedavi",
		duration = 120000,
		label = "Tedavin uygulanıyor",
		useWhileDead = true,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(status)
		if not status then
			SetEntityAsMissionEntity(playerPed, true, true)
			SetEntityInvincible(playerPed, true)
			SetPedHearingRange(playerPed, 0.0)
			SetPedSeeingRange(playerPed, 0.0)
			SetPedAlertness(playerPed, 0.0)
			SetBlockingOfNonTemporaryEvents(playerPed, true)
			SetPedCombatAttributes(playerPed, 46, true)
			SetPedFleeAttributes(playerPed, 0, 0)
			ClearPedBloodDamage(playerPed)
			StopEntityFire(playerPed)
			TriggerEvent("esx_ambulancejob:revive")
			TriggerServerEvent('grandmaitemsilme', source)
		end
	end)
end)