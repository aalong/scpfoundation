
# Community user
community = {
  username: 'Community',
  password: '682mustbefree',
  password_confirmation: '682mustbefree',
  email: 'robot@scpfoundation.net',
  real_name: 'Administrative Robot',
  reputation:  30000
}

User.create!(community) if User.where(username: 'community').count == 0
