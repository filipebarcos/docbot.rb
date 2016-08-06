# Array#push

(from ruby core)
---
    ary.push(obj, ... )   -> ary

---

Append --- Pushes the given object(s) on to the end of this array. This
expression returns the array itself, so several appends may be chained
together. See also Array#pop for the opposite effect.

    a = [ "a", "b", "c" ]
    a.push("d", "e", "f")
            #=> ["a", "b", "c", "d", "e", "f"]
    [1, 2, 3,].push(4).push(5)
            #=> [1, 2, 3, 4, 5]


