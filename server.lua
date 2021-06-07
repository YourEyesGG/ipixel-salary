ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ipixel-salary:takes')
AddEventHandler('ipixel-salary:takes', function(source, salary)
    	xPlayer = ESX.GetPlayerFromId(source)
    	xPlayer.addMoney(salary)
   	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Walet + $' .. salary .. '.' })
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Salary - $' .. salary .. '.' })
end)
