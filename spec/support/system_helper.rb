module SystemHelper
  def login(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'ログイン'
    
    # ログイン後のリダイレクトを確認
    expect(page).to have_content('ログインしました')
    expect(current_path).to eq(root_path)
  end
end

RSpec.configure do |config|
  config.include SystemHelper, type: :system
end