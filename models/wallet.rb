require_relative('../db/sql_runner.rb')

class Wallet
  attr_reader :id, :monthly_budget, :remaining_budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @monthly_budget = options['monthly_budget']
    @remaining_budget = options['remaining_budget']
  end

  def save
    sql = "INSERT INTO wallets (monthly_budget, remaining_budget) VALUES ($1, $2) RETURNING *"
    values = [@monthly_budget, @remaining_budget]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end


end
