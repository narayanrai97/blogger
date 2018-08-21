require 'rails_helper'

RSpec.describe Author, :type => :model do
    subject { 
        described_class.new(username: "Bindu", 
                            email:    "bindu@example.com") 
    }
    
    describe "Validations" do
        
        it 'is valid with valid attributes' do
            expect(subject).to be_valid
        end
            
        it 'is not valid without a username' do
            subject.username = nil
            expect(subject).to_not be_valid 
        end
        
        it 'is not valid without an email' do
            subject.email = nil
            expect(subject).to_not be_valid
        end
    end
end
