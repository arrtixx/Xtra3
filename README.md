# Xtra^3
Xtra^3 is a Luau library with lots of functions to use. These functions include:
```
GEA0() - GEA0 = Get element at 0-based index
GCA0() - GCA0 = Get character at 0-based index
SEA0() - SEA0 = Set element at 0-based index
SCA0() - SCA0 = Set character at 0-based index
ISA0() - ISA0 = Insert string at 0-based index
StrindEndsWith() - Checks if a string ends with a given suffix
StringStartsWith() - Checks if a string starts with a given prefix
StringContains() - Checks if a string contains a given substring
StringCount() - Counts the number of times a substring occurs in a string
StringRepeat() - Repeats a string n times, with an optional separator between each repetition
RemoveCharsUntilDiff() - Removes characters from a string until it is different from a given character, starting from a given (0-based) index
TrimChar() - Trims a string, trimming a given character
StringTrim() - Trims a string, trimming a given character or a set of characters if specified, otherwise trims all whitespaces, tabs and newlines
TableContains() - Checks if a table contains a specific value
CharsToString() - Converts a table of characters to a string
StringToChars() - Converts a string to a table of characters
StringReplace() - Replaces all occurrences of a string in a string
StringIsBlank() - Checks whether or not is a string blank
BoolToString() - Converts a boolean to a string
StringToBool() - Converts a string to a boolean, if not returns nil
StringIsBool() - Checks if a string is a boolean
TableRemoveValue() - Removes a specified value from a table
TableCopy() - Copies a table (returns a new one)
StringToNumberSafe() - Safely converts a string to a number
GetPlayerFromHumanoid() - Gets a humanoid's "parent" (player from humanoid)
GetInstanceFromPath() - Returns the instance at the given path or nil if not found
MakePathFromInstances() - Makes a string path from instances
GetAncestorsOfType() - Gets ancestors of type specified
GetDescendantsOfType() - Gets descendants of type specified
GetChildrenOfType() - Gets children of type specified
GetAncestorOfType() - Gets an ancestor of type specified
GetDescendantOfType() - Gets a descendant of type specified
GetChildOfType() - Gets a child of type specified
GetRigFromUsername() - Returns a rig from a username
GetRigFromUserID() - Returns a rig from a UserID
te_interp() - TinyExpr-like expression evaluator function (TinyExpr C to Luau port)
InsertAssetOfType() Inserts a Roblox asset of type specified (if the asset is not of type specified, it will return nil)
Iff() - Iff = inline if (ternary helper)
ToBool() - Converts a value to a boolean
Truthy() - Converts a value to a boolean (truthy version)
AttachAssetToRig() - Attaches a Roblox asset to a given rig and returns the new one
FilterString() - Filters a string (PublicChat, NonChatString)
```
