# JsonRehasher

# Requirements

1. Ruby 2.3.x
1. Rake


# Building

Just run `rake build`.


# Testing

1. `rake test`

# Running

```shell
# help
ruby bin/jsonrehasher --help

# rehash a file
ruby bin/jsonrehasher --file sample_input/input.json

# rehash from stdin
ruby bin/jsonrehasher --data '{"a.b.c.d": 1}'
```

# Notes

Algo is not efficient at all, could be done much better. In fact I think It is
horrible.
