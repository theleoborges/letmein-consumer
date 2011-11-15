def authenticate!
  redirect "#{ENV["LETMEIN_URL"]}/authenticate?return_to=#{url('/callback')}"
end

before '/protected/*' do
  authenticate! unless session[:user] 
end
