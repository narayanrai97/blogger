require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Blogger Me'" do
      visit '/'
      page.should have_content('Blogger Me')
    end
    
    it "should have the title 'Home'" do 
      visit '/'
      page.should have_title("Home | Blogger Me App")
    end
  end
  
  describe "Help page" do 
    
    it "should have the content 'Help'" do
      visit '/help'
      page.should have_content('Help')
    end
    
    it "should have the title 'Help'" do
      visit '/help'
      page.should have_title("Help | Blogger Me App")
    end
  end
  
  describe "About page" do
    
    it "should have the content 'About Us'" do
      visit '/about'
      page.should have_content('About Us')
    end
    
    it "should have the title 'About Us'" do
      visit '/about'
      page.should have_title("About Us | Blogger Me App")
    end
  end
  
  describe "Contact page" do 
    
    it "should have the content 'Contact Us'" do
      visit '/contact'
      page.should have_content('Contact Us')
    end
    
    it "should have the title 'Contact Us'" do
      visit '/contact'
      page.should have_title("Contact Us | Blogger Me App")
    end
  end
end