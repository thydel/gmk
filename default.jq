def addVersion: . + if has("version") | not then { version: "master" } else null end;
def addName: . + if has("name") | not then { name: .alias } else null end;

[.[] |
 (select(.type == "git") | addVersion ),
 (select(.type == "alias") | addName ),
 (select(.type == "config"))]
