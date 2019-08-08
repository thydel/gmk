def typedList2object: reduce .[] as $_ ({}; .[$_.type][$_.name] += $_);
def SingletypedList2object: reduce .[] as $_ ({}; .[$_.type] += $_);
def addItems: if type == "object" and (has("type") | not) then . += { items: keys | join(" ") } end;
def remType: if type == "object" then del(.type) | del(.name) end;
def mkVars: paths(scalars) as $_ | ($_  | join(".")) + " := " + getpath($_);

(map(select(.type == "self")) | SingletypedList2object | mkVars),
(map(select(.type != "self")) | typedList2object | with_entries(walk(addItems)) | walk(remType) | mkVars)
