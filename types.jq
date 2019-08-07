{ git: "git", config: "configs", alias: "alias" } as $types
  | . as $in
  | reduce ($types | to_entries)[] as $_ ([]; . + ($in | (map(select(has($_.value))) | .[] += { type: $_.key } )))
