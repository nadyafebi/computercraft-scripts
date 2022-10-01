local repoUrl = "https://raw.githubusercontent.com/nadyafebi/computercraft-scripts/main/"

local function printUsage()
    print("Get a script from my repo")
    print("Usage:")
    print("mcc get <script>")
end

local function getFromRepo(path)
    local response = http.get(repoUrl .. path)

    if response then
        local result = response.readAll()
        response.close()
        return result
    end
end

local function runGet(path)
    if string.sub(path, -4) ~= ".lua" then
        path = path .. ".lua"
    end

    local filePath = shell.resolve(path)
    if fs.exists(filePath) then
        fs.delete(filePath)
    end

    local result = getFromRepo(path)
    if result then
        local file = fs.open(path, "w")
        file.write(result)
        file.close()
    else
        print("Could not find file")
    end
end

local args = { ... }
if #args < 1 then
    printUsage()
    return
end

if args[1] == "get" then
    if #args < 2 then
        printUsage()
        return
    end

    runGet(args[2])
end
