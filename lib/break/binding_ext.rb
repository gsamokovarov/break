class Binding
  def break
    context = Break::Context.new(self)
    context.start
  end

  def source_location
    eval "[__FILE__, __LINE__.to_i]"
  end unless method_defined?(:source_location)
end
