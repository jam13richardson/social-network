require "post_repository"
require "post"

describe PostRepository do
  def reset_social_network_tables
    seed_sql = File.read("spec/sn_seeds.sql")
    connection =
      PG.connect({ host: "127.0.0.1", dbname: "social_network" })
    connection.exec(seed_sql)
  end

  before(:each) { reset_social_network_tables }

  it "gets all posts" do
    repo = PostRepository.new
    all_posts = repo.all
    expect(all_posts.length).to eq 2
    expect(all_posts[0].id).to eq 1
    expect(all_posts[0].title).to eq "Great movies"
    expect(all_posts[0].content).to eq "Shrek, Shrek 2, Shrek 3, Shrek 4"
    expect(all_posts[0].views).to eq 10
    expect(all_posts[1].id).to eq 2
    expect(all_posts[1].title).to eq "Why porridge sucks"
    expect(all_posts[1].content).to eq "Is it just me or do..."
    expect(all_posts[1].views).to eq 9
  end

  it "gets a single post" do
    repo = PostRepository.new
    sing_post = repo.find(1)
    expect(sing_post.id).to eq 1
    expect(sing_post.title).to eq "Great movies"
    expect(sing_post.content).to eq "Shrek, Shrek 2, Shrek 3, Shrek 4"
    expect(sing_post.views).to eq 10
  end

  it "creates a new post" do
    repo = PostRepository.new
    new_post = Post.new
    new_post.title = "What does John Snow know?"
    new_post.content = "Nothing"
    new_post.views = 20
    repo.create(new_post)
    sing_post = repo.find(3)
    expect(sing_post.title).to eq "What does John Snow know?"
    expect(sing_post.content).to eq "Nothing"
    expect(sing_post.views).to eq 20
  end

  it "deletes a post" do
    repo = PostRepository.new
    repo.delete(1)
    all_posts = repo.all
    expect(all_posts[0].id).to eq 2
    expect(all_posts[0].title).to eq "Why porridge sucks"
    expect(all_posts[0].content).to eq "Is it just me or do..."
    expect(all_posts[0].views).to eq 9
  end