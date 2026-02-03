-- Xtra^3 (or Xtra3 or Xtra cubed)
--     Xtra^3 is a library (ModuleScript), that adds various functions (primarely with the 0-based index system) to use in your scripts
-- Import with `local lib = require(<path to this ModuleScript>)` in your scripts

local Xtra3 = {}

-- GEA0 = Get element at 0-based index
function Xtra3.GEA0(t: {any}, i: number): any
	return t[i + 1]
end

-- GCA0 = Get character at 0-based index
function Xtra3.GCA0(s: string, i: number): string
	return string.sub(s, i + 1, i + 1)
end

-- SEA0 = Set element at 0-based index
function Xtra3.SEA0(t: {any}, e: any, i: number)
	t[i + 1] = e
end

-- SCA0 = Set character at 0-based index
function Xtra3.SCA0(s: string, c: string, i: number): string
	if #c > 1 then
		error("\"c\" isn't a character")
		return
	end

	return string.sub(s, 1, i) .. c .. string.sub(s, i + 2)
end

-- ISA0 = Insert at 0-based index
function Xtra3.ISA0(s: string, c: string, i: number): string
	return string.sub(s, 1, i) .. c .. string.sub(s, i + 1)
end

-- Checks if a string ends with a given suffix
function Xtra3.StringEndsWith(s: string, suffix: string): boolean
	if #suffix > #s then
		return false
	end

	local startIndex: number = #s - #suffix + 1
	local success: number = 0

	for i = 1, #suffix, 1 do
		local suffixPart: string = string.sub(suffix, i, i)
		local sPart: string = string.sub(s, startIndex + i - 1, startIndex + i - 1)
		if sPart == suffixPart then
			success += 1
		end
	end

	return success == #suffix
end

-- Checks if a string starts with a given prefix
function Xtra3.StringStartsWith(s: string, prefix: string): boolean
	if #prefix > #s then
		return false
	end

	local success: number = 0

	for i = 1, #prefix, 1 do
		local prefixPart: string = string.sub(prefix, i, i)
		local sPart: string = string.sub(s, i, i)
		if sPart == prefixPart then
			success += 1
		end
	end

	return success == #prefix
end

-- Checks if a string contains a given substring
function Xtra3.StringContains(s: string, substr: string): boolean
	if #substr > #s then
		return false
	end

	for i = 1, #s, 1 do
		if Xtra3.StringStartsWith(string.sub(s, i), substr) then
			return true
		end
	end

	return false
end

-- Counts the number of times a substring occurs in a string
function Xtra3.StringCount(s: string, substr: string): number
	if #substr > #s then
		return 0
	end

	local count: number = 0

	for i = 1, #s, 1 do
		if Xtra3.StringStartsWith(string.sub(s, i), substr) then
			count += 1
		end
	end

	return count
end

-- Repeats a string n times, with an optional separator between each repetition
function Xtra3.StringRepeat(s: string, n: number, separator: string?): string
	separator = separator or ""
	local parts: {string} = {}

	for i = 1, n do
		table.insert(parts, s)
	end

	return table.concat(parts, separator)
end

