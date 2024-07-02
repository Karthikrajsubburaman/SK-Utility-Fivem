
local GetGameplayCamRelativePitch = GetGameplayCamRelativePitch
local GetGameplayCamRelativeHeading = GetGameplayCamRelativeHeading
local Cos = Cos
local Sin = Sin
local GetOffsetFromEntityInWorldCoords = GetOffsetFromEntityInWorldCoords
local StartShapeTestCapsule = StartShapeTestCapsule
local GetShapeTestResult = GetShapeTestResult
local SetTaskMoveNetworkSignalFloat = SetTaskMoveNetworkSignalFloat
local SetTaskMoveNetworkSignalBool = SetTaskMoveNetworkSignalBool
local GetCamViewModeForContext = GetCamViewModeForContext
local GetCamActiveViewModeContext = GetCamActiveViewModeContext
local isPointing = false


lib.addKeybind({
    name = 'handsup',
    description = 'press E To handsup',
    defaultKey = 'GRAVE',
    onPressed = function(key)
        local onBike = false
        if cache.vehicle then
            local model = GetEntityModel(cache.vehicle)

            onBike = IsThisModelABike(model)
        end
        lib.requestAnimDict('random@mugging3', 1000)
        TaskPlayAnim(cache.ped, 'random@mugging3', 'handsup_standing_base', 8.0, 8.0, -1, 50, 0, false, onBike and 4127 or false, false)
    end,
    onReleased = function(key)
        ClearPedTasks(cache.ped)
    end
})


lib.addKeybind({
        name = 'fingerpoint',
        description = 'Press B to Point Finger',
        defaultKey = 'B',
        onPressed = function()
            isPointing = not isPointing
            if isPointing then
                if cache.vehicle then return end
                lib.requestAnimDict('anim@mp_point', 1000)
                SetPedCurrentWeaponVisible(cache.ped, false, true, true, true)
                SetPedConfigFlag(cache.ped, 36, true)
                TaskMoveNetworkByName(cache.ped, 'task_mp_pointing', 0.5, false, 'anim@mp_point', 24)
                RemoveAnimDict('anim@mp_point')
                CreateThread(function()
                    while isPointing do
                        Wait(0)
                        local camPitch = GetGameplayCamRelativePitch()
                        if camPitch < -70.0 then
                            camPitch = -70.0
                        elseif camPitch > 42.0 then
                            camPitch = 42.0
                        end
                        camPitch = (camPitch + 70.0) / 112.0
                        local camHeading = GetGameplayCamRelativeHeading()
                        local cosCamHeading = Cos(camHeading)
                        local sinCamHeading = Sin(camHeading)
                        if camHeading < -180.0 then
                            camHeading = -180.0
                        elseif camHeading > 180.0 then
                            camHeading = 180.0
                        end
                        camHeading = (camHeading + 180.0) / 360.0
                        local coords = GetOffsetFromEntityInWorldCoords(cache.ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                        local ray = StartShapeTestCapsule(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, cache.ped, 7)
                        local _, blocked = GetShapeTestResult(ray)
                        SetTaskMoveNetworkSignalFloat(cache.ped, 'Pitch', camPitch)
                        SetTaskMoveNetworkSignalFloat(cache.ped, 'Heading', camHeading * -1.0 + 1.0)
                        SetTaskMoveNetworkSignalBool(cache.ped, 'isBlocked', blocked)
                        SetTaskMoveNetworkSignalBool(cache.ped, 'isFirstPerson', GetCamViewModeForContext(GetCamActiveViewModeContext()) == 4)
                    end
                end)
            else
                RequestTaskMoveNetworkStateTransition(cache.ped, 'Stop')

                if not IsPedInjured(cache.ped) then ClearPedSecondaryTask(cache.ped) end
                if not cache.vehicle then SetPedCurrentWeaponVisible(cache.ped, true, true, true, true) end

                SetPedConfigFlag(cache.ped, 36, false)
                ClearPedSecondaryTask(cache.ped)
        end
    end})