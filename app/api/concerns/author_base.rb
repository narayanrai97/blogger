module AuthorBase
  extend ActiveSupport::Concern

  included do

    helpers do
      def get_author(id)
        @author = Author.find(id)

        unless @author
          raise ApiException.new(
            http_status: RESPONSE_CODE[:not_found],
            code: RESPONSE_CODE[:not_found],
            message: I18n.t('errors.author.not_found')
          )
        end
      end

      def can_update_author?(id)
        unless current_user.id.to_s == params[:id]
          raise ApiException.new(
            http_status: RESPONSE_CODE[:forbidden],
            code: RESPONSE_CODE[:forbidden],
            message: I18n.t('errors.forbidden')
          )
        end
      end
    end
  end
end
