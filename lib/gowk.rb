$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'gowk/contexts'
require 'gowk/tags'
require 'gowk/namespaces'
require 'gowk/bundle'
require 'gowk/render'
require 'gowk/parser'

module Gowk
  
  def self.render_tag(*attrs)
    options = attrs.last.is_a?(::Hash) ? attrs.pop : {}
    tag = Gowk::Bundle.find_tag(attrs) or raise ArgumentError, "cannot find tag: #{attrs}"
    tag.invoke(options)
  end
  
  def self.parse(string, options = {})
    Gowk::Parser.new(string, options).to_s
  end
    
end