ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ipixel-salary:takes')
AddEventHandler('ipixel-salary:takes', function(source, salary, ehm)
	if ehm == 1 then
    		xPlayer = ESX.GetPlayerFromId(source)
    		xPlayer.addMoney(salary)
   		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Walet + $' .. salary .. '.' })
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Salary - $' .. salary .. '.' })
	else
		TriggerClientEvent('ipixel-drugs:AntiExploit', source, 'You`re attempt to Exploit iPixel Salary System')
		webhok(source)
	end
end)

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
