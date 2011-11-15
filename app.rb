require 'sinatra'
require File.join(File.dirname(__FILE__), 'plugins','letmein')

enable :sessions

get '/' do
  session[:user] = nil
  "Try going <a href='#{url("/protected/index")}'>here</a>"
end

get '/protected/index' do
  "#{session[:flash]}<p>This is secret stuff. I sure hope you're logged in.</p>"
end

get '/callback' do
  if params[:status] == "ok"
    session[:user] = params[:user]
    session[:flash] = "Welcome #{params[:user]}"
    redirect to('/protected/index')
  else
    status 401
    body "You don't have the right to be here. Get out!"
  end
end