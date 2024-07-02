
lib.addCommand('id', {
   help = 'Player server ID',
}, function(source, args, raw)
   local xPlayer = source
   local msg = 'Your ID :' .. " " .. xPlayer
   ShowNotification(source, msg, 'success')
end)
