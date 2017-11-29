require('pry-byebug')
require('sinatra')
require('sinatra/reloader')

require_relative('../models/category.rb')
require_relative('../models/shop.rb')
require_relative('../models/transaction.rb')
require_relative('../models/wallet.rb')


get '/shops' do
  @shops = Shop.all()
  @wallet = Wallet.find(1)
  @wallet.update
  erb (:'shop_views/shops')
end

get '/shops/:id/transactions' do
  @shop = Shop.find(params[:id])
  @transactions = Shop.shop_transactions(params[:id])
  erb (:'shop_views/shop_transactions')
end

get '/shops/:id/edit' do
  @shop = Shop.find(params[:id])
  erb (:'shop_views/shop_edit')
end

put '/shops/:id' do
  Shop.new(params).update
  redirect to '/shops'
end

delete '/shops/:id' do
  Shop.new(params).delete
  redirect to '/shops'
end

get '/shops/:id/warning' do
  @shop = Shop.find(params[:id])
  @transactions = Shop.shop_transactions(params[:id])
  erb (:'shop_views/shop_warning')
end

get '/shops/new' do
  erb (:'shop_views/shop_new')
end

post '/shops' do
  shop = Shop.new(params).save
  redirect to '/shops'
end
