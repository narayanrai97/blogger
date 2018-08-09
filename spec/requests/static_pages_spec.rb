require 'spec_helper'

describe "Static pages" do
  subject { page }
  
  describe "Home page" do
    before { visit '/' }
    
    it { should have_content('Blogger Me') }
    
    it { should have_title(full_title('Home')) }
  end
  
  describe "Help page" do 
    before { visit '/help' }
    
    it { should have_content('Help') }
    
    it { should have_title(full_title('Help')) }
  end
  
  describe "About page" do
    before { visit '/about' }
    
    it { should have_content('About Us') }
    
    it { should have_title(full_title('About Us')) }
  end
  
  describe "Contact page" do 
    before { visit '/contact' }
    
    it { should have_content('Contact Us') }
    
    it { should have_title(full_title('Contact Us')) }
    
    it { should have_content("Contact the Blogger Me App about the sample app at the contact page.") }
      
    it { should have_link('contact page') }
  end
end