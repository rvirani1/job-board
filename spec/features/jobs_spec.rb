require 'spec_helper'

feature 'Jobs' do
  let(:user) { create :user }

  it 'lets an unregistered user looks at the jobs index' do
    visit root_path
    expect(page).to have_content 'All Jobs' 
  end

end