-- Removes characters from a string until it is different from a given character, starting from a given (0-based) index
function Xtra3.RemoveCharsUntilDiff(s: string, c: string, i: number?, count: number?, fromLeft: boolean?): string
	fromLeft = fromLeft ~= false
	i = i or (fromLeft and 1 or #s)
	count = count or -1

	local result: string = s
	if count == -1 then
		count = #s
	end

	if fromLeft then
		local pos = i
		for _ = 1, count do
			if pos > #result or #result == 0 then break end
			if Xtra3.GCA0(result, pos - 1) == c then
				result = string.sub(result, pos + 1)
			else
				break
			end
		end
	else
		local pos = i
		for _ = 1, count do
			if pos < 1 or #result == 0 then break end
			if Xtra3.GCA0(result, pos - 1) == c then
				result = string.sub(result, 1, pos - 1)
				pos -= 1
			else
				break
			end
		end
	end

	return result
end

-- Trims a string, trimming a given character
function Xtra3.TrimChar(s: string, c: string): string
	s = Xtra3.RemoveCharsUntilDiff(s, c, 0, -1, true)
	s = Xtra3.RemoveCharsUntilDiff(s, c, #s - 1, -1, false)
	return s
end

-- Trims a string, trimming a given character or a set of characters if specified, otherwise trims all whitespaces, tabs and newlines
function Xtra3.StringTrim(s: string, c: string): string
	if #s <= 0 then
		return ""
	end
	local result: string = s

	if c  and #c > 0 then
		for i = 0, #c - 1, 1 do
			result = Xtra3.TrimChar(result, Xtra3.GCA0(c, i))
		end
	else
		for _, ch in ipairs({" ", "\t", "\n"}) do
			result = Xtra3.TrimChar(result, ch)
		end
	end

	return result
end

-- Checks if a table contains a specific value
function Xtra3.TableContains(t: {any}, e: any): boolean
	for _, v in pairs(t) do
		if v == e then
			return true
		end
	end

	return false
end

-- Converts a table of characters to a string
function Xtra3.CharsToString(c: {string}): string
	return table.concat(c)
end

-- Converts a string to a table of characters
function Xtra3.StringToChars(s: string): {string}
	local result: {string} = {}

	for i = 0, #s - 1, 1 do
		table.insert(result, Xtra3.GCA0(s, i))
	end

	return result
end

-- Replaces all occurrences of a string in a string
function Xtra3.StringReplace(s: string, old: string, new: string): string
	if #s == 0 then
		return ""
	end

	if #old == 0 then
		return s
	end

	local parts: {string} = {}
	local i: number = 1

	while i <= #s do
		if Xtra3.StringStartsWith(string.sub(s, i), old) then
			table.insert(parts, new)
			i += #old
		else
			table.insert(parts, Xtra3.GCA0(s, i-1))
			i += 1
		end
	end

	return table.concat(parts)
end

-- Checks whether or not is a string blank
function Xtra3.StringIsBlank(s: string?): boolean
	return (s == nil) or (Xtra3.StringTrim(s) == "")
end

-- Converts a boolean to a string
function Xtra3.BoolToString(f: boolean): string
	if f then
		return "true"
	else
		return "false"
	end
end

-- Converts a string to a boolean, if not returns nil
function Xtra3.StringToBool(s: string): boolean?
	if s == "true" then
		return true
	elseif s == "false" then
		return false
	else
		return nil
	end
end

-- Checks if a string is a boolean
function Xtra3.StringIsBool(s: string): boolean
	return Xtra3.StringToBool(s) ~= nil
end

-- Removes a specified value from a table
function Xtra3.TableRemoveValue(t: {any}, e: any)
	for i = #t, 1, -1 do
		if t[i] == e then
			table.remove(t, i)
		end
	end
end

-- Copies a table (returns a new one)
function Xtra3.TableCopy(t: {any}): {any}
	local copy = {}
	for k, v in pairs(t) do
		copy[k] = v
	end

	return copy
end

-- Safely converts a string to a number
function Xtra3.StringToNumberSafe(s: string?, default: number): number
	local n = tonumber(s)

	if not n then
		return default or 0
	end

	return n
end

-- Gets a humanoid's "parent" (player from humanoid)
function Xtra3.GetPlayerFromHumanoid(humanoid: Humanoid): Player?
	for _, plr: Player in ipairs(game.Players:GetPlayers()) do
		if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") == humanoid then
			return plr
		end
	end

	return nil
end

-- Returns the instance at the given path or nil if not found
function Xtra3.GetInstanceFromPath(path: string, startInstance: Instance?): Instance?
	local start: Instance = startInstance or game

	local pathParts: {string} = string.split(path, "\\")
	local current: Instance = start

	for i = 0, #pathParts - 1 do
		local step: Instance = current:FindFirstChild(Xtra3.GEA0(pathParts, i))

		if not step then
			return nil
		end

		current = step

		if i == (#pathParts - 1) then
			return current
		end
	end
end

-- Makes a string path from instances
function Xtra3.MakePathFromInstances(startInstance: Instance?, endInstance: Instance, includeStart: boolean?): string
	if includeStart == nil then
		includeStart = true
	end

	local ancestors = {}
	local current = endInstance

	while current do
		table.insert(ancestors, 1, current)
		if current == startInstance then
			break
		end
		current = current.Parent
	end

	if startInstance and ancestors[1] ~= startInstance then
		return ""
	end

	if not includeStart and startInstance and ancestors[1] == startInstance then
		table.remove(ancestors, 1)
	end

	local parts = {}
	for _, inst in ipairs(ancestors) do
		if inst == game then
			table.insert(parts, "game")
		else
			table.insert(parts, inst.Name)
		end
	end

	return table.concat(parts, "\\")
end

-- Gets ancestors of type specified
function Xtra3.GetAncestorsOfType(instance: Instance, ancestorType: string): {Instance}?
	local ancestors: {Instance}? = instance:GetAncestors()
	local returnResult: {Instance} = {}

	if ancestors == nil then
		return nil
	end

	for _, ancestor in ipairs(ancestors) do
		if ancestor:IsA(ancestorType) then
			table.insert(returnResult, ancestor)
		end
	end

	return returnResult
end

-- Gets descendants of type specified
function Xtra3.GetDescendantsOfType(instance: Instance, descendantType: string): {Instance}?
	local descendants: {Instance}? = instance:GetDescendants()
	local returnResult: {Instance} = {}

	if descendants == nil then
		return nil
	end

	for _, descendant in ipairs(descendants) do
		if descendant:IsA(descendantType) then
			table.insert(returnResult, descendant)
		end
	end

	return returnResult
end

-- Gets children of type specified
function Xtra3.GetChildrenOfType(instance: Instance, childType: string): {Instance}?
	local children: {Instance}? = instance:GetChildren()
	local returnResult: {Instance} = {}

	if children == nil then
		return nil
	end

	for _, child in ipairs(children) do
		if child:IsA(childType) then
			table.insert(returnResult, child)
		end
	end

	return returnResult
end

-- Gets an ancestor of type specified
function Xtra3.GetAncestorOfType(instance: Instance, ancestorType: string): Instance?
	local ancestors: {Instance}? = instance:GetAncestors()

	if ancestors == nil then
		return nil
	end

	for _, ancestor in ipairs(ancestors) do
		if ancestor:IsA(ancestorType) then
			return ancestor
		end
	end
end

-- Gets a descendant of type specified
function Xtra3.GetDescendantOfType(instance: Instance, descendantType: string): Instance?
	local descendants: {Instance}? = instance:GetDescendants()

	if descendants == nil then
		return nil
	end

	for _, descendant in ipairs(descendants) do
		if descendant:IsA(descendantType) then
			return descendant
		end
	end
end

-- Gets a child of type specified
function Xtra3.GetChildOfType(instance: Instance, childType: string): Instance?
	local children: {Instance}? = instance:GetChildren()

	if children == nil then
		return nil
	end

	for _, child in ipairs(children) do
		if child:IsA(childType) then
			return child
		end
	end
end

-- Returns a rig from a username
function Xtra3.GetRigFromUsername(username: string, rigType: Enum.HumanoidRigType): Instance?
	local success, result = pcall(function()
		return game:GetService("Players"):GetUserIdFromNameAsync(username)
	end)

	if not success then
		return nil
	end

	local description: HumanoidDescription = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(result)
	local rig: Instance? = game:GetService("Players"):CreateHumanoidModelFromDescriptionAsync(description, rigType)

	if rig ~= nil then
		rig.Name = username
	end

	return rig
end

-- Returns a rig from a UserID
function Xtra3.GetRigFromUserId(userId: number, rigType: Enum.HumanoidRigType): Instance?
	local description: HumanoidDescription = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(userId)
	local rig: Instance? = game:GetService("Players"):CreateHumanoidModelFromDescriptionAsync(description, rigType)

	if rig ~= nil then
		rig.Name = game:GetService("Players"):GetNameFromUserIdAsync(userId)
	end

	return rig
end

-- TinyExpr-like expression evaluator function (TinyExpr C to Luau port)
function Xtra3.te_interp(expression: string): (number?, string?)
	local constants: {[string]: number} = {
		pi = math.pi,
		e = math.exp(1),
	}

	local function fac(n: number): number
		if n < 0 then return 0/0 end
		n = math.floor(n)
		local r = 1
		for i = 1, n do r *= i end
		return r
	end

	local function ncr(n: number, r: number): number
		if r < 0 or n < r then return 0/0 end
		return fac(n) / (fac(r) * fac(n - r))
	end

	local function npr(n: number, r: number): number
		return fac(n) / fac(n - r)
	end

	local functions: {[string]: (...number) -> number} = {
		abs = math.abs,
		acos = math.acos,
		asin = math.asin,
		atan = math.atan,
		atan2 = math.atan2,
		ceil = math.ceil,
		cos = math.cos,
		cosh = math.cosh,
		exp = math.exp,
		fac = fac,
		floor = math.floor,
		ln = math.log,
		log = math.log10,
		log10 = math.log10,
		ncr = ncr,
		npr = npr,
		pow = function(a, b) return a ^ b end,
		sin = math.sin,
		sinh = math.sinh,
		sqrt = math.sqrt,
		tan = math.tan,
		tanh = math.tanh,
		deg = math.deg,
		rad = math.rad,
		rand = math.random,
	}

	type Token = { type: string, value: any? }

	local pos = 1
	local len = #expression

	local function skip()
		while pos <= len and expression:sub(pos, pos):match("%s") do
			pos += 1
		end
	end

	local function nextToken(): Token
		skip()
		if pos > len then
			return { type = "EOF" }
		end

		local c = expression:sub(pos, pos)

		if c:match("[%d%.]") then
			local start = pos
			while expression:sub(pos, pos):match("[%d%.]") do
				pos += 1
			end
			return { type = "NUMBER", value = tonumber(expression:sub(start, pos - 1)) }
		end

		if c:match("[%a_]") then
			local start = pos
			while expression:sub(pos, pos):match("[%w_]") do
				pos += 1
			end
			return { type = "IDENT", value = expression:sub(start, pos - 1) }
		end

		pos += 1
		return { type = c }
	end

	local token = nextToken()

	local function eat(t: string)
		if token.type ~= t then
			error("Syntax error")
		end
		token = nextToken()
	end

	local expr, term, factor, power, primary

	function expr(): number
		local v = term()
		while token.type == "+" or token.type == "-" do
			local op = token.type
			eat(op)
			local r = term()
			if op == "+" then v += r else v -= r end
		end
		return v
	end

	function term(): number
		local v = factor()
		while token.type == "*" or token.type == "/" or token.type == "%" do
			local op = token.type
			eat(op)
			local r = factor()
			if op == "*" then v *= r
			elseif op == "/" then v /= r
			else v %= r end
		end
		return v
	end

	function factor(): number
		local v = power()
		if token.type == "^" then
			eat("^")
			v = v ^ factor()
		end
		return v
	end

	function power(): number
		if token.type == "-" then
			eat("-")
			return -power()
		elseif token.type == "+" then
			eat("+")
			return power()
		end
		return primary()
	end

	function primary(): number
		if token.type == "NUMBER" then
			local v = token.value
			eat("NUMBER")
			return v
		end

		if token.type == "IDENT" then
			local name = token.value
			eat("IDENT")

			if token.type == "(" then
				eat("(")
				local args = { expr() }
				while token.type == "," do
					eat(",")
					table.insert(args, expr())
				end
				eat(")")

				local f = functions[name]
				if not f then error("Unknown function: " .. name) end
				return f(table.unpack(args))
			end

			if constants[name] ~= nil then
				return constants[name]
			end

			error("Unknown identifier: " .. name)
		end

		if token.type == "(" then
			eat("(")
			local v = expr()
			eat(")")
			return v
		end

		error("Unexpected token")
	end

	local ok, result = pcall(function()
		local v = expr()
		if token.type ~= "EOF" then error("Unexpected input") end
		return v
	end)

	if not ok then
		return nil, "Parse error"
	end

	return result, nil
end

-- Inserts a Roblox asset of type specified (if the asset is not of type specified, it will return nil)
function Xtra3.InsertAssetOfType(assetID: number, className: string): Instance?
	local result = nil
	local asset = game:GetService("InsertService"):LoadAsset(assetID)
	
	if asset:IsA(className) then
		result = asset
	else
		local child: Instance? = Xtra3.getChildOfType(asset, className)
		if child and child:IsA(className) then
			result = child
		end
	end
	
	return result
end

-- Iff = inline if (ternary helper)
function Xtra3.Iff(condition: boolean, resultTrue: any?, resultFalse: any?): any?
	if condition then
		return resultTrue
	else
		return resultFalse
	end
end

-- Converts a value to a boolean
-- true is true, everything else is false
function Xtra3.ToBool(value: any?): boolean
	return value == true
end

-- Converts a value to a boolean (truthy version)
-- Every "truthy" (e.g. string, number, true, ...) is true, and "negative" values (e.g. nil, false) are false
function Xtra3.Truthy(value: any?): boolean
	return not not value
end

-- Attaches a Roblox asset to a given rig and returns the new one
function Xtra3.AttachAssetToRig(rig: Instance, assetID: number, deleteShirtGraphic: boolean?): Instance
	local result = rig
	local asset = game:GetService("InsertService"):LoadAsset(assetID)
	local doDeleteShirtGraphic = deleteShirtGraphic == true
	
	if asset:IsA("Model") then
		local child: Instance = asset:GetDescendants()[1]
		
		if child:IsA("Accessory") then
			local humanoid: Humanoid = result:FindFirstChildOfClass("Humanoid")
			humanoid:AddAccessory(child)
			child:Destroy()
		elseif child:IsA("Shirt") then
			if result:FindFirstChildOfClass("Shirt") then
				result:FindFirstChildOfClass("Shirt"):Destroy()
			end
			
			child.Parent = result
		elseif child:IsA("Pants") then
			if result:FindFirstChildOfClass("Pants") then
				result:FindFirstChildOfClass("Pants"):Destroy()
			end
			
			child.Parent = result
		elseif child:IsA("ShirtGraphic") then
			if doDeleteShirtGraphic and result:FindFirstChildOfClass("ShirtGraphic") then
				result:FindFirstChildOfClass("ShirtGraphic"):Destroy()
			end
			
			child.Parent = result
		end
	else
		if asset:IsA("Accessory") then
			local humanoid: Humanoid = result:FindFirstChildOfClass("Humanoid")
			humanoid:AddAccessory(asset)
			asset:Destroy()
		elseif asset:IsA("Shirt") then
			if result:FindFirstChildOfClass("Shirt") then
				result:FindFirstChildOfClass("Shirt"):Destroy()
			end
			
			asset.Parent = result
		elseif asset:IsA("Pants") then
			if result:FindFirstChildOfClass("Pants") then
				result:FindFirstChildOfClass("Pants"):Destroy()
			end
			
			asset.Parent = result
		elseif asset:IsA("ShirtGraphic") then
			if doDeleteShirtGraphic and result:FindFirstChildOfClass("ShirtGraphic") then
				result:FindFirstChildOfClass("ShirtGraphic"):Destroy()
			end
			
			asset.Parent = result
		end
	end
	
	return result
end

-- Filters a string (PublicChat, NonChatString)
function Xtra3.FilterString(input: string, userID: number): string?
	local ok, result = pcall(function()
		return game:GetService("TextService"):FilterStringAsync(input, userID, Enum.TextFilterContext.PublicChat):GetNonChatStringForBroadcastAsync()
	end)
	
	if not ok then 
		return nil 
	else 
		return result 
	end
end

return Xtra3
