
--[[
    All the roles here can access the admin menu
    Only the GOD can set the panels for the other roles
    There are 3 options
    1. God -> can access all the commands
    2. Admin -> can only access the commands selected for admins under the settings catergory
    3. Moderator -> can only access the commands selected for moderators under the settings catergory

    If you have a new role, you can add it here and select to give either God, Admin or Moderator perms

    eg. ["new_role"] = "God",
    eg. ["dev"] = "Admin",
]]--
Config.GodRoles = {
    ["god"] = "God", -- This is the biggest role
    ["admin"] = "Admin", -- This is the second biggest role
    ["mod"] = "Moderator", -- This is the lowest role
    ["new_role1"] = "Test", -- if you want to add more roles just add them here
    ["new_role2"] = "Test", -- if you want to add more roles just add them here
    ["new_role3"] = "Test",
    -- if you want to add more roles just add them here
    -- ["NEW_ROLE_HERE"] = "God",
    -- ["NEW_ROLE_HERE"] = "Admin",
    -- ["NEW_ROLE_HERE"] = "Moderator",
}

Config.Permissions = { 
    ["fivem:5270966"] = "god", -- the role god, admin or mod should be the key from Config.GodRoles which means the values that are added in square brackets.
    ["fivem:399064"] = "admin",
    ["fivem:1096504"] = "admin",
    ["fivem:2167031"] = "god",
    -- ["license:1234"] = "mod",
    -- ["license:1234"] = "new_role1",
    -- ["license:1234"] = "new_role2",
    -- ["license:1234"] = "new_role3",
}

