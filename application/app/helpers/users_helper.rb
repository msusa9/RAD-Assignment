module UsersHelper
    def gravatar_for user, options = {size: 50}
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.email, class: "gravatar")
    end

    def recent_users
        recent_users = Array.new(12)
        index = 0
        @users = User.order('login_time DESC')
        @users.each do |user|
            if (index < recent_users.size)
                recent_users[index] = user
                index += 1
            end
        end
        recent_users
    end
            
end
