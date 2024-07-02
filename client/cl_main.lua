ESX = exports["es_extended"]:getSharedObject()




for _, vehicle in ipairs(Config.vehicles) do
   local name = vehicle.name
   local type = vehicle.type
   exports(name, function(data, slot)
      lib.progressBar({
         duration = 5000,
         -- label = "Using Name Change card",
         useWhileDead = false,
         canCancel = true,
         disable = {
            car = false,
         },
      })

      TriggerServerEvent('esx:sk:register_vehicle_name', name, type)
   end)
end

-- GeneratePlate
exports("GeneratePlate", function()
   local p = promise.new()
   ESX.TriggerServerCallback('sk:GeneratePlate', function(plate)
      p:resolve(plate)
   end)
   local plate = Citizen.Await(p)
   return plate
end)


RegisterNetEvent('esx:sk:notification:carscript')
AddEventHandler('esx:sk:notification:carscript', function(source)
   lib.notify({
      description = Config.claimedMessage,
      type = Config.type,
      postion = 'top'
   })
end)


--oneshot

CreateThread(function()
   while true do
       if GetPedStealthMovement(PlayerPedId()) then
           SetPedStealthMovement(PlayerPedId(), 0)
       end
       wait(1)
   end
   end)
