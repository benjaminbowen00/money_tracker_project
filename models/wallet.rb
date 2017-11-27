require_relative('../db/sql_runner.rb')

class Wallet
  attr_reader :id
  attr_accessor :monthly_budget, :remaining_budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @monthly_budget = options['monthly_budget'].to_i
    @remaining_budget = options['remaining_budget'].to_i
  end

  def save
    sql = "INSERT INTO wallets (monthly_budget, remaining_budget) VALUES ($1, $2) RETURNING *"
    values = [@monthly_budget, @remaining_budget]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    sql = "UPDATE wallets SET (monthly_budget, remaining_budget)=($1, $2) WHERE id = $3"
    values = [@monthly_budget, @remaining_budget, @id]
  end

  def transaction(transaction)
    @remaining_budget -= transaction.amount.to_i
  end



  def self.find(id)
    sql = "SELECT * FROM wallets where id = $1"
    values = [id]
    wallet = SqlRunner.run(sql, values).first
    return Wallet.new(wallet)
  end


end
