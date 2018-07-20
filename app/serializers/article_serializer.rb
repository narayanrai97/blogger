class ArticleSerializer < ActiveModel::Serializer
   attributes :uid, :author_id, :title, :body, :category_id, :tag_list, :image, :published

    def uid
        object.id
    end
end
