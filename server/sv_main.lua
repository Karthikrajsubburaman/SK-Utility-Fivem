ESX = exports["es_extended"]:getSharedObject()

-- RegisterNetEvent('esx:sk:register_vehicle_name')
-- AddEventHandler('esx:sk:register_vehicle_name', function(name, type)

   

   

  
  
-- end)



ESX.RegisterUsableItem('evovaris', function(playerId)
      
   local _source = playerId
local player = ESX.GetPlayerFromId(_source)
local plate = GeneratePlate()
MySQL.Sync.execute(
   'INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored) VALUES (@owner, @plate, @vehicle, @type, @stored)',
   {
      ['@owner']   = player.identifier,
      ['@plate']   = plate,
      ['@vehicle'] = json.encode({ model = GetHashKey('evovaris'), plate = plate }),
      ['@type']    = 'car',
      ['@stored']  = 1,
   })

player.removeInventoryItem('evovaris', 1)
TriggerClientEvent('esx:sk:notification:carscript', _source, _source)
end)

--Ty esx_vehicleshop 🤣
local Nums = {}
local Chars = {}

for i = 48, 57 do table.insert(Nums, string.char(i)) end
for i = 65, 90 do table.insert(Chars, string.char(i)) end
for i = 97, 122 do table.insert(Chars, string.char(i)) end

function IsPalteTaken(plate)
   local res = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
      ['@plate'] = plate
   })
   return res[1] ~= nil
end

function GeneratePlate()
   local generatedPlate = ""

   for _ = 1, 3 do
      generatedPlate = generatedPlate .. Chars[math.random(1, #Chars)]
   end
   generatedPlate = generatedPlate .. ' '
   for _ = 1, 3 do
      generatedPlate = generatedPlate .. Nums[math.random(1, #Nums)]
   end
   generatedPlate = string.upper(generatedPlate)

   if IsPalteTaken(generatedPlate) then
      return GeneratePlate()
   end
   return generatedPlate
end

ESX.RegisterServerCallback('sk:GeneratePlate', function(source, cb)
   cb(GeneratePlate())
end)

ESX.RegisterServerCallback('esx_vehicleshop:isPlateTaken', function(source, cb, plate)
   cb(IsPalteTaken(plate))
end)
