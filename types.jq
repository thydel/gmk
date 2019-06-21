{ git: "git", config: "configs" } as $types
  | . as $in
  | reduce ($types | to_entries)[] as $_ ([]; . + ($in | (map(select(has($_.value))) | .[] += { type: $_.key } )))
