local uesmessagesmessage = {
    content = "",
    embeds = {
        {
            title = "使用记录🌐",
            description = "用户名✅ **" .. game.Players.LocalPlayer.Name .. "**",
            color = 0x00ff00,
            fields = {
                {
                    name = "**时间🕘**",
                    value = os.date("%Y年%m月%d日 %H时%M分"),
                    inline = false
                },
                {
                    name = "\n",
                    value = "**暂时什么都没有**",
                    inline = false
                },
                {
                    name = "123",
                    value = "",
                    inline = false
                },
                {
                    name = "**还是不知道**",
                    value = "为了美观",
                    inline = false
                }
            }
        }
    }
}

local Illegalsemessage = {
    content = "",
    embeds = {
        {
            title = "警告❎",
            description = "用户名❎ **" .. game.Players.LocalPlayer.Name .. "**",
            color = 0x00ff00,
            fields = {
                {
                    name = "**时间🕘**",
                    value = os.date("%Y年%m月%d日 %H时%M分"),
                    inline = false
                },
                {
                    name = "\n",
                    value = "**警告内容**",
                    inline = false
                },
                {
                    name = "此人没有白名单，使用脚本，可能脚本遭到外泄",
                    value = "",
                    inline = false
                },
                {
                    name = "调查",
                    value = game.Players.LocalPlayer.Name,
                    inline = false
                }
            }
        }
    }
}

        local problemmessage = {
            content = "",
            embeds = {
                {
                    title = "反馈记录🌐",
                    description = "用户名✅ **" .. game.Players.LocalPlayer.Name .. "**",
                    color = 0x00ff00,
                    fields = {
                        {
                            name = "**时间🕘**",
                            value = os.date("%Y年%m月%d日 %H时%M分"),
                            inline = false
                        },
                        {
                            name = "**反馈内容**",
                            value = Text,
                            inline = false
                        }
                    }
                }
            }
        }