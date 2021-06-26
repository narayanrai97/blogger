class Author < ApplicationRecord
  ## Relationships
  has_many :articles
  has_many :author_tokens, dependent: :destroy
  has_one :user

  # default_scope -> { order("created_at DESC") }

  ## Validations
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true, case_sensitive: false


  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "should match confirmation", if: :password

  #does the author have any articles?
  scope :no_articles, -> { left_outer_joins(:articles).where(articles: { id: nil }) }
  scope :admin, -> { where(admin: true) }

   ## Callbacks
  before_save do
    self.email = email.downcase if email_changed?
  end

  ## Methods
  def self.by_auth_token(token)
    author_token = AuthorToken.where(token: token).first
    author_token ? author_token.author : nil
  end

  def login!
    author_tokens.create
  end

end
