module ConversationsHelper
  def recipients_options(chosen_recipient = nil)
  s = ''
  User.all.each do |user|
    s << "<option value='#{user.id}' data-img-src='#{user.image_url(size: 50)}' #{'selected' if user == chosen_recipient}>#{user.name}</option>"
  end
  s.html_safe
end
end
