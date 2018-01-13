# Smartcar Backend Challenge
API for interacting with Smartcar status and functions

## System Requirements
* Ruby version 2.3.4 or higher

## To Run:
1. Download project repo:
```
git clone https://www.github.com/kamillamagna/smartcar
```

2. Install dependencies:
```
bundle install
```

3. Start server:
```
ruby app.rb
```

## To Test:
Install and bundle (steps 1 and 2 above), then run:
```
ruby tests/test.rb
```

## Endpoints:

### Vehicle Info
Returns information about vehicle, including VIN (vehicle identification number), color, number of doors, and drivetrain
See [vehicles/info.rb](vehicles/info.rb) module for expected response schema
```
GET /vehicles/:id
```

### Security
Returns status of doors (locked/unlocked)
See [vehicles/security.rb](vehicles/security.rb) module for expected response schema
```
GET /vehicles/:id/security
```

### Fuel Range
Returns percentage of tank remaining or -1 if vehicle is all-electric
See [vehicles/energy.rb](vehicles/energy.rb) module for expected response schema
```
GET /vehicles/:id/fuel
```

### Battery Range
Returns percentage of battery remaining or -1 if vehicle is gas-powered
See [vehicles/energy.rb](vehicles/energy.rb) module for expected response schema
```
GET /vehicles/:id/battery
```

### Engine Start/Stop
Starts/stops engine with START or STOP argument
See [vehicles/engine.rb](vehicles/engine.rb) module for expected response schema
```
POST /vehicles/:id/engine
Content-Type: application/json

{
  "action": "START|STOP"
}
```
