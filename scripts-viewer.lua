
-- ###########################################################################
-- ## MADE BY https://v3rmillion.net/member.php?action=profile&uid=1802731 ##
-- ###########################################################################


local plr = game.Players.LocalPlayer
local shield = game.CoreGui:WaitForChild("RobloxGui"):WaitForChild("SettingsShield"):WaitForChild("SettingsShield")
local menu = shield:WaitForChild("MenuContainer")
local http = game:GetService("HttpService")
local tw = game:GetService("TweenService")

function fiximage(id)
    return string.format("rbxthumb://type=Asset&id=%s&w=420&h=420",tonumber(id))
end

function corners(gui,radius)
    Instance.new("UICorner",gui).CornerRadius = UDim.new(0,radius)
end

function newfolder(name)
    if not isfolder(name) then
        makefolder(name) 
    end
end
newfolder("coolmenu")
newfolder("coolmenu/placetimes")
newfolder("coolmenu/scripts")

if not isfile("coolmenu/placetimes/T".. tostring(game.PlaceId)..".lua") then
    writefile("coolmenu/placetimes/T".. tostring(game.PlaceId)..".lua","0\n0")
end

local file = readfile("coolmenu/placetimes/T".. tostring(game.PlaceId)..".lua","0\n0")
local timeplayed = file:split("\n")
local currenttimeplayedtotal = timeplayed[1]

function timeconvert(secs)
	local mins = (secs-secs%60)/60
	secs = secs-mins*60
	local hrs = (mins - mins%60)/60
	mins = mins - hrs*60
	return string.format("%02i",hrs)..":"..string.format("%02i",mins)..":"..string.format("%02i",secs)
end

local timeplayedtotal = Instance.new("TextLabel",shield)
timeplayedtotal.Size = UDim2.new(0.42,0,0.16)
timeplayedtotal.Position = UDim2.new(0.29,0,0.02,0)
timeplayedtotal.BackgroundTransparency = 1
timeplayedtotal.TextSize = 45
timeplayedtotal.TextColor3 = Color3.fromRGB(255,255,255)
timeplayedtotal.Font = "GothamBlack"
timeplayedtotal.TextXAlignment = "Left"
timeplayedtotal.TextYAlignment = "Top"
timeplayedtotal.Text = "All time played this game: ".. timeconvert(currenttimeplayedtotal)

spawn(function()
    while wait(1) do
        currenttimeplayedtotal = currenttimeplayedtotal + 1
        timeplayedtotal.Text = "all time played this game: ".. timeconvert(currenttimeplayedtotal)
        writefile("coolmenu/placetimes/T".. tostring(game.PlaceId)..".lua",currenttimeplayedtotal.."\n0") 
    end
end)

game.Players.PlayerRemoving:Connect(function(playerwholeft)
    if playerwholeft == plr then
        writefile("coolmenu/placetimes/T".. tostring(game.PlaceId)..".lua",currenttimeplayedtotal.."\n0") 
    end
end)

local forcequit = menu.BottomButtonFrame.LeaveGameButtonButton:Clone()
forcequit.Position = UDim2.new(0.5,-130,0.5,90)
forcequit.Name = "forcequit"
forcequit.LeaveGameButtonTextLabel.Text = "Force Quit"
forcequit.LeaveGameButtonTextLabel.Position = UDim2.new(0,35,0,0)
forcequit.LeaveGameButtonTextLabel.TextScaled = false
forcequit.LeaveGameButtonTextLabel.TextSize = 35
forcequit.LeaveGameButtonTextLabel.UITextSizeConstraint:Destroy()
forcequit.LeaveGameHint:Destroy()
forcequit.HoverImage = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
forcequit.Parent = menu.BottomButtonFrame
forcequit.MouseButton1Click:Connect(function() game:shutdown() end)

local pages = menu:WaitForChild("PageViewClipper"):WaitForChild("PageView"):WaitForChild("PageViewInnerFrame")
local scriptspage = Instance.new("ScrollingFrame") --pages:WaitForChild("Players"):Clone()
scriptspage.Name = "scripts"
scriptspage.Visible = false
scriptspage.Position = UDim2.new(0,0,0,0)
scriptspage.Size = UDim2.new(1,0,1,0)
scriptspage.BackgroundTransparency = 1
scriptspage.CanvasSize = UDim2.new(0,0,10,0)
scriptspage.Parent = pages

local listlayout = Instance.new("UIListLayout",scriptspage)
listlayout.Padding = UDim.new(0,18)
listlayout.SortOrder = Enum.SortOrder.LayoutOrder

