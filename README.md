Simple Ruby reference
=====================

It's a really simple reference implementation, used in failirc.

```ruby
>> require 'refr'
true
>> lol = 2
2
>> ref = Reference.local{:lol}
2
>> ref =~ "what"
"what"
>> lol
"what"
```

This is useful especially in an event dispatcher, you can use a reference object as
it was the real object, the only stolen methods are: `__get__`, `__set__`, `~` and `=~`,
everything else is sent to the referenced object.

You can also create a reference to an object directly with `Reference.[]`
