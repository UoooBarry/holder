RSpec.describe Jwt::IssueService do
  before(:each) do
    @user = User.create!(email: 'test@test.com',
                         username: 'uooobarry',
                         password: 'pwd123123',
                         bio: 'Hello world',
                         gender: User.genders[:male],
                         age: 22)
  end

  context 'when login' do
    it 'can generate a user jwt token' do
      token, _exp = Jwt::IssueService.call(@user)

      expect(token).not_to be(nil)
    end
  end

  context 'sending requests' do
    it 'can be decoded to user payload' do
      token, _exp = Jwt::IssueService.call(@user)

      decoded = JsonWebToken.decode(token)

      expect(decoded[:username]).equal?(@user.to_payload[:username])
    end
  end
end
