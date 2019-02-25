require_relative "../lib/booger"

def test_for_next
  result = 42
  result += 1
  binding.booger
  result = sum(result, 2)
  result
  result
  result
end

def test_for_next_with_error_on_the_next_line
  result = 42
  result += 1
  binding.booger
  resutt += 2
  result
end

def sum(a, b)
  a + b
end

puts test_for_next
puts "SUCCESS!"
