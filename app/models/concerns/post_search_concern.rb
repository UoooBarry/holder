module PostSearchConcern
  extend ActiveSupport::Concern
  included do
    mapping do
      indexes :title, type: :text
      indexes :content, type: :text
    end
  end
end
