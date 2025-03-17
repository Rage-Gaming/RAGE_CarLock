local vehicleTable = {}

function AddKey(plate)
    
    if plate and vehicleTable[plate] == nil then
        vehicleTable[plate] = {haskey = true}
    end
end

function RemoveKey(plate)
    if plate and vehicleTable[plate] then
        vehicleTable[plate].haskey = false
        vehicleTable[plate] = nil
    end
end

exports("AddKey", AddKey);
exports("RemoveKey", RemoveKey);


RegisterNetEvent('dm-carlock:client:setLockState')
AddEventHandler('dm-carlock:client:setLockState', function(netId, state)
    local vehicle = NetToVeh(netId)
    if DoesEntityExist(vehicle) then
        SetVehicleDoorsLocked(vehicle, state)
        SetVehicleDoorsLockedForAllPlayers(vehicle, state == 2)
        SetVehicleLights(vehicle, 2)
        Citizen.Wait(250)
        SetVehicleLights(vehicle, 0)
        StartVehicleHorn(vehicle, 500, "NORMAL", -1)
        PlaySoundFrontend(-1, 'Hack_Success', 'DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS', 0)
    end
end)


RegisterNetEvent('dm-carlock:client:notify')
AddEventHandler('dm-carlock:client:notify', function(state, plate)
    if state == 2 then
        lib.notify({title = 'Vehicle', description = 'Locked '..plate, type = 'error'})
    else
        lib.notify({title = 'Vehicle', description = 'Unlocked '..plate, type = 'success'})
    end
end)

function ToggleVehicleLock()
    local playerPed = PlayerPedId()
    local vehicle = lib.getClosestVehicle(GetEntityCoords(playerPed), 5, false) or GetVehiclePedIsIn(playerPed, false)
    local isOwned = false
    local needtoCheck = true

    if not vehicle or not DoesEntityExist(vehicle) then return lib.notify({title = 'Vehicle', description = 'No vehicle nearby', type = 'error'}) end

    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    local netId = VehToNet(vehicle)

    if vehicleTable[plate] == nil then
        ESX.TriggerServerCallback('dm-carlock:requestPlayerCars', function(isOwner)
            if isOwner then
                isOwned = isOwner
                AddKey(plate)
            end
        end, plate)
        needtoCheck = false
    end
    while needtoCheck and vehicleTable[plate] == nil do
        print("Waiting")
        Wait(1000)
    end
    if isOwned or (vehicleTable[plate] ~= nil and vehicleTable[plate].haskey) then
        lockAnimation()
        TriggerServerEvent('dm-carlock:server:toggleLock', netId, plate)
    else
        lib.notify({title = 'Vehicle', description = 'No keys for '..plate, type = 'error'})
    end
end

function lockAnimation()
    local ped = PlayerPedId()
    RequestAnimDict("anim@heists@keycard@")
    while not HasAnimDictLoaded("anim@heists@keycard@") do Citizen.Wait(0) end
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    Citizen.Wait(600)
    ClearPedTasks(ped)
end


RegisterCommand(Config.ToggleLockCommand, function ()
    ToggleVehicleLock()
end, false)

RegisterKeyMapping(Config.ToggleLockCommand, 'Lock/Unlock your vehicle', 'keyboard', Config.KeyBind)