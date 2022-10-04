local repoUrl = "https://raw.githubusercontent.com/nadyafebi/computercraft-scripts/main/"
local programRoot = "mcc/"

local function printUsage()
    print("Get a script from Meeu's repo")
    print("Usage:")
    print("mcc install <script>")
end

local function getFromRepo(path)
    local response = http.get(repoUrl .. path)

    if response then
        local result = response.readAll()
        response.close()
        return result
    end
end

local function runInstall(path)
    if string.sub(path, -4) ~= ".lua" then
        path = path .. ".lua"
    end

    local filePath = shell.resolve(programRoot .. path)
    if fs.exists(filePath) then
        fs.delete(filePath)
    end

    local result = getFromRepo(path)
    if result then
        local file = fs.open(path, "w")
        file.write(result)
        file.close()
    else
        print("Could not download file")
    end

    local programName = path:match(".*\/(.*)\.lua$")
    shell.setAlias(programName, filePath)
end

local args = { ... }

if args[1] == "install" or args[1] == "i" and #args == 2 then
    runInstall(args[2])
end

printUsage()
