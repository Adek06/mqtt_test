# mqtt_test

mqtt concurrency test tool

## Installation

```
git clone https://github.com/Adek06/mqtt_test.git
cd mqtt_test
shards build
./bin/mqtt_test
```

## Usage

```
./bin/mqtt_test -h
Usage: mqtt_test [arguments]
    -c CLIENT_NUMBER, --client_number=CLIENT_NUMBER
                                     Specifies the mqtt client number
    -h HOST, --host=HOST             Specifies the mqtt broker host
    -P PORT, --port=PORT             Specifies the mqtt broker port
    -p PASSWORD, --password=PASSWORD Specifies the mqtt client password
    -u USERNAME, --username=USERNAME Specifies the mqtt client username
    -t topic, --topic=TOPIC          Specifies the mqtt topic
    -h, --help                       Show this help
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/mqtt_test/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [adek06](https://github.com/adek06) - creator and maintainer
