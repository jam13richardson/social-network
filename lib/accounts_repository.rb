require_relative "./accounts"

class AccountsRepository
  def all
    users = []
    sql = "SELECT * FROM accounts;"
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each { |entry| accounts << account_inflate(entry) }
    return accounts
  end

  def find(id)
    sql = "SELECT * FROM accounts WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    entry = result_set[0]
    return user_inflate(entry)
  end

  def create(new_account)
    sql = "INSERT INTO accounts (email, username) VALUES($1, $2);"
    sql_params = [new_account.username, new_account.email]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  def delete(id)
    sql = "DELETE FROM accounts WHERE id = $1;"
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end

  private

  def account_inflate(entry)
    account = Accounts.new
    account.id = entry["id"].to_i
    account.username = entry["username"]
    account.email = entry["email"]
    return account
  end
end