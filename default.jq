def addVersion: . + if has("version") | not then { version: "master" } else null end;
def addName: . + if has("name") | not then { name: .[.type] } else null end;

[.[] |
 (select(.type == "git") | addVersion ),
 (select(.type == "alias" or .type == "hub") | addName ),
 select(.type == "config" or .type == "self")]
