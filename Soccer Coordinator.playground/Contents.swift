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
 - ✅ Create logic that sorts players into 3 even teams, based on player experience
 - ✅ The algorithm must not be based on magic or hard coded numbers or indexes

 #### Part 3: Personalized Letters
 - ✅ Store all 18 letters in the a collection called `letters`, including the player’s name, guardian names, team name, and date/time of their first team practice
 - ✅ Format each letter
 - ✅ Print each letter to the console
 - ✅ The word `Optional` must not be present in the letter content

 #### Part 4: Naming and Comments
 - ✅ Include comments
 - ✅ Ensure specified naming requirements for constants, variables, keys, and methods are met

 ### Extra Credit

 - ✅ Logic must sort players into 3 even teams based on player experience *and* height
 - ✅ All teams must have an average height within 1.5 inches of each other
 - ✅ Must not depend on initial order of the collection of players
 - ✅ Print average height of each team to the console

 ---
 ## Initial Definitions

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
    - Each player has the structure discussed above between lines 62 and 67
*/
// This would all be better as a `struct`, tuple, or at least a `typealias` so I'd only have to change 1 thing if I change the way I structure my data, which I've done like 4 times now
// Also, I found an interesting Swift gotcha here. Apparently the type system doesn't like inferring `[String: Any]`, so you have to explicitly declare or cast it yourself
var teamSharks: [String: Any] = [teamNameKey: "Sharks", teamPracticeKey: [teamPracticeDateKey: "March 17", teamPracticeTimeKey: "3 PM"], teamPlayersKey: [[String: Any]]()]
var teamDragons: [String: Any] = [teamNameKey: "Dragons", teamPracticeKey: [teamPracticeDateKey: "March 17", teamPracticeTimeKey: "1 PM"], teamPlayersKey: [[String: Any]]()]
var teamRaptors: [String: Any] = [teamNameKey: "Raptors", teamPracticeKey: [teamPracticeDateKey: "March 18", teamPracticeTimeKey: "1 PM"], teamPlayersKey: [[String: Any]]()]

/*:
 ---
 ## Sorting

 Since the extra credit assignment is to basically sovle the [multi-way number partitioning problem](https://www.aaai.org/ocs/index.php/IJCAI/IJCAI-09/paper/viewFile/625/705), I'm going to be implementing a 3-way version of this problem's greedy heuristic in order to sort the players into their teams so that each team has an average height within 1.5 inches of each other, though my version of this algorithm will be slightly modified to account for capping the number of experienced players each team can have. This can be scaled to however many teams we decide there should be in the league, but we've predetermined 3 here

 ### Ordering the `players`
 The very first thing we need to do is sort the `players` array so it's ordered from the tallest player to the lowest player. Given that we're not allowed to use closures or most of the standard library yet, I'm going to make my own implementation of [Bubble Sort](https://en.wikipedia.org/wiki/Bubble_sort), which operates by iterating over a list 2 values at a time and swapping the values if they're not in the proper order, and reiterating until the array is sorted. It's not the most optimal sorting algorithm out there, but it's simple, and I've never seen a soccer team or league that has millions of players
*/

var hasSwapped = false

repeat{
    hasSwapped = false // Bubble sort knows it's done when it completes a full pass over the array without changing anything, so we need to start fresh after each pass
    for index in 1..<players.count{ // Starting at the beginning of the array,
        if let first = players[index - 1][playerHeightKey] as? Double, let second = players[index][playerHeightKey] as? Double, first < second{ // If an element earlier in the array is smaller than the one that comes after it,
            (players[index - 1], players[index]) = (players[index], players[index - 1]) // Swap them
            hasSwapped = true // Also, we need to remember the fact that we swapped things on this pass
        }
    }
}while hasSwapped // As stated before, we want this to repeat until we've made a full pass without swapping anything

//: As we can see, our `players` array is now properly sorted, with the tallest kid first and the shortest kid last 🎉

players

/*:
 ### Constant, Variable, and Function Definitions
 The gist of the greedy number partitioning heuristic is that we make an array for each group we want to sort into (3 in our case), and then we iterate through the `players`, and assign the next tallest player to the group that has the shortest total height. Given that there aren't any major outliers (which the project instructions say is something we can assume), this should come out to be pretty close to equal in height, most likely within 1.5 inches

 However, it's important to note that there's also a limit to the number of experienced players a team is allowed to have.

 In order to do this, we're gonna need some things that are either not in the standard library or I'm not allowed to use yet, so I'm gonna make a few helper functions. First up, in order to sort players normalizing the average heights of each team, I'm going to need to be able to get the total height of a particular team. I'm going to define 2 overloads here: the normal one that takes an array of players, and one for convenience that takes one of my team dictionaries. For what it's worth, this would usually be a perfect use case for `reduce` from the standard library, but that's one of the functions I'm not allowed to use here, so I'm just gonna roll my own
*/

