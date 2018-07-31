require 'spec_helper'

describe "Static pages" do
  
  let(:base_title) { "Blogger Me App" } # Let queries the database once, and then saves the base_title object locally

  describe "Home page" do

    it "should have the content 'Blogger Me'" do
      visit '/'
      page.should have_content('Blogger Me')
    end
    
    it "should have the title 'Home'" do 
      visit '/'
      page.should have_title("Home | #{base_title}")
    end
  end
  
  describe "Help page" do 
    
    it "should have the content 'Help'" do
      visit '/help'
      page.should have_content('Help')
    end
    
    it "should have the title 'Help'" do
      visit '/help'
      page.should have_title("Help | #{base_title}")
    end
  end
  
  describe "About page" do
    
    it "should have the content 'About Us'" do
      visit '/about'
      page.should have_content('About Us')
    end
    
    it "should have the title 'About Us'" do
      visit '/about'
      page.should have_title("About Us | #{base_title}")
    end
  end
  
  describe "Contact page" do 
    
    it "should have the content 'Contact Us'" do
      visit '/contact'
      page.should have_content('Contact Us')
    end
    
    it "should have the title 'Contact Us'" do
      visit '/contact'
      page.should have_title("Contact Us | #{base_title}")
    end
    
    it "should have a link" do 
      visit '/contact'
      page.should have_content("Contact the Blogger Me App about the sample app at the contact page.")
      # find(:link, 'contact page').click
      page.should have_link('contact page')
    end
    
  end
end