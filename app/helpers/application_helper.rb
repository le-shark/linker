module ApplicationHelper
  def weekday
    Date.today.strftime("%A")
  end
end
