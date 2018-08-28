/*:
 # Soccer Coordinator
 ## *Treehouse iOS Techdegree Project 1*

 You have volunteered to be the coordinator for your town’s youth soccer league. As part of your job you need to divide the 18 children who have signed up for the league into three even teams — Dragons, Sharks, and Raptors. In years past, the teams have been unevenly matched, so this year you are doing your best to fix that. For each child, you will have the following information: Name, height (in inches), whether or not they have played soccer before, and their guardians’ names. All code will be written and executed in a Swift Playground

 ## Requirements

 ***NOTE:*** You can *only* use tools and constructs covered in [Swift Basics](https://teamtreehouse.com/library/swift-basics-2), [Swift Collections and Control Flow](https://teamtreehouse.com/library/swift-collections-and-control-flow), and [Functions in Swift](https://teamtreehouse.com/library/functions-in-swift)

 #### Part 1: Create required collections
 - ✅ Create a single collection named `players` that contains all information for all 18 players
 - ✅ Represent each player with a `Dictionary` with `String` keys and the corresponding values
 - ✅ Store players for each team in collections named `teamSharks`, `teamDragons`, and `teamRaptors`

 #### Part 2: Create satisfactory logic
 - ❌ Create logic that sorts players into 3 even teams, based on player experience
 - ❌ The algorithm must not be based on magic or hard coded numbers or indexes

 #### Part 3: Personalized Letters
 - ❌ Store all 18 letters in the a collection called `letters`, including the player’s name, guardian names, team name, and date/time of their first team practice
 - ❌ Format each letter
 - ❌ Print each letter to the console
 - ❌ The word “Optional” must not be present in the letter content

 #### Part 4: Naming and Comments
 - ❌ Include comments
 - ❌ Ensure specified naming requirements for constants, variables, keys, and methods are met

 ### Extra Credit

 - ❌ Logic must sort players into 3 even teams based on player experience *and* height
 - ❌ All teams must have an average height within 1.5 inches of each other
 - ❌ Must not depend on initial order of the collection of players
 - ❌ Print average height of each team to the console

 ---
 ## Implementation
 ### Initial Definitions

 A player has a:

 - name
 - height
 - parent
 - either some or no prior experience

 These are all keys solely used to safely index into a `Dictionary` that represents a player
*/
// I feel so dirty doing this without an `enum`
let playerNameKey = "name"
let playerHeightKey = "height"
let playerParentKey = "parent"
let playerExperienceKey = "experience?"

//: These exist just to make it easier and safer to directly copy/paste from the spreadsheet
// If I could make this an Objective-C-style macro, I totally would, but I wouldn't have to in Objective-C 😛
let YES = true
let NO = false

