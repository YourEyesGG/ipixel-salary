ESX = nil
local totalsalary = 0
local salaryamount = 0
local ah = 1

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        TriggerServerEvent('ipixel-salary:getSalary', GetPlayerServerId(PlayerId()))
        Wait(200)
        if totalsalary <= 1500 then
            TriggerServerEvent('ipixel-salary:getSalaryAmount')
            Wait(200)
            totalsalary = totalsalary + salaryamount
            TriggerServerEvent('ipixel-salary:updateSalary', totalsalary)
            exports["mythic_notify"]:DoHudText('success', 'Salary + $'..salaryamount..'')
            ah = 3
        else
            exports["mythic_notify"]:DoHudText('error', 'Your salary is full, take it out on near ATM.')
            ah = 3
        end
        Citizen.Wait(420000)
    end
end)

-- Total current user salary
RegisterNetEvent('ipixel-salary:currentSalary')
AddEventHandler('ipixel-salary:currentSalary', function(amount)
    totalsalary = amount
end)

-- Salary amount
RegisterNetEvent('ipixel-salary:salaryAmount')
AddEventHandler('ipixel-salary:salaryAmount', function(amount)
    salaryamount = amount
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
            TriggerServerEvent('ipixel-salary:takes', totalsalary, ah)
            ClearPedTasks(GetPlayerPed(-1))
        end
    end)
end)

-- Check salary command
RegisterCommand("salary", function() 
    exports["mythic_notify"]:DoHudText('inform', 'Your pending salary is $' .. totalsalary ..'')
end)
