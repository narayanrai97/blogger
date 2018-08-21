require 'rails_helper'
require 'spec_helper' #added

RSpec.describe "AuthorPages", :type => request do

  subject { page }
  
  describe "signup page" do
    
    before { visit '/' }
    
    it { should have_content('Sign up now!') }
  end
end
