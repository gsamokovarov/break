class Binding
  def break
    context = Break::Context.new(self)
    context.start
  end
end
