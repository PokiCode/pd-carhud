ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local io = false

Citizen.CreateThread(function()
    while true do
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        local ped = GetPlayerPed(-1)
        local vehicleSpeed = GetEntitySpeed(vehicle)
        local vehicleGear = GetVehicleCurrentGear(vehicle)
        local vehicleFuel = GetVehicleFuelLevel(vehicle)
        local vehicleHealth = GetVehicleEngineHealth(vehicle)
        local m = 1000

        if IsPedInAnyVehicle(ped, false) and GetIsVehicleEngineRunning(vehicle) and GetPedInVehicleSeat(vehicle, ped) and not IsPauseMenuActive() then
            if Config["UseKM"] == true then
                SendNUIMessage({
                    action = "show";
                    showSpeed = vehicleSpeed * 3.18;
                    showGear = "GEAR " .. vehicleGear;
                    showFuel = ESX.Math.Round(vehicleFuel),
                    showVehicleState = ESX.Math.Round(vehicleHealth / 10),
                })
                m = 100
            else
                SendNUIMessage({
                    action = "show";
                    showSpeed = vehicleSpeed;
                    showGear = "GEAR " .. vehicleGear;
                    showFuel = ESX.Math.Round(vehicleFuel),
                    showVehicleState = ESX.Math.Round(vehicleHealth / 10),
                })
                m = 100
            end
        else
            SendNUIMessage({
                action = "hide";
            })
            m = 1000
        end 

        if IsPauseMenuActive() and not pause then
            pause = true
            SendNUIMessage({
                action = "hide";
            })
        elseif not IsPauseMenuActive() and pause and IsPedInAnyVehicle(ped, false) then
            pause = false
            SendNUIMessage({
                action = "show";
            })
        end

        Citizen.Wait(m)
    end
end)