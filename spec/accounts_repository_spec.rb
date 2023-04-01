require "accounts_repository"
require "accounts"

describe AccountsRepository do
  def reset_social_network_tables
    seed_sql = File.read("spec/sn_seeds.sql")
    connection =
      PG.connect({ host: "127.0.0.1", dbname: "social_network" })
    connection.exec(seed_sql)
  end

  before(:each) { reset_social_network_tables }

  it "Gets all users" do
    repo = UserRepository.new
    all_users = repo.all
    expect(all_users.length).to eq 2
    expect(all_users[0].id).to eq 1
    expect(all_users[0].username).to eq "Jamie"
    expect(all_users[0].email).to eq "jamie@richardson.com"
    expect(all_users[1].id).to eq 2
    expect(all_users[1].username).to eq "Bella"
    expect(all_users[1].email).to eq "Bella@Vita.com"
  end

  it "gets a single user when passed id" do
    repo = UserRepository.new
    sing_user = repo.find(1)
    expect(sing_user.id).to eq 1
    expect(sing_user.username).to eq "Jamie"
    expect(sing_user.email).to eq "jamie@richardson.com"
  end

  it "creates a new user" do
    repo = UserRepository.new
    new_user = User.new
    new_user.username = "Frodo"
    new_user.email = "frodo@fellowship.co.uk"
    repo.create(new_user)
    sing_user = repo.find(3)
    expect(sing_user.id).to eq 3
    expect(sing_user.username).to eq "Frodo"
    expect(sing_user.email).to eq "frodo@fellowship.co.uk"
  end

  it "deletes a user" do
    repo = UserRepository.new
    repo.delete(1)
    all_users = repo.all
    expect(all_users[0].id).to eq 2
    expect(all_users[0].username).to eq "Bella"
    expect(all_users[0].email).to eq "Bella@Vita.com"
  end
end