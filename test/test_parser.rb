require File.dirname(__FILE__) + '/test_helper.rb'

class TestParser < Test::Unit::TestCase
  
  context 'parsing a string' do
    
    context 'individual tags' do
      
      should 'parse a single tag' do
        output = Gowk.parse('Welcome to the { PageTitle }')
        assert_equal 'Welcome to the Home Page', output
      end
    
      should 'parse a tag with compounders' do
        output = Gowk.parse('{ PageTitle downcase reverse }')
        assert_equal 'egap emoh', output
      end
      
    end
        
  end
  
end