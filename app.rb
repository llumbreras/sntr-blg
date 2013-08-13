# app.rb
#

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

get "/" do
	@posts = Post.order("created_at DESC")
	@title = "Welcome"
	erb :"posts/index"
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
end

