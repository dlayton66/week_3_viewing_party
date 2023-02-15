require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  let!(:user1) { User.create(name: "User One", email: "user1@test.com", password: "test", password_confirmation: 'test') }
  
  before do 
    i = 1
    20.times do 
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
      i+=1
    end

    visit login_path
    fill_in :name, with: user1.name
    fill_in :password, with: user1.password
    click_on 'Log In'
  end 

  it 'shows all movies' do 
    visit dashboard_path

    click_button "Find Top Rated Movies"

    expect(current_path).to eq("/movies")

    expect(page).to have_content("Top Rated Movies")
    
    movie_1 = Movie.first

    click_link(movie_1.title)

    expect(current_path).to eq("/movies/#{movie_1.id}")

    expect(page).to have_content(movie_1.title)
    expect(page).to have_content(movie_1.description)
    expect(page).to have_content(movie_1.rating)
  end 
end