module ApplicationHelper
  
  def can?(*args)
    false
  end
  
  def link_if_can(*args, &block)
    ""
  end
  
  def current_user
    nil
  end
  
end
