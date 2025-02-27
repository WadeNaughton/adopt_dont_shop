require 'rails_helper'

RSpec.describe 'application creation' do

  it "creates new application" do
    visit '/applications/new'
    expect(page).to have_content('New Application')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip')
    expect(find('form')).to have_content('Description')
    expect(page).to have_button('Save')

  end

  it 'creates the application and redirects to the applications show page' do

    visit '/applications/new'
    fill_in 'Name', with: 'Name1'
    fill_in 'Address', with: '123 test st'
    fill_in 'City', with: 'Bear'
    fill_in 'State', with: 'Delaware'
    fill_in 'Zip', with: '19701'
    fill_in 'Description', with: "this is a description"
    click_button 'Save'
    application = Application.find_by(name:'Name1')
    expect(page).to have_current_path("/applications/#{application.id}")
    expect(page).to have_content('Name1')
    expect(page).to have_content('123 test st')
    expect(page).to have_content('Bear')
    expect(page).to have_content('Delaware')
    expect(page).to have_content('19701')
    expect(page).to have_content("this is a description")
  end

  context 'given invalid data' do
      it 're-renders the new form' do
        visit '/applications/new'
        fill_in "Name", with: "tester"
        click_button 'Save'
        expect(page).to have_current_path('/applications/new')
        expect(page).to have_content("Error: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zip can't be blank, Description can't be blank")
      end
    end
end
