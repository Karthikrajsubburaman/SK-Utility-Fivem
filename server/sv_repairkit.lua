ESX = exports["es_extended"]:getSharedObject()




if Config.settings.EnableRepairKit then
   ESX.RegisterUsableItem('repairkit', function(playerId)
      local xPlayer = ESX.GetPlayerFromId(playerId)
      TriggerClientEvent('sk:onRepair', xPlayer.source)
   end)
end

RegisterNetEvent('sk:repairItemRemove')
AddEventHandler('sk:repairItemRemove', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('repairkit', 1)
end)
