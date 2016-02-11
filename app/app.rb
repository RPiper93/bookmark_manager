ENV["RACK_ENV"] ||= "development"


require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookMarkManager < Sinatra::Base

  get '/' do
    redirect('/links')
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  post '/links' do
    link = Link.new(title: params['Title'], url: params['Link'])
    params['Tags'].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect('/links')
  end

  get '/links/new' do
    erb :links_new
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :links
  end


run! if app_file == $0
end