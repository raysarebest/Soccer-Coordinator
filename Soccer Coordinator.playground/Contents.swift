/*:
 # Soccer Coordinator
 ## *Treehouse iOS Techdegree Project 1*

 You have volunteered to be the coordinator for your town’s youth soccer league. As part of your job you need to divide the 18 children who have signed up for the league into three even teams — Dragons, Sharks, and Raptors. In years past, the teams have been unevenly matched, so this year you are doing your best to fix that. For each child, you will have the following information: Name, height (in inches), whether or not they have played soccer before, and their guardians’ names. All code will be written and executed in a Swift Playground

 ## Requirements

 ***NOTE:*** You can *only* use tools and constructs covered in [Swift Basics](https://teamtreehouse.com/library/swift-basics-2), [Swift Collections and Control Flow](https://teamtreehouse.com/library/swift-collections-and-control-flow), and [Functions in Swift](https://teamtreehouse.com/library/functions-in-swift)

 #### Part 1: Create required collections
 - [✅] Create a single collection named `players` that contains all information for all 18 players
 - [✅] Represent each player with a `Dictionary` with `String` keys and the corresponding values
 - [ ] Store players for each team in collections named `teamSharks`, `teamDragons`, and `teamRaptors`

 #### Part 2: Create satisfactory logic
 - [ ] Create logic that sorts players into 3 even teams, based on player experience
 - [ ] The algorithm must not be based on magic or hard coded numbers or indexes

 #### Part 3: Personalized Letters
 - [ ] Store all 18 letters in the a collection called `letters`, including the player’s name, guardian names, team name, and date/time of their first team practice
 - [ ] Format each letter
 - [ ] Print each letter to the console
 - [ ] The word “Optional” must not be present in the letter content

 #### Part 4: Naming and Comments
 - [ ] Include comments
 - [ ] Ensure specified naming requirements for constants, variables, keys, and methods are met

 ### Extra Credit

 - [ ] Logic must sort players into 3 even teams based on player experience *and* height
 - [ ] All teams must have an average height within 1.5 inches of each other
 - [ ] Must not depend on initial order of the collection of players
 - [ ] Print average height of each team to the console

 ---
*/

//: A `PlayerKey` is just a `String`, and a `Player` is really just a `[String: Any]`, but aliasing makes my intent clearer throughout the program
typealias PlayerKey = String
typealias Player = [PlayerKey: Any]

/*:
 A `Player` has a:
   - name
   - height
   - parent
   - either some or no prior experience
*/
// I feel so dirty doing this without an `enum`
let playerNameKey: PlayerKey = "name"
let playerHeightKey: PlayerKey = "height"
let playerParentKey: PlayerKey = "parent"
let playerExperienceKey: PlayerKey = "experience?"

//: These exist just to make it easier and safer to directly copy/paste from the spreadsheet
// If I could make this an Objective-C-style macro, I totally would, but I wouldn't have to in Objective-C 😛
let YES = true
let NO = false

/*:
 The concrete type of `players` is a `[[String: Any]]`, but it holds a list of all the `Player`s in the league. Each `Player` has all the following keys, which map to the following non-optional types:

 - `playerNameKey -> String`
 - `playerHeightKey -> Double` ***NOTE:*** This could be an `Int` here, but making it a `Double` will allow for more informed sorting later on
 - `playerParentKey -> String`
 - `playerExperienceKey -> Bool`
*/
let players: [Player] = [
    [playerNameKey: "Joe Smith", playerHeightKey: 42.0, playerExperienceKey: YES, playerParentKey: "Jim and Jan Smith"],
    [playerNameKey: "Jill Tanner", playerHeightKey: 36.0, playerExperienceKey: YES, playerParentKey: "Clara Tanner"],
    [playerNameKey: "Bill Bon", playerHeightKey: 43.0, playerExperienceKey: YES, playerParentKey: "Sara and Jenny Bon"],
    [playerNameKey: "Eva Gordon", playerHeightKey: 45.0, playerExperienceKey: NO, playerParentKey: "Wendy and Mike Gordon"],
    [playerNameKey: "Matt Gill", playerHeightKey: 40.0, playerExperienceKey: NO, playerParentKey: "Charles and Sylvia Gill"],
    [playerNameKey: "Kimmy Stein", playerHeightKey: 41.0, playerExperienceKey: NO, playerParentKey: "Bill and Hillary Stein"],
    [playerNameKey: "Sammy Adams", playerHeightKey: 45.0, playerExperienceKey: NO, playerParentKey: "Jeff Adams"],
    [playerNameKey: "Karl Saygan", playerHeightKey: 42.0, playerExperienceKey: YES, playerParentKey: "Heather Bledsoe"],
    [playerNameKey: "Suzane Greenberg", playerHeightKey: 44.0, playerExperienceKey: YES, playerParentKey: "Henrietta Dumas"],
    [playerNameKey: "Sal Dali", playerHeightKey: 41.0, playerExperienceKey: NO, playerParentKey: "Gala Dali"],
    [playerNameKey: "Joe Kavalier", playerHeightKey: 39.0, playerExperienceKey: NO, playerParentKey: "Sam and Elaine Kavalier"],
    [playerNameKey: "Ben Finkelstein", playerHeightKey: 44.0, playerExperienceKey: NO, playerParentKey: "Aaron and Jill Finkelstein"],
    [playerNameKey: "Diego Soto", playerHeightKey: 41.0, playerExperienceKey: YES, playerParentKey: "Robin and Sarika Soto"],
    [playerNameKey: "Chloe Alaska", playerHeightKey: 47.0, playerExperienceKey: NO, playerParentKey: "David and Jamie Alaska"],
    [playerNameKey: "Arnold Willis", playerHeightKey: 43.0, playerExperienceKey: NO, playerParentKey: "Claire Willis"],
    [playerNameKey: "Phillip Helm", playerHeightKey: 44.0, playerExperienceKey: YES, playerParentKey: "Thomas Helm and Eva Jones"],
    [playerNameKey: "Les Clay", playerHeightKey: 42.0, playerExperienceKey: YES, playerParentKey: "Wynonna Brown"],
    [playerNameKey: "Herschel Krustofski", playerHeightKey: 45.0, playerExperienceKey: YES, playerParentKey: "Hyman and Rachel Krustofski"],
]
