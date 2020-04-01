module DeviseHelper
  def devise_error_messages!
    return "" if @address.errors.empty?

    html = ""
    messages = @address.errors.full_messages.each do |msg|
      html += <<-EOF
      <div class="error_field alert alert-danger" role="alert">
        <p class="error_msg">#{msg}</p>
      </div>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end