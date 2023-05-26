account = Account.create(name: "MainUser")
friend = Account.create(name: "FriendUser")

account.follow(friend)

Post.create(body: "Hello, world!", account: account)
