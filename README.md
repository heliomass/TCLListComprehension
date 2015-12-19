# Towards a List Comprehension in Tcl
A very basic prototype implementation of a [list comprehension](https://en.m.wikipedia.org/wiki/List_comprehension) for Tcl.

## Why?
For fun, and because it's 4am and I'm trying to get the baby to sleep.

## Usage
You just need to source `listc.tcl` and the `listc` command will be available in the global namespace.

Usage is described by the shell as:
```
listc ?expression? ?input_set? ?predicate? ?variable_name?
```
Here's an example to double all odd numbers between 1 and 10 inclusive:

```
% source listc.tcl
% listc 2*x [list 1 10] x%2==1
2 6 10 14 18
```

Observe how `listc` takes calculations in the format expected by the `expr` statement.

All arguments are optional. To play around with it, my recommendation would be to open `listc_test.tcl` and have a look at the examples within the unit tests. They show the list given the conventional way with the `list` command alongside the list comprehension given with `listc`.

## Limitations
There are three main limitations of this prototype.

Firstly, the list is created at the time `listc` is called and is represented as a standard Tcl list. This means you can't specify infinity in the range as you can in languages such as Python. I think enabling this would require overriding the standard `list` commands to perform the computation when list items are requested.

Secondly, the evaluation of the expressions is not restricted in any way. I wouldn't run this in production without carefully sanitising any variables you substitute into your `listc` statement. Then again, the same rule of thumb would also apply to `list` anyway.

Finally, the variable substitution is pretty bad. I would just stick with `x` as the variable name, and not change it using the `variable_name` argument.