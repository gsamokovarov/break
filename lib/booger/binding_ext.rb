class Binding
  def booger
    inspector = Booger::Inspector.new(self)
    inspector.start
  end
end
