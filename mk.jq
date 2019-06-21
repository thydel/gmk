#.[] | paths(scalars) as $p | [ .type, .name ] + $p + [ " := ", 1 ] | join(".")
#.[] | paths(scalars) as $p | [ .type, .name, ($p | join(".")), ":=", getpath($p) ]
#.[] | select(has("configs")), select(has("git"))
def y:
  if type == "array"
  then . | join(" ")
  elif type == "object"
  then .
  else .
  end;
def z(s; $s):
  if s | type == "array"
  then s | join(" ")
  elif s | type == "object"
  then  to_entries | map(z(.value; $s + .key))
  else $s + " = " + .
  end;

def walk2(f; $s):
  . as $in
  | if type == "object" then
      reduce keys_unsorted[] as $key
        ( {}; . + { ($key):  ($in[$key] | walk2(f; $in.type + "." + $in.name + $s + "." + $key)) } ) | f
  elif type == "array" then map( walk2(f; $s) ) | f
  else $s + " = " + f
  end;

def a: .;
  
#.[] | walk(x) | walk2(a; "")
#.[] | select(.type == "git") | del(.type) | paths(scalars) as $p | [ "git", .name, $p,  ]


def additems: if type == "object" then . += { items: keys | join(" ") } else . end;
def foo:
  group_by(.type) | map(map({type, name})) | flatten
  | reduce .[] as $type ({}; .[$type.type] += [$type.name]);
. as $in
#  | group_by(.type) | map(map({type, name})) | flatten
#  | reduce .[] as $type ({}; .[$type.type] += [$type.name])
  | foo as $foo
  | $in + [ $foo ]
  | .[] | walk(additems) | paths(scalars) as $p | ([ .type, .name ] + $p | join(".")) + " := " + getpath($p)
