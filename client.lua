ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7 * 60000)
        TriggerServerEvent('ipixel-salary:salary', source)
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
            TriggerServerEvent('ipixel-salary:takes', source)
        end
    end)
end)