class BasicTags < Gowk::Bundle
  
  tag :hello_world do
    'hello world'
  end
  
  tag :i18n_hello_world do
    world = 'hello world '
    
    output_for :default, :english do
      world += 'in english'
    end
    
    output_for :spanish do
      world += 'in espanol'
    end
    
    world
  end
  
  namespace :system do
    
    tag :uname do
      
    end
    
  end
  
end