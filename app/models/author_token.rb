class AuthorToken < ApplicationRecord
    has_secure_token :token

    ## Relationships
    belongs_to :author
end
