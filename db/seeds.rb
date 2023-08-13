User.find_or_create_by(uid: "81127029228635340891") do |user|
  user.provider = "guest"
  user.name = "Guest User"
  user.email = "guest@user.com"
end
