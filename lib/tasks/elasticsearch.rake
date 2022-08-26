namespace :elasticsearch do
  desc 'Import posts'
  task import_posts: :environment do
    Post.import
  end
end
