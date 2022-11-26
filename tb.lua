local req = require("request")
local tpl = require("template")

local dir = "/sdcard/luaweb/wwwroot/test/"

local html = tpl.new(dir .. "index.html")

html:set("title", "Moid测试站")

local array = {}

local file = io.open(dir .. "data.txt", "a+")

while true do

local line = file:read()
if line == nil or line == "" then break end

local tb = {}
tb["name"] = string.match(line, "%a+ ")
tb["age"] = string.match(line, " %d+")

array[#array + 1] = tb

end

local name = req.post("name")
local age = req.post("age")

if name ~= nil and age ~= nil then

file:write("\r\n" .. name .. " " .. age)
array[#array + 1] = {["name"] = name, ["age"] = age}

end

file:close()

html:set("array",array)

print(html:out())