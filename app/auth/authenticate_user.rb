class AuthenticateUser
    # It is a constructor
    def initialize(email, password)
      @email = email
      @password = password
    end
    
    # On rails if a method is create and does not have a return It will return the last line
    # Service entry point
    def call
      JsonWebToken.encode(user_id: user.id) if user
    end
  
    private
    
    # Lecture access to email and password only. There is a way to give access to change and read
    attr_reader :email, :password
  
    # verify user credentials
    def user
      user = User.find_by(email: email)
      return user if user && user.authenticate(password)
      # raise Authentication error if credentials are invalid
      raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
  end