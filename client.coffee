stump = require('stump')

if process.argv[2] is 'client'
  stump.stumpify(this, "[TEST]Client")
  WebSocket = require('ws')

  id = "f81d4fae-7dec-11d0-a765-00a0c91e6bf6"
  session_cookie = 's%3AS5EFQKQQeOG9j0OpLuKVh4gn.9gByOR7dj%2BjCYSSDLlsZahQtXj4kJWEwujYulPnuAHk'
  engine = new WebSocket "ws://localhost:8080/api/v1/websocket",
    headers:
      'Cookie': "connect.sid=#{session_cookie}"

  engine.on 'open', =>
    #@error "sending"
    ops = ->
      engine.send(JSON.stringify
        operation: "INITIATE_DEPOSIT"
        amount: {currency: "BTC", amount: "1500.00000"})

      engine.send(JSON.stringify
        operation: "INITIATE_DEPOSIT"
        amount: {currency: "USD", amount: "1500.00000"})

      #engine.send(JSON.stringify
        #operation: "CREATE_LIMIT_ORDER"
        #offered: {currency: "BTC", amount: "1"}
        #received: {currency: "USD", amount: "105.12"})

      #engine.send(JSON.stringify
        #operation: "CREATE_LIMIT_ORDER"
        #offered: {currency: "USD", amount: "104.86"}
        #received: {currency: "BTC", amount: "1"})

      #engine.send(JSON.stringify
        #operation: "CREATE_LIMIT_ORDER"
        #offered: {currency: "BTC", amount: "1"}
        #received: {currency: "USD", amount: "105.02"})

      #engine.send(JSON.stringify
        #operation: "CREATE_LIMIT_ORDER"
        #offered: {currency: "BTC", amount: "3"}
        #received: {currency: "USD", amount: "315.06"})

      #engine.send(JSON.stringify
        #operation: "CREATE_LIMIT_ORDER"
        #offered: {currency: "USD", amount: "105.02"}
        #received: {currency: "BTC", amount: "1"})

      #query.send(JSON.stringify
        #query: "TICKER"
        #currencies: ["BTC", "USD"])

      ##query.send(JSON.stringify
        ##query: "TICKER"
        ##currencies: ["USD", "BTC"])

      engine.send(JSON.stringify
        query: "BALANCES")

      #engine.send(JSON.stringify
        #operation: "VERIFY_ACCOUNT"
        #first_name: "Ben"
        #middle_name: null
        #last_name: "Hoffman"
        #date_of_birth: "1983-10-23"
        #birth_country: "USA"
        #address:
          #line1: "Foo"
          #line2: null
          #city: "Bar"
          #region: "CA"
          #zip_code: "12345"
          #country: "USA")

      #engine.send(JSON.stringify
        #operation: "ADD_BANK_ACCOUNT"
        #full_name: "Ben Hoffman"
        #routing_number: "42"
        #account_number: "42"
        #type: "CheckingAccount")

      ##query.send(JSON.stringify
        ##query: "OPEN_ORDERS"
        ##account_id: id)

    setTimeout(ops, 1000)

  engine.on 'message', (message) =>
    @error message
else
  fork = require('child_process').fork

  fork('./client.coffee', ['client'])

