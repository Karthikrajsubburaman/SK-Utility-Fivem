ESX = exports["es_extended"]:getSharedObject()

-- Functions
function RegisterUsableItem(...)
   ESX.RegisterUsableItem(...)
end


function AddItem(source, name, count, metadata)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(name, count)
	print('added ', name)
end

function RemoveItem(source, name, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(name, count)
end

function GetItemCount(source, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(name)
	return item and item.count or 0
end