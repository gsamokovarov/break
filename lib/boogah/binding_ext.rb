class Binding
  def boogah
    inspector = Boogah::Inspector.new(self)
    inspector.start
  end
end
