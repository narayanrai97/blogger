class CommentSerializer < ActiveModel::Serializer
    attributes :uid, :article_id, :commenter, :content

    def uid
        object.id
    end
end
