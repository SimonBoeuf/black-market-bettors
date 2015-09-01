# Black Market Brawlers : Riot API Challenge 2.0 entry

Category: Black Market Brawlers

## Introduction
Black Market Bettors is a small game that will challenge your analysis capabilities :
- The server is permanently running replays-like of black market brawlers games. Your aim is to guess which team will win : When you connect to the server, you will be able to guess which team will win as soon as a game is running
- Throughout the game, you will see the evolution of gold/objectives/players stuffs/brawlers/... per team. If you think you chose the wrong team, change it ! Your final score will be calculated depending on the time spent with your bet placed on the right team.
- When the game is over, you will see a screen displaying the winning team as well as your final score, which is : time spent on the winning team / game duration * 1000 (x1000 a score is always prettier)
- Wait 10 seconds, and another game will be loaded. Have fun !

## Demo
[Here](http://black-market-bettors.herokuapp.com/) you go :)
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
- Build a valid [database.yml](https://gist.github.com/erichurst/961978). file, which you will place in config/ folder as well
-   ``bundle install``
-   ``rake db:create``
-   ``rake db:migrate``
-   ``rails s``

### Notes
- It might take a while to load games the first few times you launch the server, because you will have to request api for every single static data. Don't worry, it will get better.
- There is a little problem with item sets at the moment. Don't be surprised if you happen to see multiple times the same tier 3 item on a player, it's just a ~~bug~~ feature

## Legal

- "black market bettors" isn't endorsed by Riot Games and doesn't reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.

## OWNERSHIP AND RELATIONSHIP OF PARTIES
The Materials are protected by copyrights, trademarks, service marks, international treaties, and/or other proprietary rights and laws of the U.S. and other countries. Except to the extent of any license granted herein by Riot to You, as between You and Riot, Riot owns all right, title and interest (including all intellectual property rights) in and to the Materials, including all output and executables of the Riot Games API, and including any modifications to or derivatives of the Materials. You agree to abide by all applicable proprietary rights laws and other laws, as well as any additional copyright notices or restrictions contained in these API Terms. Except to the extent of any license granted herein by Riot to You, these API Terms do not grant to You any right, title, or interest in any intellectual property owned or licensed by Riot, including (but not limited to) the Riot Games API (including but not limited to modifications and derivatives thereof) and Riot Marks, the Game and any Game Information.

The parties do not intend to merge Riot's intellectual property rights and Your intellectual property rights into inseparable or interdependent parts of a unitary whole, and no joint works are to be created or shall be deemed to have been created hereunder. You shall not acquire any ownership or co-ownership interest under these API Terms in any Riot intellectual property rights, and Riot shall not acquire any ownership or co-ownership interest under these API Terms in any of Your intellectual property rights.

You acknowledge and agree that Riot and other Riot Games API users may independently develop other applications and/or websites through their use of the Riot Games API or otherwise which may be identical or similar to Your Applications in function, code or other characteristics. You agree that, to the extent any similarity is based upon the Riot Games API and/or Game Information, You will have no ownership or intellectual property rights in such applications and/or websites. You further acknowledge and agree that any application and/or website developed by Riot and using the Riot Games API that may be identical or similar to Your Application in function, code or other characteristics will not be deemed to violate in any manner any of Your rights in Your Application, and that any such characteristics are coincidental in nature. In this regard, You expressly grant to Riot a limited, non-exclusive license in and to any proprietary rights You may hold in any Application for purposes of developing, using and exploiting any application and/or website developed by Riot using the Riot Games API. By making available an Application, You acknowledge and agree that Your Application, including its functionality, is not exclusive to Riot, the Game and/or to third parties, and may be replicated, imitated or otherwise duplicative with other applications, websites and/or games or functionality developed by Riot or third parties.

You hereby irrevocably assign and agree to irrevocably assign, without charge, all intellectual property rights relating to oral and written comments and suggestions provided by You relating to the Riot Games API or the Materials ("Feedback"). At Riot's expense, You will take all actions deemed necessary by Riot in order for Riot to record, perfect and maintain its right in and to all Feedback. Without limiting the foregoing, Riot will have an unlimited, worldwide, royalty-free right to use and modify all Feedback.
