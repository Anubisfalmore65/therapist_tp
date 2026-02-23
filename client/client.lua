local enteredPassword = ""

function DrawText3D(coords, text)
    local x,y,z = table.unpack(coords)

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255,255,255,215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        Wait(0)

        local player = PlayerPedId()
        local coords = GetEntityCoords(player)

        local dist = #(coords - Config.Entry)

        if dist < Config.Distance then

            DrawMarker(
                1,
                Config.Entry.x,
                Config.Entry.y,
                Config.Entry.z - 1.0,
                0,0,0,
                0,0,0,
                1.0,1.0,1.0,
                0,255,0,150,
                false,true,2,false
            )

            DrawText3D(Config.Entry, "[E] Enter Password")

            if IsControlJustPressed(0, 38) then

                AddTextEntry('FMMC_KEY_TIP1', "Enter Password")
                DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 10)

                while UpdateOnscreenKeyboard() == 0 do
                    Wait(0)
                end

                if GetOnscreenKeyboardResult() then

                    enteredPassword = GetOnscreenKeyboardResult()

                    if enteredPassword == Config.Password then

                        SetEntityCoords(player, Config.Exit)

                        TriggerEvent('chat:addMessage', {
                            args = {"Access Granted"}
                        })

                    else

                        TriggerEvent('chat:addMessage', {
                            args = {"Wrong Password"}
                        })

                    end

                end

            end
        end
    end
end)