
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

namespaces = [
  {
    name: 'main',
    access: 'public'
  },

  {
    name: 'meta',
    title: 'Meta',
  },

  {
    name: 'sandbox',
    title: 'Sandbox',
  },

  {
    name: 'drafts',
    title: 'Drafts',
    access: 'private'
  }
]

Namespace.create! namespaces if Namespace.all.count == 0