/*:
 This holds a list of all the players in the league. Each player has all the following keys, which map to the following non-optional types:

 - `playerNameKey -> String`
 - `playerHeightKey -> Double` | ***NOTE:*** This could be an `Int` here, but making it a `Double` will allow for more informed sorting later on
 - `playerParentKey -> String`
 - `playerExperienceKey -> Bool`
*/
// I wanna do this with a `struct` or at least `typealias Player = [String: Any]`, but I gotta say, I love a lot of the culture references with these names
var players: [[String: Any]] = [
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

/*:
 A team has a:

 - name
 - list of members
 - practice, which has a:
    - date
    - time

 These are all keys solely used to safely index into a `Dictionary` that represents a team
*/
// This is another thing I'd like to `enum`
let teamNameKey = "name"
let teamPlayersKey = "players"
let teamPracticeKey = "practice"
let teamPracticeDateKey = "date"
let teamPracticeTimeKey = "time"

/*:
 These will eventually be the definitive lists of who's on what teams, and their practice schedule. Each team has all the following keys, which map to the following non-optional types:

 - `teamPracticeKey -> [String: String]`
    - `teamPracticeDateKey -> String`
    - `teamPracticeTimeKey -> String`
 - `teamPlayersKey -> [[String: Any]]`
    - Each player has the structure discusses above between lines 62 and 67
*/
// This would all be better as a `struct`, tuple, or at least a `typealias` so I'd only have to change 1 thing if I change the way I structure my data, which I've done like 4 times now
// Also, I found an interesting Swift gotcha here. Apparently the type system doesn't like inferring `[String: Any]`, so you have to explicitly declare or cast it yourself
var teamSharks: [String: Any] = [teamNameKey: "Sharks", teamPracticeKey: [teamPracticeDateKey: "March 17", teamPracticeTimeKey: "3 PM"], teamPlayersKey: [[String: Any]]()]
var teamDragons: [String: Any] = [teamNameKey: "Dragons", teamPracticeKey: [teamPracticeDateKey: "March 17", teamPracticeTimeKey: "1 PM"], teamPlayersKey: [[String: Any]]()]
var teamRaptors: [String: Any] = [teamNameKey: "Raptors", teamPracticeKey: [teamPracticeDateKey: "March 18", teamPracticeTimeKey: "1 PM"], teamPlayersKey: [[String: Any]]()]

//: I'm going to define a few helper functions I'm gonna use later. First up, in order to sort players normalizing the average heights of each team, I'm going to need to be able to get the average height of a particular team. I'm going to define 2 overloads here: the normal one that takes an array of players, and one for convenience that takes one of my team dictionaries

/**
 Finds the average height of a list of players

 - parameter team: A list of players
 - returns: The average height of the players in `team`
 - precondition: Each player within the `team` must have a non-optional `Double` defined for `playerHeightKey`
*/
func averageHeight(of team: [[String: Any]]) -> Double{
    var total: Double = 0 // If I didn't mark this as a `Double` by default, it'd be inferred as an `Int` and I'd lose the decimals
    for player in team{
        guard let height = player[playerHeightKey] as? Double else{
            // Normally, it'd be terrible to crash on something like this. I'd like to have this take a `struct` so I wouldn't have to do all this `Dictionary` access stuff, but I'd at least like to have it `throw`, or even just `return nil`. However, my data structure at the beginning of this file guarantees that this shouldn't ever be hit, and this is just a playground and not a production app, so I figure it's ok enough here
            preconditionFailure("Couldn't find height for player: \(player)")
        }
        total += height
    }
    return total
}

/**
 Finds the average height of a team

 This is a convenience overload for the primary `averageHeight(of:)`, which directly takes an `Array` of players. This finds that list within a team `Dictionary` and passes it to the original function

 - parameter team: A `[String: Any]` representing a team
 - returns: The average height of the players in `team`
 - precondition: The `team` must have a non-optional `[String: Any]` defined for `teamPlayersKey`
 - precondition: Each player within the `team` must have a non-optional `Double` defined for `playerHeightKey`
*/
func averageHeight(of team: [String: Any]) -> Double{
    guard let players = team[teamPlayersKey] as? [[String: Any]] else{
        preconditionFailure("Couldn't find players list for team: \(team)")
    }
    return averageHeight(of: players)
}

//: I'm gonna need to know whether or not a player has previous experience playing soccer. I know I'm already storing this as a simple `Bool` in a player's `Dictionary`, but I'm making a function for this so that I don't have to repeat all the unwrapping code all the time. I can't wait until I can use a `struct` so I can just mark this field non-`Optional` and call this a day 😛

/**
 Finds if a player has previous soccer experience

 - parameter player: A `[String: Any]` representing a player
 - returns: A `Bool` indicating whether or not the `player` has previous soccer experience
 - precondition: The `player` must have a non-optional `Bool` defined for `playerExpreienceKey`
*/
func isExperienced(_ player: [String: Any]) -> Bool{
    guard let experience = player[playerExperienceKey] as? Bool else{
        preconditionFailure("Couldn't find experience record for player: \(player)")
    }
    return experience
}

//: Since we're not allowed to use `filter` from the standard library in this exercise, I'll have to make specialized versions myself when I need them. In this case, I'll need to know the experienced players on a given team. I'm gonna make 2 overloads for the same reason I did before with `averageHeight(of:)`

/**
 Finds all the players that have prior soccer experience in a list of players

 - parameter team: An array representing a list of players
 - returns: An array of all players in `team` that have previous soccer experience
 - precondition: Each player in `team` must have a non-optional `Bool` defined for `playerExperienceKey`
*/
func experiencedPlayers(on team: [[String: Any]]) -> [[String: Any]]{ // Ideally I could `filter` here, but I wish I could at least use a generic
    var experienced = [[String: Any]]()
    for player in team{
        if isExperienced(player){
            experienced.append(player)
        }
    }
    return experienced
}

/**
 Finds all players in a team that have prior soccer experience

 This is a convenience overload for the primary `experiencedPlayers(on:)`, which directly takes an `Array` of players. This finds that list within a team `Dictionary` and passes it to the original function

 - parameter team: A `[String: Any]` representing a team
 - returns: An array of all players in `team` that have previous soccer experience
 - precondition: The `team` must have a non-optional `[String: Any]` defined for `teamPlayersKey`
 - precondition: Each player in `team` must have a non-optional `Bool` defined for `playerExperienceKey`
*/
func experiencedPlayers(on team: [String: Any]) -> [[String: Any]]{
    guard let players = team[teamPlayersKey] as? [[String: Any]] else{
        preconditionFailure("Couldn't find players list for team: \(team)")
    }
    return experiencedPlayers(on: players)
}

/*:
 ---
 ### Sorting

 Since the extra credit assignment is to basically sovle the [multi-way number partitioning problem](https://www.aaai.org/ocs/index.php/IJCAI/IJCAI-09/paper/viewFile/625/705), I'm going to be implementing a 3-way version of this problem's greedy heuristic in order to sort the players into their teams so that each team has an average height within 1.5 inches of each other, though my version of this algorithm will be slightly modified to account for capping the number of experienced players each team can have. This can be scaled to however many teams we decide there should be in the league, but we've predetermined 3 here

 The very first thing we need to do is sort the `players` array so it's ordered from the tallest player to the lowest player. Given that we're not allowed to use closures or most of the standard library yet, I'm going to make my own implementation of [Bubble Sort](https://en.wikipedia.org/wiki/Bubble_sort), which operates by iterating over a list 2 values at a time and swapping the values if they're not in the proper order, and reiterating until the array is sorted. It's not the most optimal sorting algorithm out there, but it's simple, and I've never seen a soccer team or league that has millions of players
*/

var hasSwapped = false

players

repeat{
    hasSwapped = false // Bubble sort knows it's done when it completes a full pass over the array without changing anything, so we need to start fresh after each pass
    for index in 1..<players.count{ // Starting at the beginning of the array,
        if let first = players[index - 1][playerHeightKey] as? Double, let second = players[index][playerHeightKey] as? Double, first < second{ // If an element earlier in the array is smaller than the one that comes after it,
            (players[index - 1], players[index]) = (players[index], players[index - 1]) // Swap them
            hasSwapped = true
        }
    }
}while hasSwapped

//: As we can see, our `players` array is now properly sorted, with the tallest kid first and the shortest kid last 🎉

players
