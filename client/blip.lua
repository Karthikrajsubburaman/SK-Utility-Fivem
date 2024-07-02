local blips = {
    -- {title="", colour=, id=, x=, y=, z=}


    {title="Kuku Restaurants", colour=25, id=210, x = 257.4744, y = -759.9075, z = 30.8241},
    {title="Vasantha Maligai & Co", colour=30, id=374, x = -705.4155, y =269.1542, z = 83.1473},  
    {title="MTz Dealership ", colour=4, id=326, x = -2232.9216, y =-386.2752, z = 13.5472},
    {title="BR Dealership ", colour=5, id=326, x = -556.1555, y = -607.9045, z = 34.8003},
    {title="Soul Customs ", colour=15, id=446, x = 2725.5813, y = 3485.5552, z = 55.7118},   
    {title="Xtreme Customs ", colour=5, id=446, x = 91.2959, y = 6525.4775, z = 31.6200},
    {title="Mafia Logistics", colour=5, id=524, x = 1219.8800, y = -3267.3657, z = 5.5035}, 
    {title="Division X", colour=8, id=438, x =  -66.4440, y = -802.1555, z =44.2273},    
    {title="Boosting Store", colour=5, id=52, x =  1130.3275, y = -774.5281, z =57.6455},
 }

 --[[Info- To disable a blip add "--" before the blip line
 To add a blip just copy and paste a line and change the info and location if needed

 DO NO REPOST, DESTROY OR CLAIM MY SCRIPTS
 
 Made By TheYoungDevelopper]]
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)