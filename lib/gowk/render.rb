module Gowk
  module Render
    
    def run_tag(tag)
      tag.namespace.instance_eval(&tag.body)
    end
    
  end
end