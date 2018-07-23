module V1
    class Articles < Grape::API
        include V1Base
        include AuthenticateRequest
        
        VALID_PARAMS = %w(title body tag_list category_id author_id published) 
        
        helpers do
            def article_params
                params.select{|key,value| VALID_PARAMS.include?(key.to_s)}
            end
        end
        
        resource :articles do
            
            ## CREATE ARTICLE
            desc 'Create new article', http_codes: [
                { code: 200, message: 'success' },
                { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
            ]
            params do 
               requires :title,        type: String,  desc: 'Title'
               requires :body,         type: String,  desc: 'Body'
               requires :category_id,  type: Integer, desc: 'Category ID'
               optional :tag_list,     type: String,  desc: 'Tag list'
               optional :image,        type: File,    desc: 'Image file'
            end
            post do 
                article = current_user.articles.new(article_params)

                image = params[:image]
                attachment = {
            			filename: image[:filename],
            			type:     image[:type],
            			header:   image[:head],
            			tempfile: image[:tempfile]
        		}
        
        		# This is the kind of File object Grape understands so let's pass the hash to it
        		article.image = ActionDispatch::Http::UploadedFile.new(attachment)
                
                if article.save
                    serialization = ArticleSerializer.new(article)
                    render_success(serialization.as_json)
                else
                    error = article.errors.full_messages.join(', ')
                    render_error(RESPONSE_CODE[:unprocessable_entity], error)
                    return
                end
            end
            
            ## UPDATE ARTICLE
            desc 'Update article', headers: HEADERS_DOCS, http_codes: [
                { code: 200, message: 'success' },
                { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') },
                { code: RESPONSE_CODE[:unprocessable_entity], message: 'Validation error messages' },
                { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
            ]
            params do
               requires :id,          type: Integer, desc: 'Article id' 
               optional :title,       type: String,  desc: 'Title'
               optional :body,        type: String,  desc: 'Body'
               optional :category_id, type: Integer, desc: 'Category id'
               optional :tag_list,    type: String,  desc: 'Tag list'
               optional :published,   type: Boolean, desc: 'Published status' # type: Boolean
            end
            put ':id' do
                authenticate!
                article = Article.find(params[:id]) 
                
                # restricting articles to being updated only by their original owner
                if current_user.id != article.author_id
                  raise error!({ success: false, message: 'not allowed' })
                end
               
                if article.update_attributes(article_params)
                    article.reload
                   
                    serialization = ArticleSerializer.new(article)
                    render_success(serialization.as_json)
                else
                    error = article.errors.full_messages.join(', ')
                    render_error(RESPONSE_CODE[:unprocessable_entity], error)
                    return
                end
            end
            
            ## SHOW ARTICLE
            desc 'Get article', headers: HEADERS_DOCS, http_codes: [
                { code: 200, message: 'success' },
                { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
            ]
            params do 
                requires :id, type: Integer, desc: 'Article id'
            end
            get ':id' do 
                authenticate!
                @article = Article.find(params[:id])
                
                serialization = ArticleSerializer.new(@article)
                render_success(serialization.as_json)
            end
            
            ## INDEX OF ARTICLES
            desc 'Get articles', headers: HEADERS_DOCS, http_codes: [
                { code: 200, message: 'success' },
                { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
            ]
            params do 
               optional :page,     type: Integer, desc: 'page number'
               optional :per_page, type: Integer, desc: 'per_page'
            end
            get do 
                authenticate!
                
                page     = (params[:page] || 1).to_i
                per_page = (params[:per_page] || PER_PAGE).to_i
                articles = Article.order("created_at DESC").paginate(:page => page, :per_page => per_page)

                serialization = ActiveModel::Serializer::CollectionSerializer.new(articles, each_serializer: ArticleSerializer, show_token: false)
                
                render_success({articles: serialization.as_json})
            end
            
            ## DELETE ARTICLE
            desc 'Delete article', headers: HEADERS_DOCS, http_codes: [
                { code: 200, message: 'success' },
                { code: 403, message: 'not allowed' },
                { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
            ]
            params do
                requires :id, type: Integer, desc: 'Article id'
            end
            delete ':id' do
                authenticate!
                article = Article.find(params[:id])
                
                # restricting articles to being destroyed only by their original owner
                if current_user.id != article.author_id
                  raise error!({ code: 403, message: 'not allowed' })
                end
                
                article.destroy
                { code: 200, message: 'success' }
                
            end
            
            ## UPDATE ARTICLE IMAGE
            desc 'Update article image', headers: HEADERS_DOCS, http_codes: [
                { code: 200, message: 'success' },
                { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') },
                { code: RESPONSE_CODE[:unprocessable_entity], message: 'Validation error messages' },
                { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }    
            ]
            params do
                requires :id,    type: Integer, desc: 'Article id'
                requires :image, type: File,    desc: 'Image file'
            end
            put ':id/image_update' do
                authenticate!
            
                article = Article.find params[:id]
                
                # restricting articles image to being updated only by their original owner
                if current_user.id != article.author_id
                  raise error!({ success: false, message: 'not allowed' })
                end
                
                image = params[:image]
                attachment = {
            			filename: image[:filename],
            			type:     image[:type],
            			headers:  image[:head],
            			tempfile: image[:tempfile]
        		}
        
        		# This is the kind of File object Grape understands so let's pass the hash to it
        		processed_image = ActionDispatch::Http::UploadedFile.new(attachment)
        		
        	    if article.update(image: processed_image)
        		    article.reload
                   
                    serialization = ArticleSerializer.new(article)
                    render_success(serialization.as_json)
                else
                    error = article.errors.full_messages.join(', ')
                    render_error(RESPONSE_CODE[:unprocessable_entity], error)
                    return
                end
            end
        end
    end
end