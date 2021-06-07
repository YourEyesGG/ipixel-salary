ESX = nil
local totalsalary = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7 * 60000)
        TriggerEvent('ipixel-salary:salary')
    end
end)

RegisterNetEvent('ipixel-salary:salary')
AddEventHandler('ipixel-salary:salary', function()
    if totalsalary <= 1500 then
		totalsalary = totalsalary + 50
		exports["mythic_notify"]:DoHudText('success', 'Salary + ' .. salary)
	else
        exports["mythic_notify"]:DoHudText('error', 'Your Salary is Full, Take it out in near ATM.')
	end
end)

RegisterNetEvent('ipixel-salary:take')
AddEventHandler('ipixel-salary:take', function()
    TriggerEvent("mythic_progbar:client:progress", {
        name = "salarytake",
        duration = 5000,
        label = "Taking Salary",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@base",
            anim = "base",
        },
        prop = {
            model = "prop_notepad_01",
        }
    }, function(status)
        if not status then
            if totalsalary => 1 then
                TriggerServerEvent('ipixel-salary:takes', source)
                totalsalary = 0
            else
                exports["mythic_notify"]:DoHudText('error', 'Your salary is not enough.')
            end
        end
    end)
end)