/**
 Finds the total height of a list of players

 - parameter team: A list of players
 - returns: The sum of the height of all players in `team`
 - precondition: Each player within the `team` must have a non-optional `Double` defined for `playerHeightKey`
 */
func totalHeight(of team: [[String: Any]]) -> Double{
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
 Finds the total height of a team

 This is a convenience overload for the primary `totalHeight(of:)`, which directly takes an `Array` of players. This finds that list within a team `Dictionary` and passes it to the original function

 - parameter team: A `[String: Any]` representing a team
 - returns: The sum of the height of all players in `team`
 - precondition: The `team` must have a non-optional `[String: Any]` defined for `teamPlayersKey`
 - precondition: Each player within the `team` must have a non-optional `Double` defined for `playerHeightKey`
 */
func totalHeight(of team: [String: Any]) -> Double{
    guard let players = team[teamPlayersKey] as? [[String: Any]] else{
        preconditionFailure("Couldn't find players list for team: \(team)")
    }
    return totalHeight(of: players)
}

//: Since we're also not allowed to use `filter` from the standard library in this exercise, I'll have to make specialized versions myself when I need them. In this case, I'll need to know the experienced players on a given team

/**
 Finds all the players that have prior soccer experience in a list of players

 - parameter team: An array representing a list of players
 - returns: An array of all players in `team` that have previous soccer experience
 - precondition: Each player in `team` must have a non-optional `Bool` defined for `playerExperienceKey`
 */
func experiencedPlayers(on team: [[String: Any]]) -> [[String: Any]]{ // Ideally I could `filter` here, but I wish I could at least use a generic
    var experienced = [[String: Any]]()
    for player in team{
        if let hasExperience = player[playerExperienceKey] as? Bool, hasExperience{
            experienced.append(player)
        }
    }
    return experienced
}

//: So, now that we have all the functions we'll need, let's get started on actually sorting the players. First, we're gonna need an `Array` that contains a `[[String: Any]]` to represent each team's list of players. It goes without saying that since we've decided on having 3 teams in this exercise, we'll need 3 of these `[[String: Any]]`s, though this can be easily changed for however many teams we want to have

var playerGroups = Array(repeating: [[String: Any]](), count: 3)

//: We'll also need to hang onto how many players a team is allowed to have. In this case, since there are only 3 teams, each teams will contain ⅓ of all players in the league

let playerCap = Int((Double(players.count) / Double(playerGroups.count)).rounded()) // We have to do all this weird casting and rounding so players don't get left out if the league contains a number of players that aren't evenly divisible among the teams in the league. It basically just divides while accounting for decimals, rounding the result to the nearest ingeter, and converting it from a `Double` to an `Int`

//: The last major constant we need to know ahead of time is the maximum number of experienced players each team is allowed to have. The easiest thing to do is to set it to simply be the total number of experienced players divided by the total number of teams, though this could cause problems with our current algorithm if that doesn't divide evenly. Given the data set for this project, though, it'll work just fine here. If the data set changes at some point, however, this is something that will need to be considered

let experienceCap = experiencedPlayers(on: players).count / playerGroups.count

/*:
 ### Player Partitioning

 Now that we have all the functions we need and have defined all the constants and variables we'll need, we can get down to actually sorting all the players into their teams. We're gonna do this by iterating over all the players in the league, determining if they have prior experience, finding the team that currently has the lowest total height, and placing the player onto that team. If that team happens to have reached its maximum number of players or maximum number of experienced players, we'll move on and keep looking for an eligible team with the next lowest total height
*/

for player in players{
    //: The first thing we need to do on each iteration is to determine which team the next player will be sorted into. In most cases, this will simply be the one that currently has the lowest total height. However, if the next player to be sorted has previous soccer experience, we need to make sure that the team with the lowest total height hasn't also reached their cap of experienced players. If they have, we move onto the next lowest total height that hasn't reached its cap
    guard let playerHasExperience = player[playerExperienceKey] as? Bool else{
        preconditionFailure("Couldn't determine experience of player: \(player)") // Crashing is bad in production, but this isn't production, and it's a sign of bad data here that I would need to fix manually
    }
    var lowest = (height: Double.infinity, index: 0) // Usually I'd initialize the height here to 0, but that'd sorta break the whole "check if the current team is lower than the known lowest" thing, so I'm gonna initialize it to as high as possible
    for (index, team) in playerGroups.enumerated(){ // This is just like enumerating over `playerGroups` directly, but we also get the index of the item we're on in the `playerGroups` array
        let currentHeight = totalHeight(of: team)
        guard currentHeight < lowest.height, team.count < playerCap, !playerHasExperience || experiencedPlayers(on: team).count < experienceCap else {
            continue
        }
        lowest.height = currentHeight
        lowest.index = index
    }

    playerGroups[lowest.index].append(player)
}

//: Once all the player lists are properly sorted, we just need to assign them to a preconstructed team

teamSharks[teamPlayersKey] = playerGroups[0]
teamDragons[teamPlayersKey] = playerGroups[1]
teamRaptors[teamPlayersKey] =  playerGroups[2]

//: Also, here's a quick definition for the rest of this playground. It's going to make everything from now on easier if I have an array of all the teams in the league

let teams = [teamSharks, teamDragons, teamRaptors]

//: Now we can see that all the teams have a list of players assigned to them, and they're all evenly matched, including having the same number of players, the same number of *experienced* players, and an average height within 1.5 inches of each other 🎉

print("Team average heights:\n")
for team in teams{
    guard let name = team[teamNameKey] as? String, let members = team[teamPlayersKey] as? [[String: Any]] else{ // In practice, these will never fail, but you can't write code that's *too* safe
        continue
    }
    print("- \(name): \(totalHeight(of: members) / Double(members.count)) inches")
}

/*:
 ---
 ## Letters

 Now that we have everybody properly sorted, all we have left to do is generate and print out the letters to the parents, which is a pretty simple task. It's likely not really necessary without the requirement, but it's in the spec that we have to store all the letters in a collection called `letters`, so we're gonna start out by making an `Array` of `String`s for that
*/

var letters = [String]()

//: All in all, this is really short and sweet. Normally I'd put everything directly in this loop, but since we have to store each letter in the `letters` array, we're just gonna loop over all the teams, and for each player on each team, we're gonna generate a letter to their parents about what team they got placed on and when they meet for their first practice, and add that letter to the `letters` array

for team in teams{
    guard let teamName = team[teamNameKey] as? String, let practice = team[teamPracticeKey] as? [String: String], let date = practice[teamPracticeDateKey], let time = practice[teamPracticeTimeKey], let members = team[teamPlayersKey] as? [[String: Any]] else{
        preconditionFailure("Incomplete data for team: \(team)") // Normally crashing is bad, but this is still just a playground and not production code, and any of these unwraps/casts failing is indicative of a data structural problem that I'd need to fix myself, so I think it's the right thing to do here
    }
    for player in members{
        guard let playerName = player[playerNameKey] as? String, let parentName = player[playerParentKey] as? String else{
            preconditionFailure("Incomplete data for player: \(player)") // I justify this crash for the same reason I did the one above
        }
        letters.append("""
Dear \(parentName),

    We are pleased to inform you that your child, \(playerName) has been placed on the \(teamName) for the upcoming 2018 soccer season! This will be an exciting year, and your child will be a very valuable member of their team.

    The \(teamName)' first practice will be on \(date) at \(time) as Memorial Field in Drake's Creek Park, and it's mandatory that you and your child must attend. Your child will get to know their new teammates and the basics of how to stretch properly and perform a few practice drills, all while you meet your fellow team parents, learn about the upcoming schedule, and how you can best care for and support your child during the upcoming season. Please bring all the necessary release forms that have been sent with this letter. Your child will be provided with a uniform, but we ask that you please bring them equipped with cleats that fit well and shin guards.

    We hope you and your child are just as excited as we are for the new season! We look forward to seeing you at the first practice.

All the best,

Michael Hulet

Youth Soccer Coordinator, Hendersonville Department of Parks and Recreation

""")
    }
}

//: Now that we have all our letters typed up, we just need to print them all to the console, with a little formatting to make them easier to read

for letter in letters{
    print("\n\n--------------------------------------------------------------------------------\n\n")
    print(letter)
}
