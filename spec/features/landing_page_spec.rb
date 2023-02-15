require 'rails_helper'

RSpec.describe 'Landing Page' do
  let!(:user1) { User.create(name: "Drew", email: "user1@test.com", password: "test", password_confirmation: 'test') }
  let!(:user2) { User.create(name: "Mike", email: "user2@test.com", password: "test", password_confirmation: 'test') }

  it 'has a header' do
    visit root_path

    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    visit '/'

    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'

    click_link "Home"
    expect(current_path).to eq(root_path)
  end

  describe 'logged in' do
    before do
      visit root_path

      click_link 'Log In'
  
      expect(current_path).to eq(login_path)
  
      fill_in :name, with: user1.name
      fill_in :password, with: user1.password
  
      click_on 'Log In'
    end

    it 'lists out existing users' do
      expect(page).to have_content('Existing Users:')
  
      within('.existing-users') do 
        expect(page).to have_content(user1.email)
        expect(page).to have_content(user2.email)
      end   
    end
  
    it 'allows a user to log in' do
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{user1.name}!")
    end
  end

end
