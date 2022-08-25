RSpec.describe PublishPostService do
  let!(:user) { create(:user) }
  let!(:community) { create(:community) }

  it 'cannot publish a post if user does not subscirbe' do
    params = {
      community_id: community.id,
      title: 'Title',
      content: 'Content'
    }

    expect { PublishPostService.call(user, params) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'can publish a post' do
    user.subscribe!(community)

    params = {
      community_id: community.id,
      title: 'Title',
      content: 'Content'
    }

    @post = PublishPostService.call(user, params)

    expect(@post).to be_valid
  end
end
