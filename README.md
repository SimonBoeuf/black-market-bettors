# Black Market Brawlers : Riot API Challenge 2.0 entry

Category: Black Market Brawlers

## Introduction
Black Market Bettors is a small game that will challenge your analysis capabilities :
- The server is permanently running replays-like of black market bettor games. Your aim is to guess which team will win : When you connect to the server, you will be able to place bets as soon as a game is running
- Throughout the game, you will see gold/objectives/players stuffs/brawlers/... If you think you chose the wrong team, change it ! Your final score will be calculated depending on the time spent with your bet placed on the right team.
- When the game is over, you will see a screen displaying the winning team as well as your final score, which is : time spent on the winning team / game duration * 1000 (x1000 a score is always prettier)
- Wait 10 seconds, and another game will be loaded. Have fun !

## How it works
- The first time a client connects to the server, a game Singleton is initialized. For every new connection, a websocket will be opened between server and client
- The singleton will first chose a random game, then get its timeline using the API. Please not that every piece of data except for images are stored in databased and reused instead of calling API again.
- Once the game data is ready, the replay will start, sending sockets for every event to every client
- When client bets on a team, it will start a timer, which will end either when the client changes team, or when game finishes.
- At the end of the game, score of each client is computed and sent to the corresponding client.
- Server will then sleep for ten seconds before reinitializing singleton.

## Setting it up
### Prerequisites
    Postgresql (tested with 9.3.9)
    Ruby 2.1.2
    Rails 4.1.6
### Configuration and launch
- Rename the file config/riot_api.yml.sample to config/riot_api.yml and place your api_key in it
- You can set the game speed in config/initializers/game.rb (default: 10, which means game will last ten times shorter than it actually did)
- run : 
`
rake db:create
rake db:migrate
rails s
`
### Notes
- It might take a while to load games the first few times you launch the server. Don't worry, it will get better.
## Legal

"black market bettors" isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.
