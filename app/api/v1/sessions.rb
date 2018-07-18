module V1
  class Sessions < Grape::API
    include V1Base
    include AuthenticateRequest

    resource :sessions do

      desc 'Authenticate author and return author object / access token', http_codes: [
        { code: 200, message: 'success'},
        { code: RESPONSE_CODE[:unauthorized], message: I18n.t('errors.session.invalid') }
      ]
      params do
        requires :email, type: String, desc: 'Author email'
        requires :password, type: String, desc: 'Author Password'
      end

      post do
        email = params[:email]
        password = params[:password]
        if email.nil? or password.nil?
          render_error(RESPONSE_CODE[:unauthorized], I18n.t('errors.session.invalid'))
          return
        end

        author = Author.where(email: email.downcase).first
        if author.nil? || !author.valid_password?(password)
          render_error(RESPONSE_CODE[:unauthorized], I18n.t('errors.session.invalid'))
          return
        end

        a_token = author.login!
        serialization = AuthorSerializer.new(author, {show_token: true, token: a_token.token})

        render_success(serialization.as_json)
      end


      desc 'Destroy the access token', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:unauthorized], message: I18n.t('errors.session.invalid_token') }
      ]
      delete do
        authenticate!

        auth_token = headers['Authorization']
        author_token = AuthorToken.where(token: auth_token).first

        if author_token.nil?
          render_error(RESPONSE_CODE[:unauthorized], I18n.t('errors.session.invalid_token'))
          return
        else
          author_token.destroy
          render_success({})
        end
      end
    end
  end
end