local searchbg = Instance.new("Frame",scriptspage)
searchbg.Size = UDim2.new(1,0,0,62)
searchbg.BackgroundColor3 = Color3.fromRGB(255,255,255)
searchbg.LayoutOrder = -2

local srgrad = Instance.new("UIGradient",searchbg)
srgrad.Rotation = 90
srgrad.Offset = Vector2.new(0,-0.1)
srgrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(105,115,115)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(125,135,135)),
})

local search = Instance.new("TextBox",searchbg)
search.Size = UDim2.new(1,0,1,0)
search.TextSize = 34
search.PlaceholderText = "Search for scripts..."
search.PlaceholderColor3 = Color3.fromRGB(50,65,65)
search.TextColor3 = Color3.fromRGB(0,0,0)
search.BackgroundTransparency = 1
search.Font = "Gotham"
search.Text = ""

corners(searchbg,4)

function newscriptbutton(folder)
    local script = readfile(folder.."/script.lua")
    local data
    
    local fr = Instance.new("ImageLabel")
    local bump = " "
    fr.BackgroundColor3 = Color3.fromRGB(100,100,155)
    fr.BackgroundTransparency = 1
    fr.Size = UDim2.new(1,0,0,62)
    fr.LayoutOrder = 5
    fr.Name = folder
    fr.Image = "rbxasset://textures/ui/dialog_white.png"
    fr.ImageTransparency = 0.65
    fr.ScaleType = "Slice"
    fr.SliceCenter = Rect.new(10,10,10,10)
    fr.Parent = scriptspage
    
    local gradient = Instance.new("UIGradient",fr)
    gradient.Rotation = 5
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(125,125,145)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(235,200,255)),
    })
     
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,0,1,0)
    b.TextSize = 40
    b.TextWrapped = true
    b.TextXAlignment = "Left"
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.BackgroundTransparency = 1
    b.Font = "Gotham"
    b.Parent = fr
    
    local delete = Instance.new("TextButton")
    delete.Size = UDim2.new(0.05,0,0.6,0)
    delete.Position = UDim2.new(0.92,0,0.2,0)
    delete.TextScaled = true
    delete.BackgroundColor3 = Color3.fromRGB(255,0,0)
    delete.TextColor3 = Color3.fromRGB(0,0,0)
    delete.BackgroundTransparency = 0.4
    delete.Text = "X"
    delete.Font = "Gotham"
    delete.Parent = b
    
    corners(delete,4)
    
    local image = Instance.new("ImageLabel",fr)
    image.Size = UDim2.new(0.0475,0,0.6,0)
    image.Position = UDim2.new(0.02,0,0.2,0)
    image.BackgroundTransparency = 1
    
    local confirmdelete = false
    delete.MouseButton1Click:Connect(function()
        if not confirmdelete then
            delete.Text = "?"
            confirmdelete = true
            
            delay(5,function()
                confirmdelete = false
                delete.Text = "X"
            end)
        else
            fr:Destroy()
            delfolder(folder)
        end
    end)
    
    local gooddata,_ = pcall(function() http:JSONDecode(readfile(folder.."/data.lua")) end)
    
    if not gooddata then 
        b.Text = "JSON parse fail. folder: ".. folder:gsub("coolmenu/scripts",""):sub(2,999)
        b.TextSize = 25
        fr.LayoutOrder = -1
        fr.ImageColor3 = Color3.fromRGB(255,55,55)
        return
    else
        data = http:JSONDecode(readfile(folder.."/data.lua"))
    end
    
    if data.image and data.image ~= "" then
        bump = "      " 
        image.Image = fiximage(data.image)
    end
    
    local placeid = data.place
    local restrict = data.restricted
    b.Text = bump.. data.displayname
    
    if tonumber(placeid) ~= 0 and game.PlaceId == tonumber(placeid) then
        fr.ImageColor3 = Color3.fromRGB(230,210,0)
        b.Text = bump.. data.displayname
        fr.LayoutOrder = 4
        
        if restrict then
            fr.Visible = true
        end
    end
    
    search.Changed:Connect(function()
        local lowername = data.displayname:lower()
        search.Text = tostring(search.Text):lower()
        if search.Text ~= "" then
            if lowername:find(search.Text) then
                if not restrict then
                    fr.Visible = true
                else
                    if tonumber(placeid) ~= game.PlaceId then
                        fr.Visible = false
                    else
                        fr.Visible = true
                    end
                end
            else
                fr.Visible = false
            end
        else
            if not restrict then
                fr.Visible = true
            else
                if tonumber(placeid) ~= game.PlaceId then
                    fr.Visible = false
                else
                    fr.Visible = true
                end
            end
        end
    end)
    
    local en = true
    b.MouseButton1Click:Connect(function()
        if en then
            en = false
            b.Text = bump.. "executing..."
            fr.ImageTransparency = 0.3
            
            local timetaken = 0
            local success,errmsg
            
            tw:Create(gradient,TweenInfo.new(0.6),{
            Offset=Vector2.new(-1,0)}):Play()
            
            local dots = 3
            spawn(function()
                repeat wait(0.25)
                    timetaken = timetaken + 0.25 
                    dots = (dots >= 3 and 1 or dots + 1)
                    b.Text = bump.. "executing".. string.rep(".",dots)
                until success ~= nil or timetaken >= 15
            
                if success and timetaken < 15 then
                    fr.ImageTransparency = 0.65
                    b.Text = bump.. "done (".. timetaken .." secs)"
                    wait(1.2)
                    b.Text = bump.. data.displayname
                    en = true
                else
                    fr.ImageTransparency = 0.65
                    b.Text = bump.. "failed: ".. (timetaken >= 15 and "time ran out") or tostring(errmsg)
                    wait(1.2)
                    b.Text = bump.. data.displayname
                    en = true
                end
                
                tw:Create(gradient,TweenInfo.new(0.6),{
                Offset=Vector2.new(0,0)}):Play()
            end)
            
            success,errmsg = pcall(function()
                loadstring(script)()  
            end)
        end
    end)
    
    b.MouseEnter:Connect(function() fr.ImageTransparency = 0.5 end)
    b.MouseLeave:Connect(function() fr.ImageTransparency = 0.65 end)
