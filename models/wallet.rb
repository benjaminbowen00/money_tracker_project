require_relative('../db/sql_runner.rb')

class Wallet
  attr_reader :id
  attr_accessor :budget, :spend

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @budget = options['budget'].to_i
    @spend = options['spend'].to_i
  end

  def save
    sql = "INSERT INTO wallets (budget, spend) VALUES ($1, $2) RETURNING *"
    values = [@budget, @spend]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end


  def update
    sql = "SELECT SUM(amount) FROM transactions"
    @spend = SqlRunner.run(sql).first['sum']
  end


  def self.find(id)
    sql = "SELECT * FROM wallets where id = $1"
    values = [id]
    wallet = SqlRunner.run(sql, values).first
    return Wallet.new(wallet)
  end

end
