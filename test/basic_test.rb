require_relative "../lib/boogah"

def test_for_next
  result = 42
  result += 1
  binding.boogah
  result = sum(result, 2)
  result
  result
  result
end

def test_for_next_with_error_on_the_next_line
  result = 42
  result += 1
  binding.boogah
  resutt += 2
  result
end

def sum(a, b)
  a + b
end

puts test_for_next
puts "SUCCESS!"
