module MailersHelper

  def format_time(t)
    #Example: Feb. 4, 2010, at 7:30 p.m. EST
    return t.strftime("%b. %e, %Y, at %l:%M %P")
  end


end
