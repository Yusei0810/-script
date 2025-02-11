local QBCore = exports['qb-core']:GetCoreObject()

local policeTimers = {}

-- ロケールメッセージの定義
local Translations = {
    notify = {
        speeding_player = "スピード違反を検出しました！速度: %s km/h",  -- %sを使用
        speeding_police = "スピード違反が発生しました！速度: %s km/h",  -- %sを使用
    },
    titles = {
        speeding = "スピード違反通知",
    },
}

RegisterNetEvent('qb-speednotify:speeding', function(speed, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local job = Player.PlayerData.job.name

    -- スピード違反のプレイヤーには通知を送らない
    if job == 'police' then
        return
    end

    -- プレイヤーにスピード違反通知を送信
    local playerMessage = string.format(Translations.notify.speeding_player, string.format("%.2f", speed))
    TriggerClientEvent('okokNotify:Alert', src, Translations.titles.speeding, playerMessage, 5000, 'error')

    -- 警察への通知管理
    local policeMessage = string.format(Translations.notify.speeding_police, string.format("%.2f", speed))
    for _, playerId in pairs(QBCore.Functions.GetPlayers()) do
        local policePlayer = QBCore.Functions.GetPlayer(playerId)
        
        -- 警察プレイヤーにだけ通知を送る
        if policePlayer and policePlayer.PlayerData.job.name == 'police' then
            -- 警察ごとにタイマーをセット
            if not policeTimers[playerId] then
                policeTimers[playerId] = 0
            end

            -- 30秒経過した場合に通知を送信
            if os.time() - policeTimers[playerId] >= 30 then
                TriggerClientEvent('okokNotify:Alert', playerId, Translations.titles.speeding, policeMessage, 5000, 'info')
                policeTimers[playerId] = os.time()  -- タイマーを更新
            end

            -- 警察にBlipを追加
            TriggerClientEvent('qb-speednotify:addSpeedBlip', playerId, coords)
        end
    end
end)
