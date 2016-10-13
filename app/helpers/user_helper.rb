module UserHelper
  def gravatar_for user
    image_tag "avatar.png", alt: user.name, class: "gravatar"
  end
end
