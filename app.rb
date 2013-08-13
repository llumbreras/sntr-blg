# app.rb
#

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './environments'

enable :sessions

get "/" do
	@posts = Post.order("created_at DESC")
	@title = "Welcome"
	erb :"posts/index"
end

post "/posts" do 
	@post = Post.new(params[:id])
	if @post.save
		redirect "posts/#{@post.id}"
	else
		erb :"posts/create"
	end
end

get "/posts/create" do 
	@title = "Create Post"
	@post = Post.new
	erb :"posts/create"
end


get "/posts/:id" do 
	@post = Post.find(params[:id])
	@title = @post.title
	erb :"posts/view"
end


helpers do 
	def title
		if @title
			"#{@title}"
		else
			"Welcome"
		end
	end
end

class Post < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true
end

