# frozen_string_literal: true

class Binding
  unless method_defined?(:source_location)
    def source_location
      eval "[__FILE__, __LINE__.to_i]"
    end
  end
end
