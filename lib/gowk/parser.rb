module Gowk
  class Parser
    TagName = /([\w:]+)/
    Compounders = /([\w\s]*?)/
    QuotedAttribute = /"[^"]*?"|'[^']*?'|\w+/
    Attributes = /((?:\w+\s*\:\s*(?:#{QuotedAttribute})\s*)*)/
    RE = /\{\s*#{TagName}\s*#{Compounders}\s*#{Attributes}\s*\}|\{\s*\/#{TagName}\s*\}/
    
    attr_accessor :string, :options, :tag_stack
    
    def initialize(string, options)
      self.string, self.options = string, options
      self.tag_stack = []
      translate
    end
    
    def to_s
      string
    end
    
    
    private
    
    def translate
      while results = parse(string)
        if end_results = parse(results[:remaining])
          # this is a block tag
          end_cursor = results[:remaining].index(end_results[:match])
          replacement = [results[:match], results[:remaining][0...end_cursor], end_results[:match]].join
          self.string.gsub!(replacement, render_tag(results))
        else
          # this is a single tag
          self.string.gsub!(results[:match], render_tag(results))
        end
      end
    end
    
    def render_tag(options)
      result = Gowk.render_tag(options[:start_tag])
      options[:compounders].inject(result) { |s, met| s = s.send(met.to_sym) }
    end
    
    def parse(text)
      if md = RE.match(text)
        start_tag, compounders, attributes, end_tag = $1, $2, $3, $4
        remaining = md.post_match
        { :start_tag => start_tag, :compounders => split_to_array(compounders), 
          :attributes => attributes, :end_tag => end_tag, :remaining => remaining, :match => $& }
      end
    end
    
    def split_to_array(string)
      return [] unless string
      string.strip.split(' ')
    end
    
  end
end