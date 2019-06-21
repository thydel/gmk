.[]
  | select(.type == "git") | . as $git | to_entries
  | map("git." + $git.name + "." + .key + " := " + .value)
  | . += [ "git.items += " + $git.name ]
  | .[]
