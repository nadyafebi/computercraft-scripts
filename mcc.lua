local repoUrl = "https://raw.githubusercontent.com/nadyafebi/computercraft-scripts/main/"
local programRoot = "mcc/"

local function printUsage()
    print("Get a script from Meeu's repo")
    print("Usage:")
    print("mcc install <script>")
    print("mcc uninstall <script>")
end

local function getFromRepo(path)
    local response = http.get(repoUrl .. path)

    if response then
        local result = response.readAll()
        response.close()
        return result
    end
end

local function appendLuaToPath(path)
    if string.sub(path, -4) ~= ".lua" then
        path = path .. ".lua"
    end
end

local function getProgramName(path)
    return path:match(".*\/(.*)\.lua$")
end

local function runInstall(path)
    path = appendLuaToPath(path)

    local filePath = shell.resolve(programRoot .. path)
    if fs.exists(filePath) then
        fs.delete(filePath)
    end

    local result = getFromRepo(path)
    if result then
        local file = fs.open(filePath, "w")
        file.write(result)
        file.close()
    else
        error("Could not download file")
    end

    local programName = getProgramName(path)
    shell.setAlias(programName, filePath)
end

local function runUninstall(path)
    path = appendLuaToPath(path)

    local filePath = shell.resolve(programRoot .. path)
    if fs.exists(filePath) then
        fs.delete(filePath)
    else
        error("Program to uninstall not found")
    end

    local programName = getProgramName(path)
    shell.clearAlias(programName)
end

local args = { ... }

if args[1] == "install" or args[1] == "i" and #args == 2 then
    runInstall(args[2])
elseif args[1] == "uninstall" and #args == 2 then
    runUninstall(args[2])
else
    printUsage()
end
