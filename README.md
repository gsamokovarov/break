# Break

Break is another debugging take for Ruby. It is written in plain Ruby and
doesn't have its own frontend. Once you `require "break"`, it integrates
seamlessly with IRB and [Pry] and you have commands like `next` (or the short-cut
`n`) straight in your REPL sessions. You don't need to remember to start your
debugger or change your development flow. Break embraces it, instead of forcing
you to learn a new tool.

# Why we need a debugger in Ruby?

We had our fair share of abandoned Ruby debuggers written in C because their
maintenance was pretty hard. Back in the 1.8 and 1.9 days the interpreter
itself changed more often and didn't provide a stable API to aid the writing of
development tools. This means that [ruby-debug], a debugger written for Ruby
1.8 had to be rewritten for 1.9 (as a different gem: [ruby-debug-base19]) and
then again for Ruby 2.0+ at which point it's development was halted as
maintaining 3 different implementations was not so nice.

If we get better APIs in Ruby-land, we won't run into the problems [ruby-debug]
did. Even better, the debugger can be thin layers on top of the heavy-lifting
debugging instrumentation APIs that live in the interpreter themselves. This
way the interpreter internals can change as much as they want, but if they
still provide the same APIs, all of the debugging tools will still work. More,
we can port our debuggers to JRuby, TruffleRuby or whatever alternative Ruby
implementation is supported and under active development at the time.

## Commands

The following commands are available in both IRB and [Pry].

Command    | Short      | Description
-------    | ---------- | -----------
`next`     | `n`  (irb) | Continue to next line.
`step`     | `s`  (irb) | Step into method invocation.
`up`       | `u`  (irb) | Go up the stack.
`down`     | `d`  (irb) | Go down the stack.
`list`     | `ls` (irb) | Show the code surrounding the current debugged line.
`continue` | `c`  (irb) | Disconnect the debugger and continue to run program.
`exit`     |            | Disconnect the debugger and continue to run program.

## Usage

Add `break` in your application `Gemfile` and make sure to `require "break"`
early in your program setup. In a Rails application, `break` will be required
automatically and you don't need to worry about that.

```ruby
gem "pry" # If you want PRY integration, require break after pry.
gem "break"
```

Break automatically injects its commands into `binding.irb` (given it's already
required). The same with [Pry], if a `require "pry"` happened _before_
`require "break"`, break will be able to automatically integrate into
`binding.pry` if this is you favorite debugging choice.

[Tracepoint API]: https://ruby-doc.org/core-2.6.2/TracePoint.html
[Pry]: https://github.com/pry/pry

[ruby-debug]: https://github.com/ruby-debug/ruby-debug
[ruby-debug-base19]: https://github.com/ruby-debug/ruby-debug-base19
