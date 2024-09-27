class User
    attr_accessor :name, :email, :password
  
    def initialize(name, email, password)
      @name = name
      @password = password
      @rooms = []
    end
  
    def enter_room(room)
      @rooms << room
      room.users << self
      puts "#{name} entered the room: #{room.name}"
    end
  
    def send_message(room, content)
      message = Message.new(self, room, content)
      room.broadcast(message)
    end
  
    def acknowledge_message(room, message)
      puts "#{name} acknowledged message in #{room.name}: #{message.content}"
    end
  end
  

  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
  
    def broadcast(message)
      users.each do |user|
        puts "#{user.name} received message: #{message.content} from #{message.user.name}"
        user.acknowledge_message(self, message)
      end
    end
  end
  
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  

  # Example 
  user1 = User.new("123", "123@gmail.com", "password123")
  user2 = User.new("456", "456@gmail.com", "password456")
  
  room = Room.new("General", "A general discussion room")
  
  user1.enter_room(room)
  user2.enter_room(room)
  
  user1.send_message(room, "Hello, everyone!")
  