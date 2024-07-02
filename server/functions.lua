ESX = exports["es_extended"]:getSharedObject()

ShowNotification = function(source, message, type)
   TriggerClientEvent('esx:showNotification', source, message, type or 'warning')
end


GetJob = function(source)
   local xPlayer = ESX.GetPlayerFromId(source)
   return xPlayer.getJob().name
end

GetGroup = function(source)
   local xPlayer = ESX.GetPlayerFromId(source)
   return xPlayer.getGroup()
end

GetPlayerJobGrade = function(source)
   local xPlayer = ESX.GetPlayerFromId(source)
   return xPlayer.job.grade
end

GetPlayerID = function(source)
   local xPlayer = ESX.GetPlayerFromId(source)
   return xPlayer
end


function RemoveMoney(src, count)
   local xPlayer = ESX.GetPlayerFromId(src)
   if xPlayer then
      xPlayer.removeMoney(count)
   end
end

function RemoveAccountMoney(src, count)
   local xPlayer = ESX.GetPlayerFromId(src)
   if xPlayer then
      xPlayer.removeAccountMoney('bank', tonumber(count))
   end
end

function GetMoney(src)
   local xPlayer = ESX.GetPlayerFromId(src)
   if xPlayer then
      return xPlayer.getMoney()
   end
   return 0
end

function GetAccountMoney(source)
   local xPlayer = ESX.GetPlayerFromId(source)

   return xPlayer.getAccount('bank').money
end

function AddItem(source, name, count, metadata)
   local xPlayer = ESX.GetPlayerFromId(source)
   xPlayer.addInventoryItem(name, count)
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

--- sql coreS

function InsertVehicleIntoGarage(PLAYER, price, veh, type)
   local _source = PLAYER
   local player = ESX.GetPlayerFromId(_source)
   local plate = GeneratePlate()


   MySQL.Sync.execute(
      'INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored,garage_type) VALUES (@owner, @plate, @vehicle, @type, @stored,@garage_type)',
      {
         ['@owner']       = player.identifier,
         ['@plate']       = plate,
         ['@vehicle']     = json.encode({ model = GetHashKey(veh), plate = plate }),
         ['@garage_type'] = type,
         ['@type']        = type,
         ['@stored']      = 1,
      })
end

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

function DiscordLog(webhook, color, title, message)
   local Embed = {
      {
         ['color'] = color,
         ['title'] = "**" .. title .. "**",
         ['description'] = message,
      }
   }
   PerformHttpRequest(webhook, function(err, text, headers) end, 'POST',
      json.encode({ username = 'X - LIFE', embeds = Embed }), { ['Content-Type'] = 'application/json' })
end

function GetPlayerLicense(source)
   local xPlayer = ESX.GetPlayerFromId(source)
   local identifier  = xPlayer.identifier
   local results = MySQL.query.await('SELECT * FROM `user_licenses` WHERE `owner` = ?', { identifier })
   
   local LICENSES = {}

   for k, data in pairs(results) do
       LICENSES[#LICENSES + 1] = {
           id = data.id,
           type = data.type,
       }
   end

   if #LICENSES > 0 then
       return LICENSES
   else
       return 'fail', 'No data saved'
   end
  
end
