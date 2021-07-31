require "mqtt/v3/client"
require "option_parser"
require "json"

mqtt_host : String = "broker.emqx.io"
mqtt_port : Int32 = 1883
clients_number : Int32 = 10

OptionParser.parse do |parser|
  parser.banner = "Usage: salute [arguments]"
  parser.on("-c CLIENT_NUMBER", "--client_number=CLIENT_NUMBER", "Specifies the mqtt client number") { |num| clients_number = num.to_i}
  parser.on("-h HOST", "--host=HOST", "Specifies the mqtt broker host") { |host| mqtt_host = host }
  parser.on("-p PORT", "--port=PORT", "Specifies the mqtt broker port") { |port| mqtt_port = port.to_i }
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
  # transport = MQTT::Transport::TCP.new("f41ee402.cn-shenzhen.emqxcloud.cn", 15107)
  transport = MQTT::Transport::TCP.new(mqtt_host, mqtt_port)
  client = MQTT::V3::Client.new(transport)
  client.connect(username="emqx", password="public")
  clients << client
end

clients.each do |client|
  spawn do
    loop do
      client.publish("t/1", {"msg"=> "hello"}.to_json, qos: MQTT::QoS::BrokerReceived)
    end
  end
end

sleep(600)
