module Gowk
  module Contexts
    
    def self.included(klass)
      klass.instance_variable_set('@outputs', {})
      klass.send :attr_accessor, :outputs
    end
    
    def output_for(*contexts, &block)
      if contexts.include?(self.options[:context])
        yield
      end
    end
    
  end
end