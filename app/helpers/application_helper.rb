module ApplicationHelper
  def weekday
    Date.today.strftime("%A")
  end

  def page_title(title = '')
    if !title.empty?
      "#{title} - Linker"
    else
      "Linker"
    end
  end
end
