class Binding
  def break
    session = Break::Session.new(self, frontend: Break::Frontend.new)
    session.enter
  end

  def source_location
    eval "[__FILE__, __LINE__.to_i]"
  end unless method_defined?(:source_location)
end
