
--one shot remove
CreateThread(function()
    while true do
        if GetPedStealthMovement(PlayerPedId()) then
            SetPedStealthMovement(PlayerPedId(), 0)
        end
        Wait(0)
    end
    end)
    lib.registerContext({
        id = 'SK_rockstar',
        title = 'RockStar Editor',
        options = {
          {
            title = 'Record',
            description = 'Record Cinematic',
            icon = 'hand',
            event = 'SK_rockstar:record',
            onSelect = function ()
            StartRecording(1) 
            end,
            disabled = false
          },
          {
            title = 'Save Clip',
            description = 'Save Clip',
            icon = 'hand',
            onSelect = function ()
              StartRecording(0) 
              StopRecordingAndSaveClip()
              end,
            disabled = false
          },
          {
            title = 'Enter Editor',
            description = 'Record Cinematic',
            icon = 'hand',
            onSelect = function ()
              NetworkSessionLeaveSinglePlayer() 
              ActivateRockstarEditor() 
            end,
            disabled = false
          },
          {
            title = 'Delete Clip',
            description = 'Delete Clip',
            icon = 'hand',
            onSelect = function ()
              StopRecordingAndDiscardClip() 
            end,
            disabled = false
          }
        }
      })
    
    RegisterCommand('rockstar', function()
       lib.showContext('SK_rockstar')
       SK_Notify({des = 'Toggled Eidtor', status ='success'})
       ESX.ShowNotification('Toggled Eidtor', 'success', 5000)
    end) 