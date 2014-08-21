module ApplicationHelper
  def flash_class name
    # Translate rails conventions to bootstrap conventions
    case name.to_sym
    when :notice
      :success
    when :alert
      :error
    else
      name
    end
  end

  def company_display
    if current_user.company
      current_user.company.name
    else
      "No Company"
    end
  end
end
