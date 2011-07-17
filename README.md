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
it was the real object, the only stolen methods are: `__get_referenced__`, `__set_referenced__`, `~` and `=~`,
everything else is sent to the referenced object.

You can also create a reference to an object directly with `Reference.[]`

Cases where the Reference object doesn't work as expected
---------------------------------------------------------
There are some situations where the Reference object doesn't work exactly as the object it's referencing,
this cases are most likely related to C methods, when this happens just remember to use the `~` method
on the reference to get the referenced object.

* In the `case` statement when comparing for the object's class it doesn't work due to
  `Module#===` being implemented in C.

* `IO#==` and `IO#===` don't work as expected, this happens to be a problem when using `Array#delete` with a
  referenced IO object.

  If you want to compare an IO object to a Reference:IO you have to do `ref == io` and not `io == ref` or it
  won't work correctly.
  
  Keep in mind that if the thing you compare with is a Reference:IO too you're not going to get what you're expecting,
  the comparing value has to be a real IO object.

If you find any other situations where it's not working as expected open an issue or send me an email
and I'll add it here.
