
ESX = exports["es_extended"]:getSharedObject()


ESX.RegisterUsableItem(Config.starteritem, function(source)

   local xPlayer = ESX.GetPlayerFromId(source)

  for _, item in ipairs(Config.item) do
   --print('added ', item)
   AddItem(source, item.item, item.count)
   RemoveItem(source, Config.starteritem, 1)

end
  
end)
