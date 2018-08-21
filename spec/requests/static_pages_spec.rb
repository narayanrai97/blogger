# require 'spec_helper'
require 'rails_helper'

RSpec.describe "Static pages", type: :request do

    describe "Home page" do
  
      it "renders home template" do
        get root_path
        json = JSON.parse(response.body)
        expect(response).to render_template(:home)
        expect(response.status).to eq(200)
        
        expect(json['static_pages']).to contain_exactly('Blogger Me')
      # it { should have_title('Home | Blogger Me App') }
      end
    end
    
    describe "Help page" do 
      
      it "renders help template" do
        get help_path
        expect(response).to render_template(:help)
        expect(response.status).to eq(200)
      # it { should have_title('Help | Blogger Me App') }
      end
    end
    
    describe "About page" do
      
      it "renders an about template" do
        get about_path
        expect(response).to render_template(:about)
        expect(response.status).to eq(200)
      end
      # it { should have_content('About Us') }
      # it { should have_title('About Us | Blogger Me App') }
    end
    
    describe "Contact page" do
      
      it "renders contact template" do
        get contact_path
        expect(response).to render_template(:contact)
        expect(response.status).to eq(200)
      end
      
      # it { should have_content('Contact Us') }
      # it { should have_title('Contact Us | Blogger Me App') }
      # it { should have_link('contact page') }
    end
end
