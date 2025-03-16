local bagEquipped, bagObj
local ox_inventory = exports.ox_inventory
local justConnect = true

AddEventHandler('ox_inventory:updateInventory', function(changes)
    if justConnect then
        Wait(4500)
        justConnect = nil
    end
    for k, v in pairs(changes) do
        if type(v) == 'table' then
            local count = ox_inventory:Search('count', 'backpack')
	        if count > 0 and (not bagEquipped or not bagObj) then
                PutOnBag()
            elseif count < 1 and bagEquipped then
                RemoveBag()
            end
        end
        if type(v) == 'boolean' then
            local count = ox_inventory:Search('count', 'backpack')
            if count < 1 and bagEquipped then
                RemoveBag()
            end
        end
    end
end)

exports('openBackpack', function(data, slot)
    if not slot?.metadata?.identifier then
        local identifier = lib.callback.await('hn_backpack:getNewIdentifier', 100, data.slot)
        ox_inventory:openInventory('stash', 'backpack_'..identifier)
    else
        TriggerServerEvent('hn_backpack:openbackpack', slot.metadata.identifier)
        ox_inventory:openInventory('stash', 'backpack_'..slot.metadata.identifier)
    end
end)
