class User < ActiveRecord::Base


  def self.check_if_user_new(number,body)
    # Create user if not in database.
    @body = body
    @number = number
    if User.exists?(:number => @number)
      # Recall user
      @user = User.where(:number => @number).first
      if (@body =~ /^\w+$/) && (@body === "stop")
        #update boolean flag to stop so no one contacts subscriber
        @user.update!(:stop => true)
      elsif (@body =~ /^\w+$/) && (@body === "start")
        #they are back so let's take the flag off so we can contact them
        @user.update!(:stop => false)
      end
    else
      @user = User.create(number: @number)
      if @user.save
        # Welcome user - save complete
        SmsFactory.send_sms(@user.number, WELCOME)
      else
        puts "Error saving"
      end
    end
    puts "This is the new object: #{@user}"
    @user #return the user object
  end

end
