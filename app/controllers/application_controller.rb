
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # index (read all) 
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # new (form)
  get "/articles/new" do
      erb :new
  end

  # create (from form)
  post "/articles" do
    @article = Article.create(title: params[:title], content: params[:content])
    # @article.title = params[:title]
    # @article.content = params[:content]
    # @article.save
    redirect to "/articles/#{@article.id}"
  end

  # show (read by id)
  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  # edit (form)
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  # update 
  patch '/articles/:id' do
    # binding.pryexit
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    @article.save
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect "/articles"
  end

end
