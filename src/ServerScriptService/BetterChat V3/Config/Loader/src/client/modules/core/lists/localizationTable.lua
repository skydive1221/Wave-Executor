-- Author: @Jumpathy
-- Credit: ?? (Roblox)
-- Name: table.lua
-- Description: Chat localization for accessibility

local entries = {
	{
		Key = "Muted",
		Values = { --> google translate go brr
			es = "No puedes hablar ahora mismo",
			ja = "今は話せません",
			fr = "Tu ne peux pas parler maintenant",
			["es-es"] = "No puedes hablas ahora mismo",
			["zh-cn"] = "你现在不能说话",
			["zh-tw"] = "你現在不能說話",
			ru = "Вы не можете говорить прямо сейчас",
			["de"] = "Je kunt nu niet praten",
			["ko"] = "당신은 지금 채팅에서 말할 수 없습니다",
			["pt-br"] = "Você não pode falar agora",
			["en-us"] = "You can't talk right now"
		}
	},
	{
		Key = "Chat_Edited",
		Values = { -- google translated by me so might not be 100% accurate
			es = "editado",
			ja = "編集",
			fr = "édité",
			["es-es"] = "editado",
			["zh-cn"] = "已编辑",
			["zh-tw"] = "已編輯",
			ru = "отредактировано",
			de = "bearbeitet",
			ko = "편집",
			["pt-br"] = "editado",
			["en-us"] = "edited",
			it = "modificato"
		}
	},
    {
        Key = "GameChat_ChatChannel_MutedInChannel",
        Values = {
            es = "Se te ha silenciado y no puedes hablar en este canal.",
            ja = "あなたはミュートされこのチャンネルで話すことは出来ません。",
            fr = "Vous êtes bâillonné et ne pouvez pas parler sur ce canal",
            ["es-es"] = "Se te ha silenciado y no puedes hablar en este canal.",
            ["zh-cjv"] = "你已被禁言，无法在此频道聊天",
            ["zh-tw"] = "您遭到靜音，無法在此頻道聊天",
            ru = "Вы добавлены в список игнорируемых и не можете общаться на этом канале",
            ["zh-cn"] = "你已被禁言，无法在此频道聊天",
            de = "Du wurdest stummgeschaltet und kannst in diesem Kanal nicht kommunizieren.",
            ko = "이 채널에서 음소거되어 이야기할 수 없어요",
            ["pt-br"] = "Você está silenciado(a) e não pode falar neste canal",
            pt = "Você está silenciado(a) e não pode falar neste canal",
            ["en-us"] = "You are muted and cannot talk in this channel",
            it = "Non hai più la parola e non puoi chattare in questo canale"
        }
    },
    {
        Key = "GameChat_ChatCommandsTeller_AllChannelWelcomeMessage",
        Values = {
            es = "Envía \"/?\" o \"/help\" para obtener la lista de comandos del chat.",
            ja = "チャットで 「/?」 または 「/help」を入力するとチャットコマンドの一覧を表示します。",
            fr = "Dans le chat, « /? » ou « /help » pour la liste des commandes du chat.",
            ["es-es"] = "Envía \"/?\" o \"/help\" para obtener la lista de comandos del chat.",
            ["zh-cjv"] = "输入 “/?”或 “/help” 可获取聊天指令清单。",
            ["zh-tw"] = "輸入「/?」或「/help」取得聊天指令清單。",
            ru = "Введите «/?» или «/help», чтобы увидеть список команд чата.",
            ["zh-cn"] = "输入 “/?”或 “/help” 可获取聊天指令清单。",
            de = "Gib „/?“ oder „/help“ im Chat ein, um eine Liste der Chatbefehle zu erhalten.",
            ko = "채팅창에 '/?' 또는 '/도움말'을 입력하면 채팅 명령어 목록을 볼 수 있어요.",
            ["pt-br"] = "Digite '/?' ou '/help' no chat para ver uma lista de comandos.",
            pt = "Digite '/?' ou '/help' no chat para ver uma lista de comandos.",
            ["en-us"] = "Chat '/?' or '/help' for a list of chat commands.",
            it = "Scrivi \"/?\" o \"/help\" per avere l'elenco dei comandi della chat."
        }
    },
    {
        Key = "GameChat_ChatCommandsTeller_Desc",
        Values = {
            es = "Estos son los comandos básicos del chat.",
            ja = "これらは基本的なチャットコマンドです。",
            fr = "Voici les commandes de chat basiques.",
            ["es-es"] = "Estos son los comandos básicos del chat.",
            ["zh-cjv"] = "这些是基本聊天指令。",
            ["zh-tw"] = "以下是基本聊天室指令。",
            ru = "Это основные команды чата.",
            ["zh-cn"] = "这些是基本聊天指令。",
            de = "Das sind die grundlegenden Chatbefehle.",
            ko = "기본 채팅 명령어에요.",
            ["pt-br"] = "Esses são os comandos de chat básicos.",
            pt = "Esses são os comandos de chat básicos.",
            ["en-us"] = "These are the basic chat commands.",
            it = "Questi sono i comandi base della chat."
        }
    },
    {
        Key = "GameChat_ChatCommandsTeller_MeCommand",
        Values = {
            es = "/me <text>: comando de rol para realizar acciones.",
            ja = "/me <テキスト> : アクションのためのロールプレイングコマンド。",
            fr = "/me <texte> : commande jeu de rôle pour accomplir des actions.",
            ["es-es"] = "/me <text>: comando de rol para realizar acciones.",
            ["zh-cjv"] = "/me <text> : 做动作的角色扮演指令。",
            ["zh-tw"] = "/me <文字>：角色扮演動作的指令。",
            ru = "/me <текст> : сообщить о выполнении какого-либо действия.",
            ["zh-cn"] = "/me <text> : 做动作的角色扮演指令。",
            de = "/me <Text> : Rollenspielbefehl für Aktionen.",
            ko = "/me <텍스트> : 작업 수행을 위한 역할 놀이 명령어.",
            ["pt-br"] = "/me <texto> : comando de RPG para realizar ações.",
            pt = "/me <texto> : comando de RPG para realizar ações.",
            ["en-us"] = "/me <text> : roleplaying command for doing actions.",
            it = "/me <testo>: comando per descrivere azioni e giocare di ruolo."
        }
    },
    {
        Key = "GameChat_ChatCommandsTeller_MuteCommand",
        Values = {
            es = "/mute <usuario>: silenciar a un usuario.",
            ja = "/mute <スピーカー> : 相手をミュート。",
            fr = "/mute <interlocuteur> : bâillonne un interlocuteur.",
            ["es-es"] = "/mute <usuario>: silenciar a un usuario.",
            ["zh-cjv"] = "/mute <用户名称>：将用户禁言。",
            ["zh-tw"] = "/mute <使用者名稱> : 將此使用者靜音。",
            ru = "/mute <пользователь> : игнорировать пользователя.",
            ["zh-cn"] = "/mute <用户名称>：将用户禁言。",
            de = "/mute <Sprecher> : Schaltet Sprecher:in stumm.",
            ko = "/mute <스피커> : 스피커 음소거.",
            ["pt-br"] = "/mute <pessoa> : silenciar uma pessoa.",
            pt = "/mute <pessoa> : silenciar uma pessoa.",
            ["en-us"] = "/mute <speaker> : mute a speaker.",
            it = "/mute <giocatore>: togli la parola a un giocatore."
        }
    },
    {
        Key = "GameChat_ChatCommandsTeller_SwitchChannelCommand",
        Values = {
            es = "/c <channel>: alternar pestañas del menú del chat.",
            ja = "/c <チャンネル> : チャンネルメニュータブを切り替える。",
            fr = "/c <canal> : échanger les onglets du menu Canal.",
            ["es-es"] = "/c <channel>: alternar pestañas del menú del chat.",
            ["zh-cjv"] = "/c <频道名称> : 切换频道菜单标签。",
            ["zh-tw"] = "/c <頻道名稱>：切換頻道選單標籤。",
            ru = "/c <канал> : переключить вкладку в меню каналов.",
            ["zh-cn"] = "/c <频道名称> : 切换频道菜单标签。",
            de = "/c <Kanal> : Zum Wechseln zwischen Kanalmenüreitern.",
            ko = "/c <채널> : 채널 메뉴 탭 전환.",
            ["pt-br"] = "/c <canal> : trocar abas de menu de canal.",
            pt = "/c <canal> : trocar abas de menu de canal.",
            ["en-us"] = "/c <channel> : switch channel menu tabs.",
            it = "/c <canale>: cambia scheda nel menu dei canali."
        }
    },
    {
        Key = "GameChat_ChatCommandsTeller_TeamCommand",
        Values = {
            es = "/team <message> o /t <message>: enviar un mensaje de chat de equipo a los jugadores de tu equipo.",
            ja = "/team <メッセージ> または /t <メッセージ> : 自分のチームメンバーにチームチャットを送る。",
            fr = "/team <message> ou /t <message> : envoyer un message aux joueurs de votre équipe.",
            ["es-es"] = "/team <message> o /t <message>: enviar un mensaje de chat de equipo a los jugadores de tu equipo.",
            ["zh-cjv"] = "/team <message> 或 /t <message> : 向你团队的玩家发送团队聊天。",
            ["zh-tw"] = "/team <訊息> 或 /t <訊息> : 傳送訊息給隊伍中的玩家。",
            ru = "/team <сообщение> или /t <сообщение> : отправить сообщение игрокам из вашей команды.",
            ["zh-cn"] = "/team <message> 或 /t <message> : 向你团队的玩家发送团队聊天。",
            de = "/team <Nachricht> oder /t <Nachricht> : Sendet eine Teamnachricht an Spieler:innen deines Teams.",
            ko = "/team <메시지> 또는 /t <메시지> : 팀 내 플레이어에게 팀 채팅 전송.",
            ["pt-br"] = "/team <mensagem> ou /t <mensagem> : enviar um chat de equipe aos jogadores da sua equipe.",
            pt = "/team <mensagem> ou /t <mensagem> : enviar um chat de equipe aos jogadores da sua equipe.",
            ["en-us"] = "/team <message> or /t <message> : send a team chat to people on your team.",
            it = "/team <messaggio> o /t <messaggio>: invia un messaggio a tutti i giocatori della tua squadra."
        }
    },
    {
        Key = "GameChat_ChatCommandsTeller_UnMuteCommand",
        Values = {
            es = "/unmute <speaker>: cancelar silencio de un usuario.",
            ja = "/unmute <スピーカー> : 相手のミュートを解除.",
            fr = "/unmute <interlocuteur> : retire le bâillon d'un interlocuteur.",
            ["es-es"] = "/unmute <speaker>: cancelar silencio de un usuario.",
            ["zh-cjv"] = "/unmute <用户名称> : 取消该用户禁言。",
            ["zh-tw"] = "/unmute <使用者名稱> : 將此使用者解除靜音。",
            ru = "/unmute <пользователь> : перестать игнорировать пользователя.",
            ["zh-cn"] = "/unmute <用户名称> : 取消该用户禁言。",
            de = "/unmute <Sprecher> : Hebt Stummschaltung eines Sprechers auf.",
            ko = "/unmute <스피커> : 스피커 음소거 해제.",
            ["pt-br"] = "/unmute <pessoa> : remover silêncio de uma pessoa.",
            pt = "/unmute <pessoa> : remover silêncio de uma pessoa.",
            ["en-us"] = "/unmute <speaker> : unmute a speaker.",
            it = "/unmute <giocatore>: restituisci la parola a un giocatore."
        }
    },
    {
        Key = "GameChat_ChatCommandsTeller_WhisperCommand",
        Values = {
            es = "/whisper <usuario> o /w <usuario>: abrir canal de mensajes privados con un usuario.",
            ja = "/whisper <スピーカー> または /w <スピーカー> : プライベートメッセージチャンネルを開く",
            fr = "/whisper <interlocuteur> ou /w <interlocuteur> : ouvre un canal de discussion privé avec l'interlocuteur.",
            ["es-es"] = "/whisper <usuario> o /w <usuario>: abrir canal de mensajes privados con un usuario.",
            ["zh-cjv"] = "/whisper <用户名称> 或 /w <用户名称> : 与此用户开启私人消息频道。",
            ["zh-tw"] = "/whisper <使用者名稱> 或 /w <使用者名稱> : 與此使用者開啟私人訊息頻道。",
            ru = "/whisper <пользователь> или /w <пользователь> : открыть канал для личной переписки с пользователем.",
            ["zh-cn"] = "/whisper <用户名称> 或 /w <用户名称> : 与此用户开启私人消息频道。",
            de = "/whisper <Sprecher:in> oder /w <Sprecher:in> : Öffnet privaten Nachrichtenkanal mit Sprecher:in.",
            ko = "/whisper <스피커> 또는 /w <스피커> : 스피커 채널에서 비공개 메시지 열기.",
            ["pt-br"] = "/whisper <pessoa> ou /w <pessoa> : abrir um canal de mensagem privada com uma pessoa.",
            pt = "/whisper <pessoa> ou /w <pessoa> : abrir um canal de mensagem privada com uma pessoa.",
            ["en-us"] = "/whisper <speaker> or /w <speaker> : open private message channel with speaker.",
            it = "/whisper <giocatore> o /w <giocatore>: apri un canale privato con un giocatore."
        }
    },
    {
        Key = "GameChat_ChatFloodDetector_Message",
        Values = {
            es = "¡Debes esperar antes de enviar otro mensaje!",
            ja = "少し待ってから次のメッセージを送ってください!",
            fr = "Vous devez attendre avant d'envoyer un autre message !",
            ["es-es"] = "¡Debes esperar antes de enviar otro mensaje!",
            ["zh-cjv"] = "发送另一条消息前你必须等待！",
            ["zh-tw"] = "請稍後再傳送訊息。",
            ru = "Необходимо подождать, прежде чем отправлять новое сообщение!",
            ["zh-cn"] = "发送另一条消息前你必须等待！",
            de = "Du musst warten, bevor du eine weitere Nachricht senden kannst!",
            ko = "추가 메시지를 보내기 전에 기다려야 해요!",
            ["pt-br"] = "Você precisa esperar antes de enviar outra mensagem!",
            pt = "Você precisa esperar antes de enviar outra mensagem!",
            ["en-us"] = "You must wait before sending another message!",
            it = "Devi aspettare prima di inviare un altro messaggio!"
        }
    },
    {
        Key = "GameChat_ChatFloodDetector_MessageDisplaySeconds",
        Values = {
            es = "¡Debes esperar {1:int} segundos antes de enviar otro mensaje!",
            ja = "{1:int} 秒待ってから次のメッセージを送ってください!",
            fr = "Vous devez attendre {1:int} secondes avant d'envoyer un autre message !",
            ["es-es"] = "¡Debes esperar {1:int} segundos antes de enviar otro mensaje!",
            ["zh-cjv"] = "发送另一条消息前你必须等待 {1:int} 秒！",
            ["zh-tw"] = "請 {1:int} 秒後再傳送訊息。",
            ru = "Вы сможете отправить новое сообщение только через {1:int} сек.!",
            ["zh-cn"] = "发送另一条消息前你必须等待 {1:int} 秒！",
            de = "Du musst {1:int} Sekunden lang warten, bevor du eine weitere Nachricht senden kannst!",
            ko = "추가 메시지를 보내기 전에 {1:int}초 동안 기다려야 해요!",
            ["pt-br"] = "Você precisa esperar {1:int} segundos antes de enviar outra mensagem!",
            pt = "Você precisa esperar {1:int} segundos antes de enviar outra mensagem!",
            ["en-us"] = "You must wait {1:int} seconds before sending another message!",
            it = "Devi aspettare {1:int} secondi prima di inviare un altro messaggio!"
        }
    },
    {
        Key = "GameChat_ChatMain_ChatBarText",
        Values = {
            es = "Para chatear, haz clic aquí o pulsa la tecla \"/\".",
            ja = "チャットするにはここをクリックするか 「 / 」 キーを押します。",
            fr = "Pour discuter, cliquez ici ou sur la touche « / »",
            ["es-es"] = "Para chatear, haz clic aquí o pulsa la tecla \"/\".",
            ["zh-cjv"] = "若要聊天，请点按此处或按下“/”键",
            ["zh-tw"] = "若要聊天，請按下此處或「/」鍵",
            ru = "Чтобы общаться в чате, нажмите здесь или на клавишу «/»",
            ["zh-cn"] = "若要聊天，请点按此处或按下“/”键",
            de = "Klicke zum Chatten hier oder drücke die „/“-Taste.",
            ko = "여기를 클릭하거나 \"/\" 키를 누른 후 채팅을 시작하세요",
            ["pt-br"] = "Para escrever clique aqui ou aperte a tecla \"/\"",
            pt = "Para escrever clique aqui ou aperte a tecla \"/\"",
			["en-us"] = "Click here or press '/' to chat.",
            it = "Per chattare, clicca qui o premi il tasto \"/\""
        }
    },
    {
        Key = "GameChat_ChatMain_ChatBarTextTouch",
        Values = {
            es = "Toca aquí para chatear",
            ja = "ここをタップしてチャットする",
            fr = "Touchez ici pour discuter",
            ["es-es"] = "Toca aquí para chatear",
            ["zh-cjv"] = "轻点此处以聊天",
            ["zh-tw"] = "按下此處聊天",
            ru = "Коснитесь здесь, чтобы общаться в чате",
            ["zh-cn"] = "轻点此处以聊天",
            de = "Tippe zum Chatten hier.",
            ko = "여기를 클릭한 후 내용을 입력하세요",
            ["pt-br"] = "Toque aqui para escrever",
            pt = "Toque aqui para escrever",
            ["en-us"] = "Tap here to chat",
            it = "Tocca qui per chattare"
        }
    },
    {
        Key = "GameChat_ChatMain_SpeakerHasBeenBlocked",
        Values = {
            es = "Se ha bloqueado al usuario \"{RBX_NAME}\".",
            ja = "「{RBX_NAME}」はブロック中です。",
            fr = "L'interlocuteur {RBX_NAME} a été bloqué.",
            ["es-es"] = "Se ha bloqueado al usuario \"{RBX_NAME}\".",
            ["zh-cjv"] = "发言者“{RBX_NAME}”已被屏蔽。",
            ["zh-tw"] = "已封鎖使用者「{RBX_NAME}」。",
            ru = "Пользователь {RBX_NAME} заблокирован.",
            ["zh-cn"] = "发言者“{RBX_NAME}”已被屏蔽。",
            de = "Sprecher:in „{RBX_NAME}“ wurde blockiert.",
            ko = "스피커 '%s'님을 차단했어요.",
            ["pt-br"] = "'%s' foi bloqueado.",
            pt = "'%s' foi bloqueado.",
            ["en-us"] = "Speaker '%s' has been blocked.",
            it = "Hai bloccato il giocatore \"{RBX_NAME}\"."
        }
    },
    {
        Key = "GameChat_ChatMain_SpeakerHasBeenMuted",
        Values = {
            es = "Se ha silenciado al usuario \"{RBX_NAME}\".",
            ja = "「{RBX_NAME}」をミュートしました。",
            fr = "L'interlocuteur {RBX_NAME} a été bâillonné.",
            ["es-es"] = "Se ha silenciado al usuario \"{RBX_NAME}\".",
            ["zh-cjv"] = "发言者“{RBX_NAME}”已被禁言。",
            ["zh-tw"] = "已將使用者「{RBX_NAME}」靜音。",
            ru = "Пользователь {RBX_NAME} добавлен в список игнорируемых.",
            ["zh-cn"] = "发言者“{RBX_NAME}”已被禁言。",
            de = "Sprecher:in „{RBX_NAME}“ wurde stummgeschaltet.",
            ko = "스피커 '%s'이(가) 음소거되었어요.",
            ["pt-br"] = "'%s' foi silenciado(a).",
            pt = "'%s' foi silenciado(a).",
            ["en-us"] = "Speaker '%s' has been muted.",
            it = "Hai tolto la parola al giocatore \"{RBX_NAME}\"."
        }
    },
    {
        Key = "GameChat_ChatMain_SpeakerHasBeenUnBlocked",
        Values = {
            es = "Se ha desbloqueado al usuario \"{RBX_NAME}\".",
            ja = "「{RBX_NAME}」のブロックが解除されました。",
            fr = "L'interlocuteur {RBX_NAME} n'est plus bloqué.",
            ["es-es"] = "Se ha desbloqueado al usuario \"{RBX_NAME}\".",
            ["zh-cjv"] = "发言者“{RBX_NAME}”已被取消屏蔽。",
            ["zh-tw"] = "已解除封鎖使用者「{RBX_NAME}」。",
            ru = "Пользователь {RBX_NAME} разблокирован.",
            ["zh-cn"] = "发言者“{RBX_NAME}”已被取消屏蔽。",
            de = "Blockierung von Sprecher:in „{RBX_NAME}“ wurde aufgehoben.",
            ko = "스피커 '%s'님 차단을 해제했어요.",
            ["pt-br"] = "'%s' foi desbloqueado.",
            pt = "'%s' foi desbloqueado.",
            ["en-us"] = "Speaker '%s' has been unblocked.",
            it = "Hai sbloccato il giocatore \"{RBX_NAME}\"."
        }
    },
    {
        Key = "GameChat_ChatMain_SpeakerHasBeenUnMuted",
        Values = {
            es = "Se ha cancelado el silencio del usuario \"{RBX_NAME}\".",
            ja = "「{RBX_NAME}」のミュートを解除しました。",
            fr = "L'interlocuteur {RBX_NAME} n'est plus bâillonné.",
            ["es-es"] = "Se ha cancelado el silencio del usuario \"{RBX_NAME}\".",
            ["zh-cjv"] = "发言者“{RBX_NAME}”已被取消禁言。",
            ["zh-tw"] = "已將使用者「{RBX_NAME}」解除靜音。",
            ru = "Пользователь {RBX_NAME} удален из списка игнорируемых.",
            ["zh-cn"] = "发言者“{RBX_NAME}”已被取消禁言。",
            de = "Stummschaltung von Sprecher:in „{RBX_NAME}“ wurde aufgehoben.",
            ko = "스피커 '%s'의 음소거가 해제되었어요.",
            ["pt-br"] = "O silêncio de '%s' foi removido.",
            pt = "O silêncio de '%s' foi removido.",
            ["en-us"] = "Speaker '%s' has been unmuted.",
            it = "Hai restituito la parola al giocatore \"{RBX_NAME}\"."
        }
    },
    {
        Key = "GameChat_ChatMessageValidator_MaxLengthError",
        Values = {
            es = "Tu mensaje supera la longitud máxima permitida.",
            ja = "メッセージが最大文字数を超えています。",
            fr = "Votre message dépasse la longueur maximale.",
            ["es-es"] = "Tu mensaje supera la longitud máxima permitida.",
            ["zh-cjv"] = "你的消息已超过最大长度限制。",
            ["zh-tw"] = "您的訊息超過長度限制。",
            ru = "Превышено максимально допустимое количество символов в сообщении.",
            ["zh-cn"] = "你的消息已超过最大长度限制。",
            de = "Deine Nachricht überschreitet die zulässige Nachrichtenlänge.",
            ko = "메시지 길이 한도를 초과했어요.",
            ["pt-br"] = "Sua mensagem ultrapassa o tamanho máximo de mensagem.",
            pt = "Sua mensagem ultrapassa o tamanho máximo de mensagem.",
            ["en-us"] = "Your message exceeds the maximum message length.",
            it = "Il tuo messaggio supera la lunghezza massima consentita."
        }
    },
    {
        Key = "GameChat_ChatMessageValidator_SettingsError",
        Values = {
            es = "Tu configuración de chat te impide enviar mensajes.",
            ja = "メッセージが送れないチャット設定です。",
            fr = "Vos paramètres de chat vous empêchent d'envoyer des messages.",
            ["es-es"] = "Tu configuración de chat te impide enviar mensajes.",
            ["zh-cjv"] = "你的聊天设置禁止你发送消息。",
            ["zh-tw"] = "您的聊天設定禁止您傳送訊息。",
            ru = "В ваших настройках чата заблокирована возможность отправлять сообщения.",
            ["zh-cn"] = "你的聊天设置禁止你发送消息。",
            de = "Aufgrund deiner Chateinstellungen kannst du keine Nachrichten senden.",
            ko = "채팅 설정 때문에 메시지를 보낼 수 없어요.",
            ["pt-br"] = "Suas configurações de chat impedem que você envie mensagens.",
            pt = "Suas configurações de chat impedem que você envie mensagens.",
            ["en-us"] = "Your chat settings prevent you from sending messages.",
            it = "Non puoi inviare messaggi per le impostazioni della tua chat."
        }
    },
    {
        Key = "GameChat_ChatMessageValidator_WhitespaceError",
        Values = {
            es = "Tu mensaje contiene espacios vacíos que no se permiten.",
            ja = "メッセージに許可されていないスペースが含まれています。",
            fr = "Votre message contient des espaces blancs qui sont interdits.",
            ["es-es"] = "Tu mensaje contiene espacios vacíos que no se permiten.",
            ["zh-cjv"] = "你的消息包含不被允许的空格。",
            ["zh-tw"] = "訊息禁止使用空白字元。",
            ru = "Ваше сообщение содержит недопустимый пробел.",
            ["zh-cn"] = "你的消息包含不被允许的空格。",
            de = "Deine Nachricht enthält unzulässige Leerräume.",
            ko = "메시지에 허용되지 않는 여백이 있어요.",
            ["pt-br"] = "Sua mensagem contém um espaço em branco, que não é permitido.",
            pt = "Sua mensagem contém um espaço em branco, que não é permitido.",
            ["en-us"] = "Your message contains whitespace that is not allowed.",
            it = "Il tuo messaggio contiene spazi vuoti non consentiti."
        }
    },
    {
        Key = "GameChat_ChatServiceRunner_ChannelDoesNotExist",
        Values = {
            es = "El canal {RBX_NAME} no existe.",
            ja = "チャンネル {RBX_NAME} は存在しません。",
            fr = "Le canal {RBX_NAME} n'existe pas.",
            ["es-es"] = "El canal {RBX_NAME} no existe.",
            ["zh-cjv"] = "频道“{RBX_NAME}”不存在。",
            ["zh-tw"] = "頻道「{RBX_NAME}」不存在。",
            ru = "Канала «{RBX_NAME}» не существует.",
            ["zh-cn"] = "频道“{RBX_NAME}”不存在。",
            de = "Kanal „{RBX_NAME}“ existiert nicht.",
            ko = "{RBX_NAME} 채널이 없어요.",
            ["pt-br"] = "O canal {RBX_NAME} não existe.",
            pt = "O canal {RBX_NAME} não existe.",
            ["en-us"] = "Channel {RBX_NAME} does not exist.",
            it = "Il canale {RBX_NAME} non esiste."
        }
    },
    {
        Key = "GameChat_ChatServiceRunner_SystemChannelWelcomeMessage",
        Values = {
            es = "Este canal es para notificaciones del sistema y del juego.",
            ja = "このチャンネルはシステムとゲーム通知のためのものです。",
            fr = "Ce canal est réservé aux notifications système et de jeu.",
            ["es-es"] = "Este canal es para notificaciones del sistema y del juego.",
            ["zh-cjv"] = "此频道用于发送系统及挑战通知。",
            ["zh-tw"] = "此頻道為系統及遊戲通知專用。",
            ru = "Этот канал предназначен для системных и игровых уведомлений.",
            ["zh-cn"] = "此频道用于发送系统及游戏通知。",
            de = "Dieser Kanal ist für System- und Spielbenachrichtigungen.",
            ko = "이 채널은 시스템 및 게임 알림용이에요.",
            ["pt-br"] = "Este canal é destinado a notificações do sistema e jogo.",
            pt = "Este canal é destinado a notificações do sistema e jogo.",
            ["en-us"] = "This channel is for system and experience notifications.",
            it = "Questo canale è per le notifiche di gioco e del sistema."
        }
    },
    {
        Key = "GameChat_ChatServiceRunner_YouAreNotInChannel",
        Values = {
            es = "No estás en el canal {RBX_NAME}.",
            ja = "あなたはチャンネル {RBX_NAME} にいません。",
            fr = "Vous n'êtes pas sur le canal {RBX_NAME}",
            ["es-es"] = "No estás en el canal {RBX_NAME}.",
            ["zh-cjv"] = "你不在频道“{RBX_NAME}”",
            ["zh-tw"] = "您不在 {RBX_NAME} 頻道",
            ru = "Вы не на канале «{RBX_NAME}»",
            ["zh-cn"] = "你不在频道“{RBX_NAME}”",
            de = "Du befindest dich nicht in Kanal „{RBX_NAME}“.",
            ko = "{RBX_NAME} 채널에 있지 않아요",
            ["pt-br"] = "Você não está no canal {RBX_NAME}",
            pt = "Você não está no canal {RBX_NAME}",
            ["en-us"] = "You are not in channel {RBX_NAME}",
            it = "Non ti trovi nel canale {RBX_NAME}"
        }
    },
    {
        Key = "GameChat_ChatServiceRunner_YouCannotJoinChannel",
        Values = {
            es = "No puedes unirte al canal {RBX_NAME}.",
            ja = "チャンネル {RBX_NAME} に参加することは出来ません。",
            fr = "Vous ne pouvez pas rejoindre le canal {RBX_NAME}",
            ["es-es"] = "No puedes unirte al canal {RBX_NAME}.",
            ["zh-cjv"] = "你无法加入频道“{RBX_NAME}”",
            ["zh-tw"] = "您無法加入{RBX_NAME} 頻道",
            ru = "Вы не можете подключиться к каналу «{RBX_NAME}»",
            ["zh-cn"] = "你无法加入频道“{RBX_NAME}”",
            de = "Du kannst Kanal „{RBX_NAME}“ nicht beitreten.",
            ko = "{RBX_NAME} 채널에 가입할 수 없어요",
            ["pt-br"] = "Você não pode entrar no canal {RBX_NAME}",
            pt = "Você não pode entrar no canal {RBX_NAME}",
            ["en-us"] = "You cannot join channel {RBX_NAME}",
            it = "Non puoi accedere al canale {RBX_NAME}"
        }
    },
    {
        Key = "GameChat_ChatServiceRunner_YouCannotLeaveChannel",
        Values = {
            es = "No puedes salir del canal {RBX_NAME}.",
            ja = "チャンネル {RBX_NAME} を終了できません。",
            fr = "Vous ne pouvez pas quitter le canal {RBX_NAME}",
            ["es-es"] = "No puedes salir del canal {RBX_NAME}.",
            ["zh-cjv"] = "你无法离开频道“{RBX_NAME}”",
            ["zh-tw"] = "您無法離開 {RBX_NAME} 頻道",
            ru = "Вы не можете покинуть канал «{RBX_NAME}».",
            ["zh-cn"] = "你无法离开频道“{RBX_NAME}”",
            de = "Du kannst Kanal „{RBX_NAME}“ nicht verlassen.",
            ko = "{RBX_NAME} 채널에서 나갈 수 없어요",
            ["pt-br"] = "Você não pode sair do canal {RBX_NAME}",
            pt = "Você não pode sair do canal {RBX_NAME}",
            ["en-us"] = "You cannot leave channel {RBX_NAME}",
            it = "Non puoi lasciare il canale {RBX_NAME}"
        }
    },
    {
        Key = "GameChat_ChatService_CannotLeaveChannel",
        Values = {
            es = "No puedes salir de este canal.",
            ja = "このチャンネルを終了できません。",
            fr = "Vous ne pouvez pas quitter ce canal.",
            ["es-es"] = "No puedes salir de este canal.",
            ["zh-cjv"] = "你无法离开此频道。",
            ["zh-tw"] = "您無法離開此頻道。",
            ru = "Вы не можете покинуть этот канал.",
            ["zh-cn"] = "你无法离开此频道。",
            de = "Du kannst diesen Kanal nicht verlassen.",
            ko = "채널에서 나갈 수 없어요.",
            ["pt-br"] = "Você não pode sair deste canal.",
            pt = "Você não pode sair deste canal.",
            ["en-us"] = "You cannot leave this channel.",
            it = "Non puoi lasciare questo canale."
        }
    },
    {
        Key = "GameChat_ChatService_ChatFilterIssues",
        Values = {
            es = "El filtro del chat sufre problemas en este momento y es posible que los mensajes tarden un poco en aparecer.",
            ja = "現在、チャットフィルターに問題があるためメッセージの表示が遅れています。",
            fr = "Le filtre de chat connaît actuellement des problèmes et les messages pourraient mettre du temps à apparaître.",
            ["es-es"] = "El filtro del chat sufre problemas en este momento y es posible que los mensajes tarden un poco en aparecer.",
            ["zh-cjv"] = "聊天过滤器当前遇到问题，消息显示可能出现延迟。",
            ["zh-tw"] = "文字過濾系統發生問題，訊息可能會延遲顯示。",
            ru = "Могут возникать задержки в передаче сообщений из-за проблем с фильтром чата.",
            ["zh-cn"] = "聊天过滤器当前遇到问题，消息显示可能出现延迟。",
            de = "Es gibt derzeit Probleme mit dem Chatfilter. Nachrichten können deshalb mit Verzögerung angezeigt werden.",
            ko = "현재 채팅 필터에 문제가 있어 메시지 표시가 느릴 수 있어요.",
            ["pt-br"] = "O filtro de chat está com problemas no momento e as mensagens podem demorar para aparecer.",
            pt = "O filtro de chat está com problemas no momento e as mensagens podem demorar para aparecer.",
            ["en-us"] = "The chat filter is currently experiencing issues and messages may be slow to appear.",
            it = "Il filtro della chat sta riscontrando dei problemi e i messaggi potrebbero apparire in ritardo."
        }
    },
    {
        Key = "GameChat_ChatService_YouHaveLeftChannel",
        Values = {
            es = "Has salido del canal \"{RBX_NAME}\".",
            ja = "チャンネル 「{RBX_NAME}」を退出しました。",
            fr = "Vous avez quitté le canal {RBX_NAME}",
            ["es-es"] = "Has salido del canal \"{RBX_NAME}\".",
            ["zh-cjv"] = "你已离开频道“{RBX_NAME}”",
            ["zh-tw"] = "您已離開「{RBX_NAME}」頻道",
            ru = "Вы покинули канал «{RBX_NAME}»",
            ["zh-cn"] = "你已离开频道“{RBX_NAME}”",
            de = "Du hast Kanal „{RBX_NAME}“ verlassen.",
            ko = "{RBX_NAME}' 채널에서 나왔어요",
            ["pt-br"] = "Você saiu do canal '%s'",
            pt = "Você saiu do canal '%s'",
            ["en-us"] = "You have left channel '%s'",
            it = "Hai lasciato il canale \"{RBX_NAME}\""
        }
    },
    {
        Key = "GameChat_DoMuteCommand_CannotMuteSelf",
        Values = {
            es = "No puedes silenciarte a ti mismo.",
            ja = "自分をミュートすることは出来ません。",
            fr = "Vous ne pouvez pas vous bâillonner.",
            ["es-es"] = "No puedes silenciarte a ti mismo.",
            ["zh-cjv"] = "你无法将自己禁言。",
            ["zh-tw"] = "您無法將自己靜音。",
            ru = "Невозможно добавить себя в список игнорируемых.",
            ["zh-cn"] = "你无法将自己禁言。",
            de = "Du kannst dich nicht selbst stummschalten.",
            ko = "자신을 음소거할 수 없어요.",
            ["pt-br"] = "Você não pode silenciar a si mesmo.",
            pt = "Você não pode silenciar a si mesmo.",
            ["en-us"] = "You cannot mute yourself.",
            it = "Non puoi togliere la parola a te stesso."
        }
    },
    {
        Key = "GameChat_FriendChatNotifier_JoinMessage",
		Values = {
			es = "Tu amigo %s se ha unido al juego.",
			ja = "あなたの友人、%s さんがゲームに参加しました。",
			fr = "Votre ami %s a rejoint le jeu.",
			["es-es"] = "Tu amigo %s se ha unido al juego.",
			["zh-cjv"] = "你的朋友“%s”已加入挑战。",
			["zh-tw"] = "您的好友 %s 已加入遊戲。",
			ru = "Ваш друг %s присоединился к игре.",
			["zh-cn"] = "你的朋友“%s”已加入游戏。",
			de = "Dein:e Freund:in %s ist dem Spiel beigetreten.",
			ko = "친구 %s님이 게임에 참가했어요.",
			["pt-br"] = "Seu amigo %s juntou-se ao jogo.",
			pt = "Seu amigo %s juntou-se ao jogo.",
			["en-us"] = "Your friend %s has joined the experience.",
			it = "Il tuo amico %s è entrato nel gioco."
		}
    },
    {
        Key = "GameChat_GetVersion_Message",
        Values = {
            es = "Este juego utiliza la versión del chat [{1:int} {1:int}].",
            ja = "このゲームはチャットバージョン [{1:int}.{2:int}]を実行しています。",
            fr = "Le jeu utilise la version de chat [{1:int} {1:int}].",
            ["es-es"] = "Este juego utiliza la versión del chat [{1:int} {1:int}].",
            ["zh-cjv"] = "此挑战正在运行聊天版本 [{1:int}.{2:int}]。",
            ["zh-tw"] = "此遊戲正在使用聊天室版本 [{1:int}.{2:int}]。",
            ru = "Эта игра поддерживает чат версии [{1:int}.{2:int}].",
            ["zh-cn"] = "此游戏正在运行聊天版本 [{1:int}.{2:int}]。",
            de = "Die Chatversion dieses Spiels ist [{1:int}.{2:int}].",
            ko = "이 게임은 채팅 버전 [{1:int}. {1:int}]을(를) 실행합니다.",
            ["pt-br"] = "Este jogo está rodando a versão de chat [{1:int}.{2:int}].",
            pt = "Este jogo está rodando a versão de chat [{1:int}.{2:int}].",
            ["en-us"] = "This experience is running chat version [{1:int}.{2:int}].",
            it = "Questo gioco usa la versione [{1:int}.{2:int}] della chat."
        }
    },
    {
        Key = "GameChat_MuteSpeaker_SpeakerDoesNotExist",
        Values = {
            es = "El usuario \"{RBX_NAME}\" no existe.",
            ja = "「{RBX_NAME}」は存在しません。",
            fr = "L'interlocuteur {RBX_NAME} n'existe pas.",
            ["es-es"] = "El usuario \"{RBX_NAME}\" no existe.",
            ["zh-cjv"] = "发言者“{RBX_NAME}”不存在。",
            ["zh-tw"] = "使用者「{RBX_NAME}」不存在。",
            ru = "Пользователя {RBX_NAME} не существует.",
            ["zh-cn"] = "发言者“{RBX_NAME}”不存在。",
            de = "Sprecher:in „{RBX_NAME}“ existiert nicht.",
            ko = "스피커 '%s'이(가) 없어요.",
            ["pt-br"] = "'%s' não existe.",
            pt = "'%s' não existe.",
            ["en-us"] = "Speaker '%s' does not exist.",
            it = "Il giocatore \"{RBX_NAME}\" non esiste."
        }
    },
    {
        Key = "GameChat_PrivateMessaging_CannotChat",
        Values = {
            es = "No puedes chatear con este jugador.",
            ja = "このプレイヤーとチャットすることは出来ません。",
            fr = "Vous ne pouvez pas discuter avec ce joueur.",
            ["es-es"] = "No puedes chatear con este jugador.",
            ["zh-cjv"] = "你无法与此玩家聊天。",
            ["zh-tw"] = "您無法與此玩家聊天。",
            ru = "Вы не можете общаться в чате с этим игроком.",
            ["zh-cn"] = "你无法与此玩家聊天。",
            de = "Du kannst mit diesem Spieler bzw. dieser Spielerin nicht chatten.",
            ko = "이 플레이어와 채팅할 수 없어요.",
            ["pt-br"] = "Você não pode participar de chat com este jogador.",
            pt = "Você não pode participar de chat com este jogador.",
            ["en-us"] = "You are not able to chat with this person.",
            it = "Non puoi chattare con questo giocatore."
        }
    },
    {
        Key = "GameChat_PrivateMessaging_CannotWhisperToSelf",
        Values = {
            es = "No puedes enviarte mensajes privados a ti mismo.",
            ja = "自分自身に話しかけることは出来ません。",
            fr = "Vous ne pouvez pas murmurer à votre propre oreille.",
            ["es-es"] = "No puedes enviarte mensajes privados a ti mismo.",
            ["zh-cjv"] = "你无法与自己开启私人频道。",
            ["zh-tw"] = "您無法與自己開啟私人頻道。",
            ru = "Нельзя отправлять себе личные сообщения.",
            ["zh-cn"] = "你无法与自己开启私人频道。",
            de = "Du kannst dir nicht selbst etwas zuflüstern.",
            ko = "자신에게 귓속말할 수 없어요.",
            ["pt-br"] = "Você não pode sussurrar para si mesmo.",
            pt = "Você não pode sussurrar para si mesmo.",
            ["en-us"] = "You cannot whisper to yourself.",
            it = "Non puoi aprire un canale privato con te stesso."
        }
    },
    {
        Key = "GameChat_PrivateMessaging_NowChattingWith",
        Values = {
            es = "Estás chateando en privado con {RBX_NAME}.",
            ja = "あなたは現在、{RBX_NAME} さんとプライベートチャット中です。",
            fr = "Maintenant, vous discutez en privé avec {RBX_NAME}",
            ["es-es"] = "Estás chateando en privado con {RBX_NAME}.",
            ["zh-cjv"] = "你正在与“{RBX_NAME}”私聊",
            ["zh-tw"] = "您正在與{RBX_NAME}私聊",
            ru = "Открыт канал для личного общения с пользователем {RBX_NAME}",
            ["zh-cn"] = "你正在与“{RBX_NAME}”私聊",
            de = "Du unterhältst dich nun privat mit {RBX_NAME}.",
            ko = "현재 {RBX_NAME}님과 비공개 채팅 중이에요",
            ["pt-br"] = "Você agora está em um chat privado com {RBX_NAME}",
            pt = "Você agora está em um chat privado com {RBX_NAME}",
            ["en-us"] = "You are now privately chatting with {RBX_NAME}",
            it = "Ora stai chattando in privato con {RBX_NAME}"
        }
    },
    {
        Key = "GameChat_SwallowGuestChat_Message",
        Values = {
            es = "¡Crea una cuenta gratuita para obtener los permisos de acceso al chat!",
            ja = "フリーアカウントを作ってチャット権限にアクセス！",
            fr = "Créez un compte gratuit pour accéder aux permissions de chat !",
            ["es-es"] = "¡Crea una cuenta gratuita para obtener los permisos de acceso al chat!",
            ["zh-cjv"] = "创建免费帐户以获取聊天权限！",
            ["zh-tw"] = "若要使用聊天功能，請建立免費帳號。",
            ru = "Создайте бесплатную учетную запись, чтобы настроить права доступа в чате!",
            ["zh-cn"] = "创建免费帐户以获取聊天权限！",
            de = "Erstelle ein kostenloses Konto, um Zugriff auf Chatberechtigungen zu erhalten!",
            ko = "무료 계정을 생성해 채팅 권한을 이용하세요!",
            ["pt-br"] = "Crie uma conta grátis para ter acesso a permissões de chat!",
            pt = "Crie uma conta grátis para ter acesso a permissões de chat!",
            ["en-us"] = "Create a free account to get access to chat permissions!",
            it = "Crea un account gratuito per avere accesso ai permessi della chat!"
        }
    },
    {
        Key = "GameChat_SwitchChannel_NotInChannel",
        Values = {
            es = "No estás en el canal \"{RBX_NAME}\".",
            ja = "あなたはチャネル: 「{RBX_NAME}」にいません。",
            fr = "Vous n'êtes pas sur le canal : {RBX_NAME}",
            ["es-es"] = "No estás en el canal \"{RBX_NAME}\".",
            ["zh-cjv"] = "你不在频道：“{RBX_NAME}”",
            ["zh-tw"] = "您不在「{RBX_NAME}」頻道",
            ru = "Вы не на канале «{RBX_NAME}»",
            ["zh-cn"] = "你不在频道：“{RBX_NAME}”",
            de = "Du befindest dich nicht in Kanal „{RBX_NAME}“.",
            ko = "{RBX_NAME}' 채널에 있지 않아요",
            ["pt-br"] = "Você não está no canal: '%s'",
            pt = "Você não está no canal: '%s'",
            ["en-us"] = "You are not in channel: '%s'",
            it = "Non ti trovi nel canale: \"{RBX_NAME}\""
        }
    },
    {
        Key = "GameChat_SwitchChannel_NowInChannel",
        Values = {
            es = "Estás chateando en el canal \"{RBX_NAME}\".",
            ja = "あなたの現在のチャットチャンネルは: 「{RBX_NAME}」です。",
            fr = "Maintenant, vous discutez sur le canal : {RBX_NAME}",
            ["es-es"] = "Estás chateando en el canal \"{RBX_NAME}\".",
            ["zh-cjv"] = "你当前的聊天频道为：“{RBX_NAME}”",
            ["zh-tw"] = "您目前在「{RBX_NAME}」頻道聊天",
            ru = "Вы общаетесь на канале «{RBX_NAME}»",
            ["zh-cn"] = "你当前的聊天频道为：“{RBX_NAME}”",
            de = "Du chattest jetzt in Kanal „{RBX_NAME}“.",
            ko = "'%s' 채널에서 채팅 중이에요",
            ["pt-br"] = "Você agora está no canal de chat: '%s'",
            pt = "Você agora está no canal de chat: '%s'",
            ["en-us"] = "You are now chatting in channel: '%s'",
            it = "Ora stai parlando nel canale: \"{RBX_NAME}\""
        }
    },
    {
        Key = "GameChat_TeamChat_CannotTeamChatIfNotInTeam",
        Values = {
            es = "¡No puedes chatear con tu equipo si no formas parte de un equipo!",
            ja = "チームに所属していなければチームチャットは出来ません。",
            fr = "Vous ne pouvez pas avoir de discussion d'équipe si vous n'appartenez pas à une équipe !",
            ["es-es"] = "¡No puedes chatear con tu equipo si no formas parte de un equipo!",
            ["zh-cjv"] = "如果你不在该团队，则无法进行团队聊天。",
            ["zh-tw"] = "若您不在隊伍中，您無法使用隊伍頻道。",
            ru = "Вы не можете общаться в командном чате, если не состоите в команде!",
            ["zh-cn"] = "如果你不在该团队，则无法进行团队聊天。",
            de = "Teamchat ist nur verfügbar, wenn du Mitglied eines Teams bist!",
            ko = "팀에 속하지 않으면 팀 채팅을 이용할 수 없어요!",
            ["pt-br"] = "Você não pode participar de chat de equipe se não estiver em uma!",
            pt = "Você não pode participar de chat de equipe se não estiver em uma!",
            ["en-us"] = "You cannot team chat if you are not on a team!",
            it = "Non puoi chattare con la squadra se non sei in una squadra!"
        }
    },
    {
        Key = "GameChat_TeamChat_NowInTeam",
        Values = {
            es = "Ahora formas parte del equipo \"%s\".",
            ja = "あなたは現在「{RBX_NAME}」チームに所属しています。",
            fr = "Vous êtes désormais dans l'équipe %s.",
            ["es-es"] = "Ahora formas parte del equipo \"%s\".",
            ["zh-cjv"] = "你正在团队“%s”中。",
            ["zh-tw"] = "您在「%s」隊伍。",
            ru = "Вы вступили в команду %s.",
            ["zh-cn"] = "你正在团队“%s”中。",
            de = "Du bist nun Mitglied im Team „%s“.",
            ko = "현재 '%s'팀에 속해 있어요.",
            ["pt-br"] = "Você agora está na equipe '%s'.",
            pt = "Você agora está na equipe '%s'.",
            ["en-us"] = "You are now on the '%s' team.",
            it = "Ora sei nella squadra \"%s\"."
        }
    },
    {
        Key = "GameChat_TeamChat_WelcomeMessage",
        Values = {
            es = "Este es un canal privado entre tú y los miembros de tu equipo.",
            ja = "これはあなたとあなたのチームメンバーとのプライベートチャンネルです。",
            fr = "Ceci est un canal privé entre les membres de votre équipe et vous.",
            ["es-es"] = "Este es un canal privado entre tú y los miembros de tu equipo.",
            ["zh-cjv"] = "这是你与团队成员之间的私人频道。",
            ["zh-tw"] = "這是您與隊伍成員的私人頻道。",
            ru = "Это канал для личного общения участников вашей команды.",
            ["zh-cn"] = "这是你与团队成员之间的私人频道。",
            de = "Dies ist ein privater Kanal für dich und deine Teammitglieder.",
            ko = "회원님과 팀원 간의 비공개 채널이에요.",
            ["pt-br"] = "Este é um canal privado entre você e os membros da sua equipe.",
            pt = "Este é um canal privado entre você e os membros da sua equipe.",
            ["en-us"] = "This is a private channel between you and your team members.",
            it = "Questo è un canale privato tra te e i membri della tua squadra."
        }
    },
    {
        Key = "InGame.Chat.ErrorMessageAnimationPlaying",
        Values = {
            es = "No puedes usar los emotes durante esta acción.",
            ja = "この動作中はエモートを表示できません。",
            fr = "Tu ne peux pas jouer à Emotes pendant cette action.",
            ["es-es"] = "No puedes usar los emotes durante esta acción.",
            ["zh-tw"] = "無法在此動作執行時使用其他動作。",
            ["zh-cjv"] = "无法在此动作进行时使用其他动作。",
            ["zh-cn"] = "无法在此动作进行时使用其他动作。",
            de = "Du kannst das Emote während dieser Aktion nicht abspielen.",
            ko = "이 동작 중에는 감정 표현을 적용할 수 없습니다.",
            ["pt-br"] = "Você não pode usar emotes durante esta ação.",
            pt = "Você não pode usar emotes durante esta ação.",
            ["en-us"] = "You cannot play Emotes during this action.",
            it = "Non puoi giocare Emote durante questa azione."
        }
    },
    {
        Key = "InGame.Chat.ErrorMessageSwitchToR15",
        Values = {
            es = "Cambia tu avatar a R15 para usar los emotes.",
            ja = "エモートを表示するにはR15アバターに切り替えてください。",
            fr = "Passe à ton avatar R15 pour jouer à Emote.",
            ["es-es"] = "Cambia tu avatar a R15 para usar los emotes.",
            ["zh-tw"] = "切換成 R15 虛擬人偶即可使用此動作。",
            ["zh-cjv"] = "切换成 R15 虚拟形象以使用此动作。",
            ["zh-cn"] = "切换成 R15 虚拟形象以使用此动作。",
            de = "Wechsle zu deinem R15-Avatar, um das Emote abzuspielen.",
            ko = "감정 표현을 적용하려면 R15 아바타로 전환하세요.",
            ["pt-br"] = "Mude seu avatar para o modelo R15 para usar emotes.",
            pt = "Mude seu avatar para o modelo R15 para usar emotes.",
            ["en-us"] = "Switch to your R15 avatar to play Emote.",
            it = "Passa al tuo avatar R15 per giocare a Emote."
        }
    },
    {
        Key = "InGame.Chat.Label.From",
        Values = {
            es = "De",
            ja = "から",
            fr = "De",
            ["es-es"] = "De",
            ["zh-cjv"] = "来自于",
            ["zh-tw"] = "自",
            ru = "От ",
            ["zh-cn"] = "来自于",
            de = "Von",
            ko = "발신:",
            ["pt-br"] = "De",
            pt = "De",
            ["en-us"] = "From",
            it = "Da"
        }
    },
    {
        Key = "InGame.Chat.Label.SystemMessagePrefix",
        Values = {
            es = "Sistema",
            ja = "システム",
            fr = "Système",
            ["es-es"] = "Sistema",
            ["zh-cjv"] = "系统",
            ["zh-tw"] = "系統",
            ru = "Система",
            ["zh-cn"] = "系统",
            de = "System",
            ko = "시스템",
            ["pt-br"] = "Sistema",
            pt = "Sistema",
            ["en-us"] = "System",
            it = "Sistema"
        }
    },
    {
        Key = "InGame.Chat.Label.TeamMessagePrefix",
        Values = {
            es = "Equipo",
            ja = "チーム",
            fr = "Équipe",
            ["es-es"] = "Equipo",
            ["zh-cjv"] = "队伍",
            ["zh-tw"] = "隊伍",
            ru = "Команда",
            ["zh-cn"] = "队伍",
            de = "Team",
            ko = "팀",
            ["pt-br"] = "Equipe",
            pt = "Equipe",
            ["en-us"] = "Team",
            it = "Squadra"
        }
    },
    {
        Key = "InGame.Chat.Label.To",
        Values = {
            es = "Para",
            ja = "へ",
            fr = "À",
            ["es-es"] = "Para",
            ["zh-cjv"] = "发送至",
            ["zh-tw"] = "對",
            ru = "Для",
            ["zh-cn"] = "发送至",
            de = "Bis",
            ko = "수신:",
            ["pt-br"] = "Para",
            pt = "Para",
            ["en-us"] = "To",
            it = "A"
        }
    },
    {
        Key = "InGame.Chat.Response.DisplayNameMultipleMatches",
        Values = {
            es = "Advertencia: Los siguientes jugadores tienen este nombre de usuario: ",
            ja = "警告: 以下のユーザーには、この表示名があります: ",
            fr = "Avertissement - Les utilisateurs suivants ont ce nom d'affichage : ",
            ["es-es"] = "Advertencia: Los siguientes jugadores tienen este nombre de usuario: ",
            ["zh-cjv"] = "注意：以下用户正在使用此昵称：",
            ["zh-tw"] = "注意：以下使用者正在使用此顯示名稱：",
            ru = "Внимание! Такое имя есть у нескольких пользователей: ",
            ["zh-cn"] = "注意：以下用户正在使用此昵称：",
            de = "Warnung: Die folgenden Benutzer:innen haben diesen angezeigten Namen: ",
            ko = "주의: 다음 사용자들이 이 표시 이름을 사용하고 있습니다.",
            ["pt-br"] = "Aviso! Os seguintes usuários têm esse nome de exibição: ",
            pt = "Aviso! Os seguintes usuários têm esse nome de exibição: ",
            ["en-us"] = "Warning: The following users have this display name: ",
            it = "Attenzione, i seguenti utenti hanno questo nome: "
        }
    },
    {
        Key = "InGame.Chat.Response.EmoteNotAvailable",
        Values = {
            es = "No puedes usar ese emoticono.",
            ja = "そのエモートは使えません。",
            fr = "Tu ne peux pas utiliser cette Emote.",
            ["es-es"] = "No puedes usar ese emoticono.",
            ["zh-cjv"] = "无法使用该动作。",
            ["zh-tw"] = "無法使用該動作。",
            ru = "Вы не можете использовать эту эмоцию.",
            ["zh-cn"] = "无法使用该动作。",
            de = "Du kannst dieses Emote nicht benutzen.",
            ko = "이 감정 표현은 사용할 수 없어요.",
            ["pt-br"] = "Você não pode usar esse emote.",
            pt = "Você não pode usar esse emote.",
            ["en-us"] = "You can't use that Emote.",
            it = "Non puoi usare quell'emoticon."
        }
    },
    {
        Key = "InGame.Chat.Response.EmotesNotSupported",
        Values = {
            es = "No puedes usar emoticonos aquí.",
            ja = "ここではエモートはここでは使えません。",
            fr = "Tu ne peux pas utiliser les Emotes ici.",
            ["es-es"] = "No puedes usar emoticonos aquí.",
            ["zh-cjv"] = "无法在此挑战中使用动作。",
            ["zh-tw"] = "無法在此遊戲使用動作。",
            ru = "Здесь нельзя использовать эмоции.",
            ["zh-cn"] = "无法在此游戏中使用动作。",
            de = "Du kannst hier keine Emotes verwenden.",
            ko = "여기서는 감정 표현을 사용할 수 없어요.",
            ["pt-br"] = "Você não pode usar emotes aqui.",
            pt = "Você não pode usar emotes aqui.",
            ["en-us"] = "You can't use Emotes here.",
            it = "Qui non puoi usare le emoticon."
        }
    },
    {
        Key = "InGame.Chat.Response.EmotesTemporarilyUnavailable",
        Values = {
            es = "No puedes usar emoticonos en este momento.",
            ja = "今はエモートを使えません。",
            fr = "Tu ne peux pas utiliser d'Emote maintenant.",
            ["es-es"] = "No puedes usar emoticonos en este momento.",
            ["zh-cjv"] = "当前无法使用动作。",
            ["zh-tw"] = "現在無法使用動作。",
            ru = "Вы не можете использовать эмоции прямо сейчас.",
            ["zh-cn"] = "当前无法使用动作。",
            de = "You can't use Emotes right now.",
            ko = "지금은 감정 표현을 사용할 수 없어요.",
            ["pt-br"] = "Você não pode usar emotes no momento.",
            pt = "Você não pode usar emotes no momento.",
            ["en-us"] = "You can't use Emotes right now.",
            it = "Adesso non puoi usare le emoticon."
        }
    },
    {
        Key = "InGame.Chat.Response.EmotesWrongAvatarType",
        Values = {
            es = "Solo los avatares R15 pueden usar emoticonos.",
            ja = "R15指定のアバターのみエモートを使えます。",
            fr = "Seuls les avatars R15 peuvent utiliser les Emotes.",
            ["es-es"] = "Solo los avatares R15 pueden usar emoticonos.",
            ["zh-cjv"] = "只有 R15 虚拟形象可以使用动作。",
            ["zh-tw"] = "只有 R15 虛擬人偶可以使用動作。",
            ru = "Только аватары R15 могут использовать эмоции.",
            ["zh-cn"] = "只有 R15 虚拟形象可以使用动作。",
            de = "Nur R15 Avatars können Emotes verwenden.",
            ko = "R15 아바타만 감정 표현을 사용할 수 있어요.",
            ["pt-br"] = "Apenas avatares R15 podem usar emotes.",
            pt = "Apenas avatares R15 podem usar emotes.",
            ["en-us"] = "Only R15 avatars can use Emotes.",
            it = "Solo gli avatar R15 possono usare le emoticon."
        }
    }
}

return function()
	local localizationTable = Instance.new("LocalizationTable")
	localizationTable.Name = "ChatLocalization"
	localizationTable:SetEntries(entries)
	return localizationTable,entries
end