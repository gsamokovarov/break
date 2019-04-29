Experimental debugger for Ruby 2.5+ in plain Ruby using the [TracePoint API].

```ruby
binding.break # And off you go... 🚀
```

[Tracepoint API]: https://ruby-doc.org/core-2.6.2/TracePoint.html

## Commands

Command    | Short | Description
-------    | ----- | -----------
`next()`   | `n`   | Continue to next line.
`step`     | `s`   | Step into method invocation.
`up`       | `u`   | Go up the stack.
`down`     | `d`   | Go down the stack.
`list`     | `ls`  | Show the code surrounding the current debugged line.
`continue` | `c`   | Disconnect the debugger and continue to run program.
`exit`     |       | Disconnect the debugger and continue to run program.

## Installation

```ruby
gem install break
```
