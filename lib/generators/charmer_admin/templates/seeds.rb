tr = CharmerUtils::TeamRole.create(title: "Admin")
Admin.create(email: "admin@charmer.com", password: "admin@charmer.com", password_confirmation: "admin@charmer.com", team_role_id: tr.id)
