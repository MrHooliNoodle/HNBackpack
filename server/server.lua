local registeredStashes = {}
local ox_inventory = exports.ox_inventory

RegisterServerEvent('hn_backpack:openBackpack')
AddEventHandler('hn_backpack:openBackpack', function(identifier)
	if not registeredStashes[identifier] then
        ox_inventory:RegisterStash('backpack_'..identifier, 'Backpack', false)
        registeredStashes[identifier] = true
    end
end)

lib.callback.register('hn_backpack:getNewIdentifier', function(source, slot)
	local newId = GenerateSerial()
	ox_inventory:SetMetadata(source, slot, {identifier = newId})
	ox_inventory:RegisterStash('backpack_'..newId, 'Backpack', false)
	registeredStashes[newId] = true
	return newId
end)

CreateThread(function()
	while GetResourceState('ox_inventory') ~= 'started' do Wait(500) end
	local swapHook = ox_inventory:registerHook('swapItems', function(payload)
		local start, destination, move_type = payload.fromInventory, payload.toInventory, payload.toType
		local count_backpacks = ox_inventory:GetItem(payload.source, 'backpack', nil, true)
	
		if string.find(destination, 'backpack_') then
			TriggerClientEvent('ox_lib:notify', payload.source, {type = 'error', title = Strings.action_incomplete, description = Strings.backpack_in_backpack}) -- You can replace it for your notify script
			return false
		end
		if Config.OneBackpackInInventory then
			if (count_backpacks > 0 and move_type == 'player' and destination ~= start) then
				TriggerClientEvent('ox_lib:notify', payload.source, {type = 'error', title = Strings.action_incomplete, description = Strings.one_backpack_only}) -- You can replace it for your notify script
				return false
			end
		end
		
		return true
	end, {
		print = false,
		itemFilter = {
			backpack = true,
		},
	})
	
	local createHook
	if Config.OneBackpackInInventory then
		createHook = exports.ox_inventory:registerHook('createItem', function(payload)
			local count_backpacks = ox_inventory:GetItem(payload.inventoryId, 'backpack', nil, true)
			local playerItems = ox_inventory:GetInventoryItems(payload.inventoryId)
	
	
			if count_backpacks > 0 then
				local slot = nil
	
				for i,k in pairs(playerItems) do
					if k.name == 'backpack' then
						slot = k.slot
						break
					end
				end
	
				Citizen.CreateThread(function()
					local inventoryId = payload.inventoryId
					local dontRemove = slot
					Citizen.Wait(1000)
	
					for i,k in pairs(ox_inventory:GetInventoryItems(inventoryId)) do
						if k.name == 'backpack' and dontRemove ~= nil and k.slot ~= dontRemove then
							local success = ox_inventory:RemoveItem(inventoryId, 'backpack', 1, nil, k.slot)
							if success then
								TriggerClientEvent('ox_lib:notify', inventoryId, {type = 'error', title = Strings.action_incomplete, description = Strings.one_backpack_only}) -- You can replace it for your notify script
							end
							break
						end
					end
				end)
			end
		end, {
			print = false,
			itemFilter = {
				backpack = true
			}
		})
	end
	
	function DiscordLogs(color, name, message)
		local embed = {
			  {
				  ["color"] = color,
				  ["title"] = "**".. name .."**",
				  ["description"] = message,
			  }
		  }
		PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = embed}), { ['Content-Type'] = 'application/json' })
	  end

	AddEventHandler('onResourceStop', function()
		ox_inventory:removeHooks(swapHook)
		if Config.OneBackpackInInventory then
			ox_inventory:removeHooks(createHook)
		end
	end)
end)