end

local creator = Instance.new("Frame",scriptspage)
creator.Size = UDim2.new(1,0,0,62)
creator.BackgroundColor3 = Color3.fromRGB(255,255,255) 
creator.LayoutOrder = -1

local cregrad = Instance.new("UIGradient",creator)
cregrad.Rotation = 90
cregrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(105,115,115)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(90,100,100)),
})

local crname = Instance.new("TextBox",creator)
crname.Size = UDim2.new(0.2,0,0.8,0)
crname.Position = UDim2.new(0.01,0,0.1,0)
crname.BackgroundColor3 = Color3.new(0,0,0)
crname.BackgroundTransparency = 0.8
crname.TextSize = 15
crname.TextWrapped = true
crname.Text = ""
crname.PlaceholderText = "Script name"
crname.TextColor3 = Color3.fromRGB(0,0,0)

local crexe = Instance.new("TextBox",creator)
crexe.Size = UDim2.new(0.13,0,0.8,0)
crexe.Position = UDim2.new(0.22,0,0.1,0)
crexe.BackgroundColor3 = Color3.new(0,0,0)
crexe.BackgroundTransparency = 0.8
crexe.TextScaled = true
crexe.Text = ""
crexe.PlaceholderText = "Code here"
crexe.TextColor3 = Color3.fromRGB(0,0,0)

local crimg = Instance.new("TextBox",creator)
crimg.Size = UDim2.new(0.13,0,0.8,0)
crimg.Position = UDim2.new(0.36,0,0.1,0)
crimg.BackgroundColor3 = Color3.new(0,0,0)
crimg.BackgroundTransparency = 0.8
crimg.TextSize = 15
crimg.TextWrapped = true
crimg.Text = ""
crimg.PlaceholderText = "Image"
crimg.TextColor3 = Color3.fromRGB(0,0,0)

local crpri = Instance.new("TextButton",creator)
crpri.Size = UDim2.new(0.19,0,0.8,0)
crpri.Position = UDim2.new(0.5,0,0.1,0)
crpri.BackgroundColor3 = Color3.fromRGB(25,200,25)
crpri.BackgroundTransparency = 0.8
crpri.TextSize = 15
crpri.TextWrapped = true
crpri.Text = "Use Place ID"
crpri.TextColor3 = Color3.fromRGB(0,0,0)

local crres = Instance.new("TextButton",creator)
crres.Size = UDim2.new(0.13,0,0.8,0)
crres.Position = UDim2.new(0.7,0,0.1,0)
crres.BackgroundColor3 = Color3.fromRGB(200,25,25)
crres.BackgroundTransparency = 0.8
crres.TextSize = 15
crres.TextWrapped = true
crres.Text = "Restrict"
crres.TextColor3 = Color3.fromRGB(0,0,0)

