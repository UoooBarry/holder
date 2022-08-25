# 置顶功能
module Pinable
  extend ActiveSupport::Concern

  def pin!
    update!(pin: !pin)

    pin
  end
end
