

ESX = exports["es_extended"]:getSharedObject()


if Config.settings.EnableCleaningKit then
   ESX.RegisterUsableItem('cleaningkit', function(playerId)
      local xPlayer = ESX.GetPlayerFromId(playerId)
      TriggerClientEvent('sk:onCleaning', xPlayer.source)
   
   end)
end


RegisterNetEvent('sk:cleaningkitRemove')
AddEventHandler('sk:cleaningkitRemove', function (playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('cleaningkit', 1)
end)
