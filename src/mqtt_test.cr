require "mqtt/v3/client"
require "option_parser"
require "json"

mqtt_host : String = "broker.emqx.io"
mqtt_port : Int32 = 1883
clients_number : Int32 = 10
client_username : String = "emqx"
client_password : String = "public"
mqtt_topic : String = "t/1"

OptionParser.parse do |parser|
  parser.banner = "Usage: mqtt_test [arguments]"
  parser.on("-c CLIENT_NUMBER", "--client_number=CLIENT_NUMBER", "Specifies the mqtt client number") { |num| clients_number = num.to_i }
  parser.on("-h HOST", "--host=HOST", "Specifies the mqtt broker host") { |host| mqtt_host = host }
  parser.on("-P PORT", "--port=PORT", "Specifies the mqtt broker port") { |port| mqtt_port = port.to_i }
  parser.on("-p PASSWORD", "--password=PASSWORD", "Specifies the mqtt client password") { |pass| client_password = pass }
  parser.on("-u USERNAME", "--username=USERNAME", "Specifies the mqtt client username") { |user| client_username = user }
  parser.on("-t topic", "--topic=TOPIC", "Specifies the mqtt topic") { |topic| mqtt_topic = topic }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

clients = Array(MQTT::V3::Client).new
clients_number.times do |i|
  transport = MQTT::Transport::TCP.new(mqtt_host, mqtt_port)
  client = MQTT::V3::Client.new(transport)
  client.connect(username=client_username, password=client_password)
  clients << client
end

clients.each do |client|
  spawn do
    loop do
      client.publish(mqtt_topic, {"msg" => "hello"}.to_json, qos: MQTT::QoS::BrokerReceived)
    end
  end
end

sleep(600)
