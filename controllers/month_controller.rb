require('pry-byebug')
require('sinatra')
require('sinatra/reloader')
require_relative('../models/category.rb')
require_relative('../models/shop.rb')
require_relative('../models/transaction.rb')
require_relative('../models/wallet.rb')
require_relative('../models/date_month.rb')



get '/months' do
  @date = DateMonth.new
  @months_array = @date.last_six_months
  erb (:'month_views/months')
end

get'/months/:year_id/:month_id/transactions' do
  @transactions = Transaction.transactions_by_month_number(params['year_id'].to_i, params['month_id'].to_i)
  @monthly_spend = Transaction.total_by_month(params['year_id'].to_i, params['month_id'].to_i)

  @month_name = DateMonth.find_month_name(params)
  erb(:'month_views/month_transactions')
end
