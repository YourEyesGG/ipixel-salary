ESX = nil
local totalsalary = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ipixel-salary:takes')
AddEventHandler('ipixel-salary:takes', function(source)
    if totalsalary[source] > 1 then
        xPlayera = ESX.GetPlayerFromId(source)
        xPlayera.addMoney(totalsalary[source])
        totalsalary[source] = 0
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Walet + $' .. totalsalary .. '.' })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Your salary is not enough.' })
    end
end)

RegisterNetEvent('ipixel-salary:salary')
AddEventHandler('ipixel-salary:salary', function(source)
	xPlayer = ESX.GetPlayerFromId(source)

	if totalsalary[source] <= 1500 then
		totalsalary[source] = totalsalary[source] + salary
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Salary + ' .. salary })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Your Salary is Full, Take it out in near ATM.' })
	end
end)