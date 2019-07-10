def addVersion: . + if has("version") | not then { version: "master" } else null end;

[.[] | (select(.type == "git") | addVersion ), (select(.type != "git"))]


