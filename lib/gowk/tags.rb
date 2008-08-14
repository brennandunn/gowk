module Gowk
  module Tags
    
    @@tags = {}
    
    def tags ; @@tags ; end
    
    def tag(name, options = {}, &block)
      name = name.to_sym
      raise ArgumentError, 'expected a block' unless block_given?
      
      tags[name] = Tag.new(name, options, self, &block)
      metaclass = class << self; self; end
      metaclass.send(:define_method, name) { run_tag(tags[name]) }
    end
    
    class Tag
      include Contexts
      attr_accessor :name, :tag_options, :parent, :block, :options
      PRESERVED_IVARS = ['@name', '@tag_options', '@parent', '@block', '@options']
      
      def initialize(name, tag_options, parent, &block)
        self.name = name
        self.tag_options = tag_options
        self.parent = parent
        self.block = block or raise ArgumentError, 'tag requires a block'
      end
      
      def full_name
        prefix = parent.respond_to?(:full_name) ? parent.full_name : nil
        [prefix, name.to_s].compact.join(':')
      end
      
      def invoke(options = {})
        self.options = { :context => :default }.merge!(options)
        execute_callbacks(:before)
        instance_eval(&block)
      end
      
      
      private
      
      def execute_callbacks(key)
        return unless tag_options[key]
        [tag_options[key]].flatten.each do |callback|
          tag = parent.tags[callback.to_sym]
          if tag
            tag.invoke(options)
            copy_instance_variables(tag, self)
          end
        end
      end
      
      def copy_instance_variables(origin, receiver)
        (origin.instance_variables - PRESERVED_IVARS).each do |ivar|
          receiver.instance_variable_set(ivar, origin.instance_variable_get(ivar))
        end
      end
      
    end
    
  end
end