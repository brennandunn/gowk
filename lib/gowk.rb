$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'gowk/contexts'
require 'gowk/tags'
require 'gowk/namespaces'
require 'gowk/bundle'
require 'gowk/render'

module Gowk
  
  def self.render_tag(tag, options = {})
    tag = Gowk::Bundle.find_tag(tag)
    tag.invoke(options)
  end
  
end