ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function webhok(source)
	hook = Config.Webhook
	identifiers = ExtractIdentifiers(source)
	local embeds = {
		{
			["title"]="Steam: " .. identifiers.steam .. "\nLicense: " ..identifiers.license:gsub("license:", "").. "\nDiscord: " ..identifiers.discord:gsub("discord:", "").. "\nIP: " ..identifiers.ip:gsub("ip:", "").."\nThis player trying to Exploit iPixel Salary System",
			["type"]="rich",
			["footer"]=  {
				["text"]= "YourEyes Anti Exploit",
		   },
		}
	}
	
	PerformHttpRequest(hook, function(err, text, headers) end, 'POST', json.encode({ username = "iPixel Anti Exploit",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        end
    end

    return identifiers
end

-- Take salary
RegisterNetEvent('ipixel-salary:takes')
AddEventHandler('ipixel-salary:takes', function(total, ah)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if ah == 3 then
	    if total > 0 then
		xPlayer.addMoney(total)
		-- Reset salary to 0
		MySQL.Sync.fetchAll('UPDATE users SET salary = 0 WHERE identifier = @identifier', {
		    ['@identifier'] = xPlayer.identifier
		})
		-- Refresh salary amount
		TriggerEvent('ipixel-salary:getSalary', _source)
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'Walet + $' .. total .. '' })
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'Salary - $' .. total .. '' })
	    else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You have not enough salary !' })
	    end
	else
		TriggerClientEvent('ipixel-drugs:AntiExploit', source, 'You`re attempt to Exploit iPixel Salary System')
		webhok(source)
	end
end)


-- Get user salary
RegisterNetEvent('ipixel-salary:getSalary')
AddEventHandler('ipixel-salary:getSalary', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local salary = MySQL.Sync.fetchAll('SELECT salary FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })
    TriggerClientEvent('ipixel-salary:currentSalary', _source, salary[1].salary)
end)

-- Update user salary
RegisterNetEvent('ipixel-salary:updateSalary')
AddEventHandler('ipixel-salary:updateSalary', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    MySQL.Sync.fetchAll('UPDATE users SET salary = @salary WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
        ['@salary'] = amount
    })
end)

-- Get job salary amount
RegisterNetEvent('ipixel-salary:getSalaryAmount')
AddEventHandler('ipixel-salary:getSalaryAmount', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local salaryamount = MySQL.Sync.fetchAll('SELECT salary FROM job_grades WHERE name = @jobname', {
        ['@jobname'] = xPlayer.job.grade_name
    })
    TriggerClientEvent('ipixel-salary:salaryAmount', _source, salaryamount[1].salary)
end)
