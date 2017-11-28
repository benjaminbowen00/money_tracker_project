require('pry-byebug')
require('sinatra')
require('sinatra/reloader')

require_relative('../models/category.rb')
require_relative('../models/shop.rb')
require_relative('../models/transaction.rb')
require_relative('../models/wallet.rb')

get '/wallets' do
  @wallet = Wallet.find(1)
  @wallet.update
  erb (:'wallet_views/wallets')
end


get '/wallets/edit' do
  @wallet = Wallet.find(1)
  erb (:'wallet_views/wallet_edit')
end

put '/wallets' do
  @wallet = Wallet.find(1)
  @wallet.update_budget(params[:budget].to_i)
  @wallet.update
  redirect to '/wallets'
end

get '/wallets/add' do
  @wallet = Wallet.find(1)
  erb (:'wallet_views/wallet_add')
end

put '/wallets/add' do
  @wallet = Wallet.find(1)
  changed_budget = @wallet.add_or_sub(params)
  @wallet.update_budget(changed_budget)
  redirect to '/wallets'
end
