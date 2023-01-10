script_name('Crimson_Tide Helper')
script_authors('Cafferdam_Berser')

-- подключаем библиотеки
local dlstatus = require('moonloader').download_status

-- создаём переменные
update_state = false -- Если переменная == true, значит начнётся обновление.
update_found = false -- Если будет true, будет доступна команда /update.

local script_vers = 1.0
local script_vers_text = "v1.0" -- Название нашей версии. В будущем будем её выводить ползователю.

local update_url = 'https://raw.githubusercontent.com/DokaiiMob/AUCTH/main/update.ini?token=GHSAT0AAAAAAB5IMAWTDADWJ3AXVZGN5JHAY55MAUQ' -- Путь к ini файлу. Позже нам понадобиться.
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = 'https://raw.githubusercontent.com/DokaiiMob/AUCTH/main/crimsonhelp.lua?token=GHSAT0AAAAAAB5JVMF5LFPCFTH4YUOD7LTKY55ML3Q' -- Путь скрипту.
local script_path = thisScript().path

-- готовый код
function check_update() -- Создаём функцию которая будет проверять наличие обновлений при запуске скрипта.
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then -- Сверяем версию в скрипте и в ini файле на github
                sampAddChatMessage("{FFFFFF}Имеется {32CD32}новая {FFFFFF}версия скрипта. Версия: {32CD32}"..updateIni.info.vers_text..". {FFFFFF}/update что-бы обновить", 0xFF0000) -- Сообщаем о новой версии.
                update_found == true -- если обновление найдено, ставим переменной значение true
            end
            os.remove(update_path)
        end
    end)
end

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	
