# Break

Break is a lightweight debugger for Ruby. It's written in plain Ruby and
doesn't have its own frontend. Once you put `gem "break"` in your `Gemfile`, it
integrates seamlessly with IRB or [Pry]. You have navigational commands like
`next` and `step` straight in your REPL session. You don't need to remember to
start your debugger or change your development flow. Break embraces your flow,
instead of forcing you to abide to yet another tool.

## Features

- Control flow executing control.
- No runtime cost. The tracing instructions kick in only when navigating.
- Automatic integration with IRB and [Pry].
- Rails 6 constant auto loading support (not available in other Ruby debuggers).

## Installation

Put `gem "break"` in your `Gemfile`. Then run `bundle install` and
`binding.irb` (or `binding.pry`) to your heart's desire.

## Commands

The following commands are available in both IRB and [Pry].

Command    | Description
---------- | -----------
`next`     | Continue to next line.
`step`     | Step into method invocation.
`up`       | Go up the stack.
`down`     | Go down the stack.
`whereami` | Show the code surrounding the current debugged line.
`exit`     | Disconnect the debugger and continue to run the program.

## Usage

Add `break` in your application `Gemfile` and make sure to `require "break"`
early in your program setup. In a Rails application, `break` will be required
automatically and you don't need to worry about that.

```ruby
gem "break"
```

Break automatically injects its commands into `binding.irb` and `binding.pry`
(if available).

If you need to debug your program, type a `next` to go to the next line of
program execution or `step` to step into a method, block, or class/module
opening call. All of this, in the comfort of IRB or [Pry]. Simple!

## Remote usage

Break can integrate with `pry-remote` for remote process debugging. You have to
require `break/remote` for Break's integration to kick in.

You can declare `break` in your `Gemfile` with a custom `require` to get the
remote integration loaded automatically by Bundler:

```ruby
gem "break", require: "break/remote"
```

## Why we need a debugger in Ruby?

We had our fair share of abandoned Ruby debuggers written in C. During Ruby 1.8
and Ruby 1.9 days, the interpreter itself changed often and didn't provide a
stable API to aid the writing of development tools. This means that
[ruby-debug], a debugger written for Ruby 1.8 had to be rewritten for 1.9 (as a
different gem: [ruby-debug-base19]) and then again for Ruby 2.0. At this point
the development was halted as maintaining 3 different implementations is hard.

If we get better APIs in Ruby-land we won't run into the problems [ruby-debug]
did. Even better, the debuggers can be thin layers on top of the heavy-lifting
debugging instrumentation APIs that live in the interpreter themselves. This
way the interpreter internals can change as much as they want but if they
provide the same APIs, all of the debugging tools will still work. On top of
that, our debuggers will work on JRuby, TruffleRuby or whatever alternative
Ruby implementation is under active development at the time.

Break exists to implement a functional debugger in pure Ruby using the
[TracePoint API]. It also wants to serve as a catalyst for other Ruby-land
available APIs that are useful for implementing debugging tools.

Learn more from this [Ruby Russia talk]. ⚡️

[TracePoint API]: https://ruby-doc.org/core-2.6.2/TracePoint.html
[Pry]: https://github.com/pry/pry

[ruby-debug]: https://github.com/ruby-debug/ruby-debug
[ruby-debug-base19]: https://github.com/ruby-debug/ruby-debug-base19

[Ruby Russia talk]: https://www.youtube.com/watch?v=3QADeUVwJtA
