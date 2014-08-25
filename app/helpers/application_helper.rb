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
  
  def avatar_url(user)
    #default = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=200" #&d=#{CGI.escape(default)}"
  end

end
