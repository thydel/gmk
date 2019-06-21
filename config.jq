.[]
  | select(.type == "config") | . as $config
  | .configs | to_entries | . as $items
  | map("config." + $config.name + "." + .key + " := " + .value)
+ ( [ $items | map(.key) | join(" ") | "config." + $config.name + ".items := " + . ] )
+ [ "config." + $config.name + ".key := " + $config.key ]
+ [ "config.items += " + $config.name ]
  | .[]
