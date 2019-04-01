class Binding
  def boogah
    context = Boogah::Context.new(self)
    context.start
  end
end
