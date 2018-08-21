require 'rails_helper'

RSpec.describe Article, :type => :model do
    let(:author) { Author.create!(username: "Narayan", 
                                     email: "nara@example.com",
                                     password: "foobar") }
    let(:category) { Category.create!(name: "Social") }
    before { @image = File.new("app/assets/images/rails.png") }
    subject { 
        described_class.new(title: "American Underground", 
                            body: "Is the best in the Triangle.",
                            image: @image,
                            author_id: author.id, 
                            category_id: category.id) 
    }
                                    
    it "is valid with valid attributes" do
       expect(subject).to be_valid 
    end
    
    it "is not valid without a title" do
       subject.title = nil
       expect(subject).to_not be_valid
    end
    
    it "is not valid without a body" do
        subject.body = nil
        expect(subject).to_not be_valid
    end
    
    it "is valid without an image" do
        subject.image = nil
        expect(subject).to be_valid
    end
    
    it "is not valid without an author id" do
        subject.author = nil
        expect(subject).to_not be_valid
    end
    
    it "is not valid without category id" do
        subject.category = nil
        expect(subject).to_not be_valid
    end
end