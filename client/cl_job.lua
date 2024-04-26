local ESX = exports['es_extended']:getSharedObject()

lib.locale()

local jobVan = nil

pedSpawned = false
injob = false
hasDelivered = 0

RegisterNetEvent('hs-deliveryjob:startjob')
AddEventHandler('hs-deliveryjob:startjob', function()
    local _source = source
    local xPlayer = GetPlayerPed()

    lib.progressCircle({
        duration = 1500,
        position = 'middle',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
        }
    })

    injob = true

    ESX.Game.SpawnVehicle(HS.jobvehicle, HS.locations.vehicleSpawn.spawnPos, HS.locations.vehicleSpawn.heading , function(jobVan2)
        jobVan = jobVan2
        local deliveryLoc = HS.Coords[math.random(#HS.Coords)]
        continueJob(deliveryLoc)
    end)
end)

exports.ox_target:addSphereZone({
    coords = HS.locations.startPos,
    size = vec3(0.5, 0.5, 1.0),
    rotation = 45,
    drawSprite = true,
    options = {
        {
            distance = 2.5,
            name = 'startJob',
            icon = 'fa-solid fa-box',
            label = locale('delivery_job_title'),
            onSelect = function()
                if not injob then
                    lib.showContext('hs-startmenu')
                else
                    lib.showContext('hs-removeVehMenu')
                end
            end
        }}

})

-- NPC spawning: 
CreateThread(function()
    local xPlayer = GetPlayerPed()
    local location = HS.locations.startPos

    while not pedSpawned do
        Wait(50)
        local coords = GetEntityCoords(xPlayer)

        if not pedSpawned then
            local model = HS.npc.model
            local hash = GetHashKey(model)
            local animation = HS.npc.animation
            local heading = HS.npc.heading

            RequestModel(hash)
            while not HasModelLoaded(GetHashKey(model)) do
                Wait(15)
            end
            RequestAnimDict(animation)
            while not HasAnimDictLoaded(animation) do
                Wait(15)
            end
            ped = CreatePed(4, hash, location.x, location.y, location.z - 1, 3374176, false, true)
            SetEntityHeading(ped, heading)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskPlayAnim(ped, animation, HS.npc.anim_dir, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
            pedSpawned = true

        end
    end
end)

function spawnNPC(x, y, z, heading, pedModel)
    local location = vector3(x, y, z)

    local hash = GetHashKey(pedModel)
    local animation = HS.DeliveryNPCAnim.anim
    local animDir = HS.DeliveryNPCAnim.dict

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(15)
    end

    RequestAnimDict(animation)
    while not HasAnimDictLoaded(animation) do
        Wait(15)
    end

    ped = CreatePed(4, hash, location.x, location.y, location.z - 1, 3374176, false, true)

    SetEntityHeading(ped, heading)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped, animation, animDir, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
end

function continueJob(deliveryLoc)
    
    local pedModel = HS.DeliveryNPC[math.random(#HS.DeliveryNPC)]
    local spawnedPed = spawnNPC(deliveryLoc.x, deliveryLoc.y, deliveryLoc.z, deliveryLoc.w, pedModel)

    lib.notify({
        title = locale('delivery_job_title'),
        description = locale('go_to_next_location'),
        type = 'inform'
    })

    local newDeliveryBlip = AddBlipForCoord(deliveryLoc)
        SetBlipSprite(newDeliveryBlip, HS.Blips.destination.blipSprite)
        SetBlipDisplay(newDeliveryBlip, 2)
        SetBlipColour(newDeliveryBlip, HS.Blips.destination.blipColour)
        SetBlipScale(newDeliveryBlip, HS.Blips.destination.blipScale)
            BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(HS.Blips.destination.text)
        EndTextCommandSetBlipName(newDeliveryBlip)
        SetBlipRoute(newDeliveryBlip, true)
        SetBlipRouteColour(newDeliveryBlip, HS.Blips.destination.blipColour)

    exports.ox_target:addSphereZone({
        name = 'getReward',
        coords = deliveryLoc,
        size = vec3(0.5, 0.5, 1.0),
        rotation = 45,
        drawSprite = true,
        options = {
            {
                distance = 2.5,
                icon = 'fa-solid fa-box',
                label = locale('give_delivery'),
                onSelect = function()
                    Wait(50)
                    RemoveBlip(newDeliveryBlip)
                    deliveryAnim(deliveryLoc)
                end
            }}
    })

    -- Context menu for deleting vehicle / continuing job:
    lib.registerContext({
        id = 'hs-removeVehMenu',
        title = locale('delivery_job_title'),
        options = {
            {
                title = locale('remove_vehicle'),
                icon = 'fa-solid fa-box',
                onSelect = function()
                    if injob then
                        ESX.Game.DeleteVehicle(jobVan)
                        exports.ox_target:removeZone('getReward') -- Removes old delivery location
                        RemoveBlip(newDeliveryBlip)
                        RemoveBlip(returnBlip)
                        injob = false
                        lib.notify({
                            title = locale('clocked_off_work'),
                            type = 'success'
                        })
                        if hasDelivered >= 2 then
                            TriggerServerEvent('hs-deliveryjob:reward')
                            hasDelivered = 0
                            lib.notify({
                                title = locale('return_rewarded'),
                                type = 'success'
                            })
                        end
                    else
                        lib.notify({
                            title = locale('not_in_job'),
                            type = 'error'
                        })
                    end
                end,
            }
        }
    })
end

function deliveryAnim(deliveryLoc)
    local xPlayer = PlayerPedId()
    CreateThread(function()
        TaskStartScenarioInPlace(xPlayer, "WORLD_HUMAN_CLIPBOARD", 0, true)
        -- Progress circle:
        lib.progressCircle({
            duration = 5000,
            position = 'middle',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                move = true,
                combat = true,
            }
        })
        ClearPedTasksImmediately(xPlayer)
        lib.notify({
            title = locale('delivery_job_title'),
            description = 'You completed the delivery!',
            type = 'success'
        })
        exports.ox_target:removeZone('getReward') -- Removes old delivery location
        TriggerServerEvent('hs-deliveryjob:reward')
        hasDelivered = hasDelivered + 1
        Wait(250)
        lib.showContext('hs-continuemenu')
        local ped = ESX.Game.GetClosestPed(deliveryLoc)
        Wait(15000)
        DeletePed(ped)
    end)
end

CreateThread(function()
    -- Context menu for starting delivery:
    lib.registerContext({
        id = 'hs-startmenu',
        title = locale('delivery_job_title'),
        options = {
            {
                title = locale('start_delivery'),
                description = locale('spawns_van'),
                icon = 'fa-solid fa-box',
                onSelect = function()
                    if not injob then
                        TriggerEvent('hs-deliveryjob:startjob')
                    else
                        lib.notify({
                            title = locale('delivery_job_title'),
                            description = locale('already_in_job'),
                            type = 'error'
                        })
                    end
                end,
            },
            {
                title = locale('return'),
                icon = 'fa-solid fa-arrow-left',
                onSelect = function()
                    lib.hideContext()
                end,
            }
        }
    })
    -- Context menu for checking if person wants to continue delivering:
    lib.registerContext({
        id = 'hs-continuemenu',
        canClose = false,
        title = locale('q_continue'),
        options = {
            {
                title = locale('yes'),
                icon = 'fa-regular fa-circle-check',
                onSelect = function()
                    if injob then
                        local deliveryLoc = HS.Coords[math.random(#HS.Coords)]
                        continueJob(deliveryLoc)
                    else
                        -- Just there for errors:
                        lib.notify({
                            title = locale('delivery_job_title'),
                            description = locale('go_to_start_pos'),
                            type = 'error'
                        })
                        injob = false
                    end
                end,
            },
            {
                title = locale('no'),
                icon = 'fa-regular fa-circle-xmark',
                onSelect = function()
                    local returnBlip = AddBlipForCoord(HS.locations.vehicleSpawn.spawnPos)
                        SetBlipSprite(returnBlip, HS.Blips.returnVeh.blipSprite)
                        SetBlipDisplay(returnBlip, 2)
                        SetBlipColour(returnBlip, HS.Blips.returnVeh.blipColour)
                        SetBlipScale(returnBlip, HS.Blips.returnVeh.blipScale)
                            BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(HS.Blips.returnVeh.text)
                        EndTextCommandSetBlipName(returnBlip)
                        SetBlipRoute(returnBlip, true)
                        SetBlipRouteColour(returnBlip, HS.Blips.returnVeh.blipColour)

                    lib.notify({
                        title = locale('delivery_job_title'),
                        description = locale('go_return_van'),
                        type = 'inform'
                    })
                end,
            }
        }

    })

end)

-- Start position blip:
CreateThread(function()
    startBlip = AddBlipForCoord(HS.locations.startPos)
    SetBlipSprite(startBlip, HS.Blips.jobStart.blipSprite)
    SetBlipDisplay(startBlip, 4)
    SetBlipScale(startBlip, HS.Blips.jobStart.blipScale)
    SetBlipColour(startBlip, HS.Blips.jobStart.blipColour)
    SetBlipAsShortRange(startBlip, true)
        BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(HS.Blips.jobStart.text)
    EndTextCommandSetBlipName(startBlip)
end)