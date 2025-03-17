local VehicleLocks = {}

ESX.RegisterServerCallback('dm-carlock:requestPlayerCars', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchScalar('SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(result)
        cb(result == 1)
    end)
end)

RegisterNetEvent('dm-carlock:server:toggleLock')
AddEventHandler('dm-carlock:server:toggleLock', function(netId, plate)
    local src = source
    local currentState = VehicleLocks[netId] or 1
    local newState = currentState == 1 and 2 or 1
    
    VehicleLocks[netId] = newState
    
    TriggerClientEvent('dm-carlock:client:setLockState', -1, netId, newState)
    TriggerClientEvent('dm-carlock:client:notify', src, newState, plate)
end)