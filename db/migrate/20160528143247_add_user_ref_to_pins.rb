class AddUserRefToPins < ActiveRecord::Migration
  def change
    add_reference :pins, :user, index: true
    add_foreign_key :pins, :users
	
	user = User.create(
		first_name: "Jimmy",
		last_name: "Johns",
		email: "jjohns@skillcrush.com",
		password: "j1mmy"
	)
	
	if user.present?
		Pin.all.each do |pin|
			pin.user = user
			pin.save
		end
	else
		puts "User not present"
	end
  end
end
