# Trail Buddy 

Trail Buddy is a Ruby Gem CLI for viewing the top-rated hiking trails of every State in the United States.

## Installation

To install enter:

    $ gem install trail_buddy_cli
And then execute:

    $ bundle install
To run the application enter:

```ruby
$ ruby bin/run
```


## Usage
Once the application is running, use the on-screen prompts to search for trails by state.
```ruby
Please enter the name of the State you would like to explore:
Utah
```
This will return a list of the 10 highest rated trails for that state as per the trail ratings at Alltrails.com.
```ruby
1. Angels Landing Trail - Zion National Park

## trail description 
2. Navajo Loop and Queen's Garden Trail - Bryce Canyon

## etc
```
Enter the number corresponding to a trail in which you would like to view more information.
```ruby
$ 1
=> Angels Landing Trail - Zion National Park, Utah
Length: 4.4 mi - Est. 2 h 47 m
Difficulty: hard
Elevation gain: 1,604 ft
route type: Out & back
----------------------------------
# more detailed description
#
# etc
```
Finally, enter 'new' to explore a new state, 'back' to return to the current State's trails, or enter 'weather' to view a seven day forecast for the current trail's location.
```ruby
$ weather 
=> Monday

sky is clear
High: 61°
Low: 38°
Humidity: 18%
----------------------------------------
# rest of week
``` 
You may exit the application at any time by entering 'exit'.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.




## License
[MIT](https://choosealicense.com/licenses/mit/)