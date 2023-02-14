require 'rails_helper'

RSpec.describe 'login page' do
  it "can't log in with bad password" do
    user = User.create(name: 'funbucket13', email: 'funbucket13@mrbucket.com', password: 'test')

    visit login_path

    fill_in :name, with: user.name
    fill_in :password, with: "incorrect password"

    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Sorry, your credentials are bad.')
  end

  it "can't log in with bad username" do
    user = User.create(name: 'funbucket13', email: 'funbucket13@mrbucket.com', password: 'test')

    visit login_path

    fill_in :name, with: "Drew" 
    fill_in :password, with: 'test'

    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Sorry, your credentials are bad.')
  end
end