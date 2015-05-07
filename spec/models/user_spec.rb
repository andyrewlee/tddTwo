require 'rails_helper'

describe "A user" do

  it "requires a name" do
    user = User.new(name: "")

    user.valid?

    expect(user.errors[:name].any?).to eq(true)
  end

  it "requires an email" do
    user = User.new(email: "")

    user.valid?

    expect(user.errors[:email].any?).to eq(true)
  end

  it "accepts properly formatted email addresses" do
    emails = ["kobe@lakers.com" , "mitch.kupchack@lakers.com"]

    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end

  end

  it "rejects improperly formatted email addresses" do
    emails = ["@gmail.com", "hello.com"]

    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end

  end

  it "requires a unique email address" do
    user1 = User.create(name: "Kobe", email: "kobe@lakers.com",
                        password: "password", password_confirmation: "password")

    # same password as kobe
    user2 = User.new(name: "Rondo", email: "kobe@lakers.com",
                        password: "connectfour", password_confirmation: "connectfour")

    user2.valid?
    expect(user2.errors[:email].any?).to eq(true)
  end

  it "requires a password" do
    user = User.new(password: "")

    user.valid?

    expect(user.errors[:password].any?).to eq(true)
  end

  it "requires a password confirmation" do
    user = User.new(password: "password", password_confirmation: "")

    user.valid?

    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "requires the password to match the password confirmation" do
    user = User.new(password: "password", password_confirmation: "yolo")

    user.valid?

    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "automatically encrypts the password into the password_digest" do
    user = User.new(password: "password")

    expect(user.password_digest.present?).to eq(true)
  end
end
