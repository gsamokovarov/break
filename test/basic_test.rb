require_relative "../lib/boogah"

binding.boogah

class Foo
  x = 2
  y = 3
  x + y
end

def test_for_next
  result = 42
  result += 1
  binding.boogah
  result = sum(result, 2)
  result += 1
  result
  result
end

def test_for_next_with_error_on_the_next_line
  result = 42
  binding.boogah
  result += 1
  resutt += 2
  result
end

def sum(a, b)
  a + b
end

puts test_for_next
a = 1 + 2
puts "SUCCESS!"
