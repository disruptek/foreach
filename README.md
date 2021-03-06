# foreach

A sugary `for` loop macro with syntax for typechecking loop variables.  I've found that this syntax is as helpful for documentation as it is for eliminating errors.

## Example

```nim
import foreach

let a = [1, 2, 3]

foreach n in a.items of int:
  echo n, " is an int"
```

or

```nim
import json
import foreach

let j = %* {
  "one": 1,
  "two": "2",
}

foreach k, v in j.pairs of string and JsonNode:
	echo k, " is a string"
	echo v, " is a JsonNode"
```

but this will now fail at compile-time:

```nim
import json
import foreach

let j = %* {
  "one": 1,
  "two": "2",
}

# Error: loop variable `v` isn't a `string`
foreach k, v in j.pairs of string and string:
  echo k, " is a string"
  echo v, " is a string"
```

and you can use this to validate tuple field order/names:

```nim
import json
import foreach

type
  JsonKeyValue = tuple[key: string; value: JsonNode]

let j = %* {
  "one": 1,
  "two": "2",
}

# Error: loop variable `pair` isn't a `JsonKeyValue`
foreach pair in j.pairs of JsonKeyValue:
  assert pair.key is string
```

and for convenience, these compile to "normal" `for` loops:

```nim
import json
import foreach

let j = %* {
  "one": 1,
  "two": "2",
}

foreach k in 1 .. 5:
  assert k > 0

foreach k, v in j.pairs:
  echo k, " is a string"
  echo v, " isn't really a string"
```
