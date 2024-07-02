Config = {}


Config.settings = {
   debug             = false,
   EnableRepairKit   = true,
   EnableCleaningKit = true,
   EnableXLife_Admin = false
}

Config.starteritem = 'starter_pack'

Config.item = {
   [1] = {
      item = 'cheeseburger',
      count = 5
   },
   [2] = {
      item = 'lemonade',
      count = 5
   },
   [3] = {
      item = 'evovaris',
      count = 1
   },
   [4] = {
      item = 'phone',
      count = 1
   },
   [5] = {
      item = 'radio',
      count = 1
   }

}


Config.vehicles      = {
   [1] = {
      name = "evovaris",
      type = "car"
   },
}
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true


-- notification
Config.claimedMessage = 'vehicle has been successfully stored in your garage'
Config.type = 'success'
