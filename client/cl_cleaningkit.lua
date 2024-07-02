RegisterNetEvent('sk:onCleaning')
AddEventHandler('sk:onCleaning', function()
   local playerPed = PlayerPedId()
   local coords    = GetEntityCoords(playerPed)
   local playerId  = GetPlayerServerId(PlayerId())

   local vehicle

   if IsPedInAnyVehicle(playerPed, false) then
      return ShowNotification('You Can\'t Clean While In A Vehicle', 'error')
   else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
   end


   if DoesEntityExist(vehicle) then
      

      if lib.progressBar({
             duration = 10000,
             label = 'Cleaning...',
             useWhileDead = false,
             canCancel = true,
             anim = {
                dict = 'mini@repair',
                clip = 'fixing_a_ped'
             },
             disable = {
                move = true,
                car = true,
                combat = true,
                mouse = true,
             }
          }) then
         local id = NetworkGetNetworkIdFromEntity(vehicle)
         WashDecalsFromVehicle(vehicle, playerPed, 1.0)
         SetVehicleDirtLevel(vehicle, 0.1)
         ClearPedTasksImmediately(playerPed)
         NetworkFadeInEntity(vehicle, true, true)
         SetNetworkIdExistsOnAllMachines(id, true)
         SetVehicleHasBeenOwnedByPlayer(vehicle, true)
         SetEntityAsMissionEntity(vehicle, true, true)
         ShowNotification('Your vehicle has been successfully Cleaned', 'success')
         TriggerServerEvent('sk:cleaningkitRemove', playerId)
      else
         ClearPedTasksImmediately(playerPed)
         ShowNotification('Cancelled', 'error')
      end
   end
end)
