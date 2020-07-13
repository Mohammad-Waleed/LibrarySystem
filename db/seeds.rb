Library.destroy_all
Admin.destroy_all

Library.create(id: 1, fine: 10)
Library.create(id: 2, fine: 15)

Admin.create(library_id: 1, email: 'admin1@gmail.com', password: 'password', password_confirmation: 'password')
Admin.create(library_id: 2, email: 'admin2@gmail.com', password: 'password', password_confirmation: 'password')
