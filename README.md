Simple Ruby reference
=====================

It's a really simple reference implementation, used in failirc.

```ruby
lol = 3
r   = ref{:lol}
~r # => this returns 3, the object that was in lol
r =~ "lol"
~r # => this return "lol", the same string that you passed in
```

This is useful especially in an event dispatcher, you can use a reference object as
it was the real object, the only stolen methods are: `__get__`, `__set__`, `~` and `=~`,
everything else is sent to the referenced object.
