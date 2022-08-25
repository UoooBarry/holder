module Replyable
  extend ActiveSupport::Concern

  def comment?
    post_id.blank?
  end

  def reply(user, content)
    comments.create!(user: user,
                     content: content,
                     title: "Re: #{title}",
                     community: community,
                     post: self)
  end
end