local cradd = Instance.new("TextButton",creator)
cradd.Size = UDim2.new(0.12,0,0.8,0)
cradd.Position = UDim2.new(0.86,0,0.1,0)
cradd.BackgroundColor3 = Color3.fromRGB(200,200,25)
cradd.BackgroundTransparency = 0.8
cradd.TextSize = 15
cradd.TextWrapped = true
cradd.Text = "Add"
cradd.TextColor3 = Color3.fromRGB(0,0,0)

local rescr = false
local useplaceid = true

crres.MouseButton1Click:Connect(function()
    if useplaceid then
        rescr = not rescr
    
        crres.BackgroundColor3 = (rescr and Color3.fromRGB(25,200,25)) or Color3.fromRGB(200,25,25)
    end
end)

crpri.MouseButton1Click:Connect(function()
    useplaceid = not useplaceid
    
    crpri.BackgroundColor3 = (useplaceid and Color3.fromRGB(25,200,25)) or Color3.fromRGB(200,25,25)
    if not useplaceid then
        crres.BackgroundColor3 = Color3.fromRGB(90,90,90)
        rescr = false
    else
        crres.BackgroundColor3 = Color3.fromRGB(200,25,25)
    end
end)

corners(creator,4)

cradd.MouseButton1Click:Connect(function()
    local newname = crname.Text:gsub(" ","_")
    
    if not isfolder("coolmenu/scripts/".. newname) then
        local folder = "coolmenu/scripts/".. newname
        local realimg = crimg.Text
        
        if tonumber(realimg) then
            realimg = tostring(realimg)
        else
            if realimg:find("rbxassetid://") then
                realimg = realimg:gsub("rbxassetid//","")
            else
                realimg = ""
            end
        end
        
        makefolder(folder)
        writefile(folder.."/script.lua",crexe.Text)
        writefile(folder.."/data.lua",
        '{"place":'.. tostring(useplaceid and game.PlaceId or 0) ..',"restricted":'.. tostring(rescr) ..',"displayname":"'.. crname.Text ..'","image":"'.. realimg ..'"}'
        )
        
        crexe.Text = ""
        crname.Text = ""
        newscriptbutton("coolmenu/scripts/"..newname)
    end
end)

for i,v in pairs(listfiles("coolmenu/scripts")) do
    newscriptbutton(v)
end

local scriptstab = menu.HubBar.RecordTab:Clone()
scriptstab.Icon.Title.Text = "Scripts"
scriptstab.Icon.Image = fiximage(10629748756)
scriptstab.Icon.Size = UDim2.new(0,33,0,33)
scriptstab.Name = "scripts"
scriptstab.Parent = menu.HubBar
scriptstab.Icon.Title.TextTransparency = 0.5
scriptstab.TabSelection.Visible = false
scriptstab.Icon.ImageTransparency = 0.5
scriptstab.MouseButton1Click:Connect(function()
    scriptspage.Visible = true
    scriptspage.Position = UDim2.new(0,0,0,0)
    scriptstab.Icon.Title.TextTransparency = 0
    scriptstab.TabSelection.Visible = true
    scriptstab.Icon.ImageTransparency = 0
    pages.Parent.ScrollBarThickness = (scriptspage.Visible and 0) or 12
    for i,v in pairs(menu.HubBar:GetChildren()) do
        if v:IsA("TextButton") and v ~= scriptstab then
            v.TabSelection.Visible = false
            v.Icon.ImageTransparency = 0.5
            v.Icon.Title.TextTransparency = 0.5
        end
    end
    
    for i,v in pairs(pages:GetChildren()) do 
        if v ~= scriptspage then
            v.Visible = false 
        end
    end
end)

for i,v in pairs(menu.HubBar:GetChildren()) do
    if v:IsA("TextButton") then
        v.Size = UDim2.new(0.165,0,1,0) 
        v.MouseButton1Click:Connect(function()
            scriptstab.Icon.Title.TextTransparency = 0.5
            scriptstab.TabSelection.Visible = false
            scriptstab.Icon.ImageTransparency = 0.5 
            scriptspage.Visible = false
            pages.Parent.ScrollBarThickness = (scriptspage.Visible and 0) or 12
        end)
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(key,pro)
    if key.KeyCode == Enum.KeyCode.Escape then
        if menu.Parent.Position.Y.Offset < 0 then
            scriptstab.Icon.Title.TextTransparency = 0.5
            scriptstab.TabSelection.Visible = false
            scriptstab.Icon.ImageTransparency = 0.5 
            scriptspage.Visible = false 
            pages.Parent.ScrollBarThickness = (scriptspage.Visible and 0) or 12
        end
    end
end)
