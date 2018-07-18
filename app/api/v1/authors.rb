module V1
  class Authors < Grape::API
    include V1Base
    include AuthenticateRequest
    include AuthorBase

    VALID_PARAMS = %w(username email password password_confirmation)

    helpers do
      def author_params
        params.select{|key,value| VALID_PARAMS.include?(key.to_s)}
      end
    end

    resource :authors do

      desc 'Create new author', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
      ]
      params do
        requires :username, type: String, desc: 'Username'
        requires :email, type: String, desc: 'Author email'
        requires :password, type: String, desc: 'Author Password'
        requires :password_confirmation, type: String, desc: 'Author Password'
      end
      post do
        author = Author.new(author_params)
        if author.save
          a_token = author.login!

          serialization = AuthorSerializer.new(author, {show_token: true, token: a_token.token})
          render_success(serialization.as_json)
        else
          error = author.errors.full_messages.join(', ')
          render_error(RESPONSE_CODE[:unprocessable_entity], error)
          return
        end
      end


      desc 'Update author', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') },
        { code: RESPONSE_CODE[:unprocessable_entity], message: 'Validation error messages' },
        { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
      ]
      params do
        requires :id, type: String, desc: 'Author id'
        optional :email, type: String, desc: 'Author email'
        optional :password, type: String, desc: 'Author Password'
        optional :password_confirmation, type: String, desc: 'Author Password confirmation'

        optional :username, type: String, desc: 'Username'
      end
      put ':id' do
        authenticate!
        can_update_author?(params[:id])

        if current_user.update_attributes(author_params)
          current_user.reload

          serialization = AuthorSerializer.new(current_user, {show_token: false})
          render_success(serialization.as_json)
        else
          error = current_user.errors.full_messages.join(', ')
          render_error(RESPONSE_CODE[:unprocessable_entity], error)
          return
        end
      end

      desc 'Get author', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
      ]
      params do
        requires :id, type: String, desc: 'Author id'
      end
      get ':id' do
        authenticate!
        get_author(params[:id])

        serialization = AuthorSerializer.new(@author, {show_token: false})
        render_success(serialization.as_json)
      end


      desc 'Get authors', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      params do
        optional :page, type: Integer, desc: 'page'
        optional :per_page, type: Integer, desc: 'per_page'
      end
      get do
        authenticate!

        page = (params[:page] || 1).to_i   
        per_page = (params[:per_page] || PER_PAGE).to_i   

        # authors = Author.order("created_at DESC").page(page).per(per_page)
        authors = Author.order("created_at DESC").paginate(:page => page, :per_page => per_page)

        serialization = ActiveModel::Serializer::CollectionSerializer.new(authors, each_serializer: AuthorSerializer, show_token: false)

        render_success({authors: serialization.as_json})
      end
    end
  end
end

