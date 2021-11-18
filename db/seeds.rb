User.destroy_all
Grudge.destroy_all

yannick = User.create!(username: "Yannickounet", email: "pirminfly@web.de", password: "123456")
yannick.photo.attach(io: File.open(Rails.root.join('app/assets/images/yannick.jpeg')), filename: 'yannick.jpeg', content_type: 'image/png')
yannick.save
claire = User.create!(username: "Clarinette", email: "clarinette@web.de", password: "123456")
claire.photo.attach(io: File.open(Rails.root.join('app/assets/images/claire.jpeg')), filename: 'claire.jpeg', content_type: 'image/png')
claire.save

CATEGORIES = ["sex", "family", "food", "chores", "hygiene" ]
#  1 to 100
Grudge.create(name: "Not doing the dishes", category: "chores", points: rand(1..100) )
Grudge.create(name: "Leaving the toilet seat up/down", category: "hygiene", points: rand(1..100) )
Grudge.create(name: "Toothpaste left opened", category: "hygiene", points: rand(1..100) )
Grudge.create(name: "Insulting Mom-in-law", category: "family", points: rand(1..100) )
Grudge.create(name: "Coffee Breath", category: "hygiene", points: rand(1..100) )
Grudge.create(name: "Hair left in the drain", category: "hygiene", points: rand(1..100) )
Grudge.create(name: "Finger in the butt without asking", category: "sex", points: rand(1..100) )
Grudge.create(name: "Too much nipple play", category: "sex", points: rand(1..100) )
Grudge.create(name: "Saying the wrong name", category: "sex", points: rand(1..100) )
Grudge.create(name: "Faking orgasm", category: "", points: rand(1..100) )
Grudge.create(name: "Preventing me to reach my full potential", category: "life", points: rand(1..100) )
Grudge.create(name: "Ruining my life", category: "life", points: rand(1..100) )
Grudge.create(name: "Suggesting a threesome (and pretenting it was a joke", category: "sex", points: rand(1..100) )
Grudge.create(name: "Suggesting a threesome, again", category: "sex", points: rand(1..100) )
Grudge.create(name: "Forgot birthday", category: "life", points: rand(1..100) )
Grudge.create(name: "Chewing with open mouth", category: "food", points: rand(1..100) )
