RegisterNetEvent('sk:onRepair')
AddEventHandler('sk:onRepair', function()
   local playerPed = PlayerPedId()
   local coords    = GetEntityCoords(playerPed)
   local playerId  = GetPlayerServerId(PlayerId())

   local vehicle

   if IsPedInAnyVehicle(playerPed, false) then
      return ShowNotification('You Can\'t Repair While In A Vehicle', 'error')
   else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
   end


   if DoesEntityExist(vehicle) then
      

      SetVehicleDoorOpen(vehicle, 4, false, false)
      if lib.progressBar({
             duration = 10000,
             label = 'Repairing...',
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
         SetVehicleFixed(vehicle)
         SetVehicleDeformationFixed(vehicle)
         SetVehicleDoorShut(vehicle, 4, false, true)
         SetVehicleEngineHealth(vehicle, 1000.0)
         SetVehiclePetrolTankHealth(vehicle, 750.0)
         SetVehicleUndriveable(vehicle, false)
         ClearPedTasksImmediately(playerPed)
         ShowNotification('Your vehicle has been successfully repaired.', 'success')
         TriggerServerEvent('sk:repairItemRemove', playerId)
      else
         SetVehicleDoorShut(vehicle, 4, false, true)
         ClearPedTasksImmediately(playerPed)
         ShowNotification('Cancelled', 'error')
      end

   end
end)
