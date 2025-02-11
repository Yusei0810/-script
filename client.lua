local speedLimit = 120.0 -- スピード制限（km/h）

CreateThread(function()
    while true do
        Wait(1000) -- 1秒ごとに速度をチェック
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local speed = GetEntitySpeed(vehicle) * 3.6 -- m/s を km/h に変換

            if speed > speedLimit then
                TriggerServerEvent('qb-speednotify:speeding', speed)

RegisterNetEvent('qb-speednotify:addSpeedBlip', function(coords)
    -- Blipを作成
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    -- Blipの設定
    SetBlipSprite(blip, 161) -- Blipのアイコン (161: 警告アイコン)
    SetBlipColour(blip, 1)   -- Blipの色 (1: 赤色)
    SetBlipScale(blip, 1.2)  -- Blipのサイズ
    SetBlipAsShortRange(blip, false) -- Blipを常に表示する

    -- Blipの名前を設定
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("スピード違反地点") -- Blip名
    EndTextCommandSetBlipName(blip)

    -- Blipを5分後に削除
    Citizen.SetTimeout(300000, function()
        RemoveBlip(blip)
    end)
end)
