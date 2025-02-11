local speedLimit = 120.0 -- �X�s�[�h�����ikm/h�j

CreateThread(function()
    while true do
        Wait(1000) -- 1�b���Ƃɑ��x���`�F�b�N
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local speed = GetEntitySpeed(vehicle) * 3.6 -- m/s �� km/h �ɕϊ�

            if speed > speedLimit then
                TriggerServerEvent('qb-speednotify:speeding', speed)

RegisterNetEvent('qb-speednotify:addSpeedBlip', function(coords)
    -- Blip���쐬
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    -- Blip�̐ݒ�
    SetBlipSprite(blip, 161) -- Blip�̃A�C�R�� (161: �x���A�C�R��)
    SetBlipColour(blip, 1)   -- Blip�̐F (1: �ԐF)
    SetBlipScale(blip, 1.2)  -- Blip�̃T�C�Y
    SetBlipAsShortRange(blip, false) -- Blip����ɕ\������

    -- Blip�̖��O��ݒ�
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("�X�s�[�h�ᔽ�n�_") -- Blip��
    EndTextCommandSetBlipName(blip)

    -- Blip��5����ɍ폜
    Citizen.SetTimeout(300000, function()
        RemoveBlip(blip)
    end)
end)
