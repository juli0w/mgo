module LoginHelper
  def login user, password
    visit '/login'
    within("#new_user") do
      fill_in 'user[email]', with: user
      fill_in 'user[password]', with: password
    end

    click_button 'Login'
  end

  def logout
    visit root_url
    first(:link, 'Logout').click
  end
end
