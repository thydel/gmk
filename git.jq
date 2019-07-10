.[]
  | select(.type == "git")
  | . + if has("version") | not then { version: "master" } else null end
  | . as $git | to_entries
  | map("git." + $git.name + "." + .key + " := " + .value)
  | . += [ "git.items += " + $git.name ]
  | .[]
