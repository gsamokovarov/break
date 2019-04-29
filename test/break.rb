require_relative "../lib/break"

binding.break

class Foo
  x = 2
  y = 3
  x + y
end

def test_basic_call
  result = 42
  result += 1
  binding.break
  4.times do
    result = sum(result, 2)
  end
  result = sum(result, 2)
  result += 1
  result
  result
end

def test_crashing_program
  result = 40
  binding.break
  resutt += 2
  result
end

def sum(a, b)
  a + b
end

puts test_basic_call
puts test_crashing_program rescue nil
expression = :unused.to_s + "variable"
puts "END OF RUN"
