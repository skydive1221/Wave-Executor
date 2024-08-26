--[[

  ___      _   _              ___ _         _         ____
 | _ ) ___| |_| |_ ___ _ _   / __| |_  __ _| |_  __ _|__ /
 | _ \/ -_)  _|  _/ -_) '_| | (__| ' \/ _` |  _| \ V /|_ \
 |___/\___|\__|\__\___|_|    \___|_||_\__,_|\__|  \_/|___/
 
Created by: @Jumpathy

Credits:
@Xsitsu - A few of the original chat functions such as user chat colors and chat cooldowns.
@qwreey74 - High quality material icons
@Blockzez - Hex color encode / decode functions
@boatbomber - Textbox+'s undo/redo system code concept
@boatbomber - Image masking for some user thumbnails
@ForeverHD - Topbar+
@Fm_Trick - Slider math help via public resource
@McThor2 - Math help for bubble chat
@sleitnick - Raycasting code for bubble chat
@alexinite - Contributing bug fixes and helping people in replies with their issues

]]

return {
	Permissions = {
		Ranks = { 
			--[[
				Ranks are like permissions for the chat, we can assign things 
				like editing message access to them if you don't want regular users
				to have those. They're not admin-commands, I've just named them in this
				manner to understand more effectively.
			--]]

			[1] = "Guest", --> Rank ID 1 will automatically be assigned to each user (the config below can determine their final permission level)
			[2] = "VIP",
			[3] = "Admin",
			[4] = "Owner" --> Automatically assigned to the group creator or game creator
		},
		Users = {
			[1] = "Admin", --> Roblox -> Admin rank
		},
		Groups = {
			[1200769] = { --> Roblox admins get the admin rank automatically
				[71] = "Admin"
			}
		},
		Gamepasses = {
			[0] = "VIP" --> Gamepass 0 --> VIP rank
		},
		RobloxPremium = "VIP"
	},
	ChatTags = {
		MaxAmountTags = 10, --> Maximum amount of tags one user can have
		Users = {
			["Roblox"] = { --> Assign Roblox a red 'Owner' tag
				{
					Text = "Owner",
					Color = Color3.fromRGB(255,0,0)
				}
			}
		},
		Ranks = {
			[4] = { --> Assign the owner of the game with the chat a yellow owner tag
				{	
					Text = "Owner",
					Color = Color3.fromRGB(255,255,0),
					Priority = 5 --> If you have a max amount of tags and one user goes over it, the tags with the lowest priority will be removed first.
				}
			}
		}
	},
	TextColors = {
		Ranks = {
			[4] = Color3.fromRGB(255,255,0) --> Assign the owner role a golden text color
		},
		Users = {
			["Roblox"] = Color3.fromRGB(255,0,0) --> Assign Roblox a red chat color
		}
	},
	NameColors = {
		Ranks = {
			[4] = Color3.fromRGB(255,255,0) --> Assign the owner of the game with a yellow name color
		},
		Users = {
			["Roblox"] = Color3.fromRGB(255,0,0) --> Assign Roblox a red username
		}
	},
	UI = {
		ChatSizes = {
			Phone = UDim2.new(0.5,0,0.5,24); --> Chat size on phone
			Tablet = UDim2.new(0.4,0,0.3,24); --> Chat size on tablet
			Desktop = UDim2.new(0.3,0,0.25,24); --> Chat size on desktop
		},
		Fonts = {
			TextFont = Enum.Font.GothamMedium --> Every text's font in the chat
		},
		Colors = {
			SystemPrefixColor = Color3.fromRGB(253,80,111) --> Color of the prefix used for [Team] / [From: user]
		},
		FadeOptions = {
			Window = {
				HoveringTransparency = 0.75, --> Transparency of main window when hovering
				NotHoveringTransparency = 1 --> When not hovering
			},
			Chatbar = { --> Transparency of chatbar, resize button, channel button
				HoveringTransparency = 0,
				NotHoveringTransparency = 1,
				TextColor = { --> Chatbar text color when hovering
					Regular = {
						Hovering = Color3.fromRGB(100,100,100),
						NotHovering = Color3.fromRGB(255,255,255)
					},
					Placeholder = {
						Hovering = Color3.fromRGB(80,80,80),
						NotHovering = Color3.fromRGB(200,200,200)
					}
				}
			}
		},
		ColorOptions = {
			ChatbarColor = Color3.fromRGB(255,255,255),
			Buttons = {
				ResizeButton = { --> UI resize button
					BackgroundColor = Color3.fromRGB(52,52,52),
					IconColor = Color3.fromRGB(255,255,255)
				},
				ChannelButton = { --> Channel bar channel buttons: (also autofill too lol)
					BackgroundColor = Color3.fromRGB(0,0,0),
					TextColor = Color3.fromRGB(255,255,255)
				},
				AutofillButton = { --> Autofill buttons
					BackgroundColor = Color3.fromRGB(30,30,30),
					TextColor = Color3.fromRGB(255,255,255)
				},
				ReplyAndChannel = { --> On the chatbar, when whispering or replying this icon shows up
					BackgroundColor = Color3.fromRGB(253,80,111), --> 253,80,111
					TextAndIconColor = Color3.fromRGB(255,255,255)
				}
			},
			Window = {
				BackgroundColor = Color3.fromRGB(0,0,0),
			}
		},
		ChatWindowVisible = true, --> Is it just the chatbar visible?
		ChannelBarEnabled = true, --> Channel navigation bar at the top of the chat
		SeparateChatbarFromMenu = true, --> Do separate the chat bar from the main UI?
		Resizable = true, --> Can the user resize their chat?
		Rounding = 8, --> UI roundness in px
		BaseTextSize = 16, --> Base text size for the UI
		CornerPosition = "TopLeft" --> Chat corner position (BottomRight, TopLeft, TopRight, BottomLeft)
	},
	User = {
		ChangeDisplayNameColorWhenAttributeChanged = true, --> If you change their DisplayName at run time, will it also automatically update their name color?
		NameColors = { --> Default name colors
			Color3.fromRGB(253,41,67), --> Red
			Color3.fromRGB(1,162,255), --> Blue
			Color3.fromRGB(1,236,111), --> Green
			Color3.fromRGB(174,81,202), --> Purple
			Color3.fromRGB(255,154,76), --> Orange
			Color3.fromRGB(255,211,50), --> Yellow
			Color3.fromRGB(255,205,221), --> Pink
			Color3.fromRGB(255,234,183) --> Beige
		},
		SaveData = { --> Data saving for the options menu (uses ProfileService internally)
			Enabled = true, --> Enable data-saving for these? (Better user-experience if enabled)
			Advanced = { --> Recommend not changing if you don't know what you're doing.
				DatastoreName = "BetterChatV3Data", --> Changing this can reset any existing user data for the chat until you change it back
				HandleOwnData = false --[[
				Create a server addon and register these functions 
					:registerGetProfileFunction(<function:callback>) <plr> (return a table that will save data that's updated in it)
					:registerUnloadProfileFunction(<function:callback>) <plr>
				--]]
			}
		}
	},
	DisplayNames = {
		Enabled = true, --> Are player display names enabled (attribute for the player still works but it's not set initially)
	},
	Teams = {
		TeamColorPriority = true, --> Does team color override their natural chat color?
		TeamChat = true, --> Team chat?
	},
	Notifiers = {
		FriendJoinNotifier = true, --> Notify the user when their friend joins the game?
		TeamChangeNotifier = true, --> Notify the user when their team is changed?
		BlockedUserNotifier = true, --> Place a system message in the chat when a user is blocked?
	},
	Messages = {
		BlacklistEnabled = true, --> Do you want to enact a custom word blacklist?
		BlacklistCanUseDatastores = true, --> Enabling this allows API methods such as :blacklistWord(word <string>,state <bool>) which will save in live time
		BlacklistedWords = {}, --> Will be filtered automatically
		FilterProcessingCharacter = "_", --> What messages are replaced with before being properly filtered and distributed (whilst pending)
		IncludeIcon = true,	--> Display a player thumbnail next to their username in the chat
		UseViewportForIcon = false, --> Use a viewport frame for this? (Helpful for Roleplay games where your avatar isn't the same as it normally would be)
		MaximumLength = 200, --> Maximum allowed message length (> 1000 would probably just brick the chat)
		DisallowedWhitespace = {"\n","\r","\t","\v","\f"}, --> Filter these characters out of the messages to prevent breaking the chat
		ChannelMessageLimit = 100, --> Max amount of messages displayed in a channel at one time
		QuickChat = true, --> Quick chat system enabled?
		Cooldown = { --> This is the chat's antispam system.
			ExpireTimePeriod = 15, --> Maximum message cooldown length
			NumberMessageAllowed = 7 --> Maximum messages allowed in a pre-defined time period
		},
		Private = {
			WhispersEnabled = true --> Private messaging between users
		},
		Extra = {
			DeleteableMessages = "Guest", --> Permission needed to delete messages
			Editable = "Guest", --> Permission needed to edit messages by right clicking / clicking the text (leaves an '(edited)' stamp)
			MarkdownEnabled = "Guest", --> Permission needed to use markdown format, eg: **bold**
			ReplyEnabled = "Guest", --> Permission needed to reply to a message
			MentionEnabled = "Guest", --> Permission needed to mention another user in the chat
			MeCommand = "Guest" --> Permission needed to use the /me command
		},
		Markdown = {
			ItalicBold = true,
			Bold = true,
			Italics = true,
			Underlines = true,
			Strikethrough = true,
			Colored = true,
			Outlines = true,
			Fonts = true
		},
		MessageGrouping = {
			Enabled = true, --> Merge messages when sent by the same user back to back?
			GroupTimeout = 120 --> When do they split back up again?
		},
		CustomEmojis = {
			Enabled = true, --> Enable custom emojis?
			PermissionLocked = false, --> Set to a rank such as "Owner" to enable custom emojis for specific users only
			ScaleType = Enum.ScaleType.Fit, --> Scale type for custom emoji images
			List = { --> Allowed formats: "id" or {"id","permission to lock it to"}
				["ban_hammer"] = {"rbxassetid://4813866018","Owner"},
				["troll"] = "rbxassetid://15828456252",
				["vibe_cat"] = { --> Vibe cat
					["Image"] = "rbxassetid://18495257138",
					["ImageRectSize"] = Vector2.new(68.2,68.2), --> Image dimensions / columns and rows
					["Columns"] = 5,
					["Rows"] = 15,
					["Frames"] = 71,
					["FPS"] = 15 --> Above this gets a little too fast to comprehend logically
				}
			}
		},
		RemoveFormattingForChattedEvent = true
	},
	BubbleChat = {
		Enabled = true, --> Custom bubble chat enabled state (setting to false will default to the regular bubble chat which can be turned off in the properties of game.Chat)
		Config = {
			TypingIndicator = true, --> Some dots to indicate you're typing
			EasingStyle = Enum.EasingStyle.Bounce, --> The chat bubble's tween style
			Length = 0.16, --> The length per tween in the UI
			MaxMessages = 4, --> The max amount of bubble chat messages above one user's head at once
			FadeoutTime = 10, --> Message fading time
			TextSize = 16, --> This is the chat bubble's text size.
			Padding = 8, --> Padding in offset on each side of the message.
			BubbleFont = Enum.Font.GothamMedium, --> The chat bubble's primary font.
			TypingIndicatorColor = Color3.fromRGB(255,255,255), --> Player typing indicator color.
			BubbleBackgroundColor = Color3.fromRGB(20,20,20), --> The chat bubble's background color.
			BubbleTextColor = Color3.fromRGB(255,255,255), --> The chat bubble's text color.
			Roundness = 8, --> The chat bubble's roundness in pixels
		}
	},
	SettingsMenu = { --> Settings for the chat's interface
		Enabled = true, --> Do you want it to be enabled?
		ApiEnabledAndUIDisabled = false, --> Do you want to just enable the settings API for the client & disable the UI so you can design your own?
		TopbarButton = {
			Enabled = true, --> If it's enabled, do you want a topbar button for it? If not, you can use "/settings" to open the menu.
			Icon = "rbxassetid://8654540235" --> If you use the topbar button, what icon?
		}
	}
}