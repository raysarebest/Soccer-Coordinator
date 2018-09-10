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

 These exist just to make it easier and safer to directly copy/paste from the spreadsheet
*/

// If I could make this an Objective-C-style macro, I totally would, but I wouldn't have to in Objective-C 😛
let YES = true
let NO = false

/*:
 This holds a list of all the players in the league. A player has a:

 - name
 - height
 - parent
 - either some or no prior experience
*/
// I wanna do this with a `struct` or at least a `typealias`, but I gotta say, I love a lot of the culture references with these names
var players: [(name: String, height: Double, hasExperience: Bool, parent: String)] = [
    (name: "Joe Smith", height: 42, hasExperience: YES, parent: "Jim and Jan Smith"),
    (name: "Jill Tanner", height: 36, hasExperience: YES, parent: "Clara Tanner"),
    (name: "Bill Bon", height: 43, hasExperience: YES, parent: "Sara and Jenny Bon"),
    (name: "Eva Gordon", height: 45, hasExperience: NO, parent: "Wendy and Mike Gordon"),
    (name: "Matt Gill", height: 40, hasExperience: NO, parent: "Charles and Sylvia Gill"),
    (name: "Kimmy Stein", height: 41, hasExperience: NO, parent: "Bill and Hillary Stein"),
    (name: "Sammy Adams", height: 45, hasExperience: NO, parent: "Jeff Adams"),
    (name: "Karl Saygan", height: 42, hasExperience: YES, parent: "Heather Bledsoe"),
    (name: "Suzane Greenberg", height: 44, hasExperience: YES, parent: "Henrietta Dumas"),
    (name: "Sal Dali", height: 41, hasExperience: NO, parent: "Gala Dali"),
    (name: "Joe Kavalier", height: 39, hasExperience: NO, parent: "Sam and Elaine Kavalier"),
    (name: "Ben Finkelstein", height: 44, hasExperience: NO, parent: "Aaron and Jill Finkelstein"),
    (name: "Diego Soto", height: 41, hasExperience: YES, parent: "Robin and Sarika Soto"),
    (name: "Chloe Alaska", height: 47, hasExperience: NO, parent: "David and Jamie Alaska"),
    (name: "Arnold Willis", height: 43, hasExperience: NO, parent: "Claire Willis"),
    (name: "Phillip Helm", height: 44, hasExperience: YES, parent: "Thomas Helm and Eva Jones"),
    (name: "Les Clay", height: 42, hasExperience: YES, parent: "Wynonna Brown"),
    (name: "Herschel Krustofski", height: 45, hasExperience: YES, parent: "Hyman and Rachel Krustofski")
]

/*:
 These will eventually be the definitive lists of who's on what teams, and their practice schedule. A team has a:

 - name
 - list of members
 - practice, which has a:
    - date
    - time
*/
// This would all be better as a `struct`, or at least a `typealias` so I'd only have to change 1 thing if I change the way I structure my data, which I've done like 5 times now. Also, this type signature is *really* long
var teamSharks: (name: String, practice: (date: String, time: String), players: [(name: String, height: Double, hasExperience: Bool, parent: String)]) = (name: "Sharks", practice: (date: "March 17", time: "3 PM"), players: [(name: String, height: Double, hasExperience: Bool, parent: String)]())
var teamDragons: (name: String, practice: (date: String, time: String), players: [(name: String, height: Double, hasExperience: Bool, parent: String)]) = (name: "Dragons", practice: (date: "March 17", time: "1 PM"), players: [(name: String, height: Double, hasExperience: Bool, parent: String)]())
var teamRaptors: (name: String, practice: (date: String, time: String), players: [(name: String, height: Double, hasExperience: Bool, parent: String)]) = (name: "Raptors", practice: (date: "March 18", time: "1 PM"), players: [(name: String, height: Double, hasExperience: Bool, parent: String)]())

/*:
 ---
 ## Sorting

 Since the extra credit assignment is to basically sovle the [multi-way number partitioning problem](https://www.aaai.org/ocs/index.php/IJCAI/IJCAI-09/paper/viewFile/625/705), I'm going to be implementing a 3-way version of this problem's greedy heuristic in order to sort the players into their teams so that each team has an average height within 1.5 inches of each other, though my version of this algorithm will be slightly modified to account for setting limits on the number of players and experienced players each team can have. This can be scaled to however many teams we decide there should be in the league, but we've predetermined 3 here

 ### Ordering the `players`
 The very first thing we need to do is sort the `players` array so it's ordered from the tallest player to the lowest player. Given that we're not allowed to use closures or most of the standard library yet, I'm going to make my own implementation of [Bubble Sort](https://en.wikipedia.org/wiki/Bubble_sort), which operates by iterating over a list 2 values at a time and swapping the values if they're not in the proper order, and reiterating until the array is sorted. It's not the most optimal sorting algorithm out there, but it's simple, and I've never seen a soccer team or league that has millions of players
*/

var hasSwapped = false

repeat{
    hasSwapped = false // Bubble sort knows it's done when it completes a full pass over the array without changing anything, so we need to start fresh after each pass
    for index in 1..<players.count{ // Starting at the beginning of the array,
        if players[index - 1].height < players[index].height{ // If an element earlier in the array is smaller than the one that comes after it,
            (players[index - 1], players[index]) = (players[index], players[index - 1]) // Swap them
            hasSwapped = true // Also, we need to remember the fact that we swapped things on this pass
        }
    }
}while hasSwapped // As stated before, we want this to repeat until we've made a full pass without swapping anything

//: As we can see, our `players` array is now properly sorted, with the tallest kid first and the shortest kid last 🎉

players

/*:
 ### Constant, Variable, and Function Definitions

 The gist of the greedy number partitioning heuristic is that we make an array for each group we want to sort into (3 in our case), and then we iterate through the all the players, and assign the next tallest player to the group that has the shortest total height. Given that there aren't any major outliers (which the project instructions say is something we can assume), this should come out to be pretty close to equal in height, most likely within 1.5 inches

 However, it's important to note that there's also a limit to the number of experienced players a team is allowed to have.

 In order to do this, we're gonna need some things that are either not in the standard library or I'm not allowed to use yet, so I'm gonna make a few helper functions. First up, in order to sort players normalizing the average heights of each team, I'm going to need to be able to get the total height of a particular team. For what it's worth, this would usually be a perfect use case for `reduce` from the standard library, but that's one of the functions I'm not allowed to use here, so I'm just gonna roll my own
*/

/**
 Finds the total height of a list of players

 - parameter team: A list of players
 - returns: The sum of the height of all players in `team`
 - precondition: Each player within the `team` must have a non-optional `Double` defined for `playerHeightKey`
 */
func totalHeight(of team: [(name: String, height: Double, hasExperience: Bool, parent: String)]) -> Double{
    var total: Double = 0 // If I didn't mark this as a `Double` by default, it'd be inferred as an `Int` and I'd lose the decimals
    for player in team{
        total += player.height
    }
    return total
}

//: Since we're also not allowed to use `filter` from the standard library in this exercise, I'll have to make specialized versions myself when I need them. In this case, I'll need to know the experienced players on a given team

/**
 Finds all the players that have prior soccer experience in a list of players

 - parameter team: An array representing a list of players
 - returns: An array of all players in `team` that have previous soccer experience
 - precondition: Each player in `team` must have a non-optional `Bool` defined for `playerExperienceKey`
 */
func totalExperiencedPlayers(on team: [(name: String, height: Double, hasExperience: Bool, parent: String)]) -> Int{
    var experienced = [(name: String, height: Double, hasExperience: Bool, parent: String)]()
    for player in team{
        if player.hasExperience{
            experienced.append(player)
        }
    }
    return experienced.count
}

//: So, now that we have most of the functions we'll need, let's get started on actually sorting the players. First, we're gonna need an `Array` that contains `Array`s of player tuples to represent each team's list of players. It goes without saying that since we've decided on having 3 teams in this exercise, we'll need 3 of these team `Array`s, though this can be easily changed for however many teams we want to have

var playerGroups = Array(repeating: [(name: String, height: Double, hasExperience: Bool, parent: String)](), count: 3)

//: I'm about to do a bunch of the same casting twice here, and it's relatively complicated, so I'm gonna make a function to do it. It basically just divides 2 `Int`s accounting for decimals but rounding them back up to the next `Int`

/**
 Divides 2 integers, rounding up to the next integer

 Simply dividing the 2 `Int`s would usually result in floor division. For example, dividing `7` by `3` would usually return `2`. However, this function rounds the other direction, so that dividing `7` by `3` would be `3`

 - parameter dividend: The number to be divided
 - parameter divisor: The number with which to divide the dividend
 - returns: The quotient of dividing the `dividend` by the `divisor`, rounded up to the nearest integer
*/
func ceilingDivide(_ dividend: Int, divisor: Int) -> Int{
    return Int((Double(dividend) / Double(divisor)).rounded(.up))
}

//: We'll also need to hang onto how many players a team is allowed to have. In this case, since there are only 3 teams, each team will contain approximately ⅓ of all players in the league. If the number of players in the league isn't evenly divisible by the number of teams, though, some teams might have extras, so we need to know the minimum nuber of players that every team *must* have, and the maximum number of players that some teams *might* have. The difference between these 2 figures should always either be `0` or `1`. It'll be `0` when the players in the league can be evenly distributed into the number of teams in the league, and `1` when they can't and some team(s) will need extra(s). This is achieved by rounding up the `maximum` to the next integer if the players aren't evenly divisible by the teams, and using normal integer division for the `minimum`, which always rounds down

let playerCap = (maximum: ceilingDivide(players.count, divisor: playerGroups.count), minimum: players.count / playerGroups.count)

//: The last major constant we need to know ahead of time is the number of experienced players each team is allowed to have. This is another case where a team might have extras if the number of experienced players in the league isn't evenly divisible by the number of teams, so we have to do all the division stuff from above to get similar information about the experienced players

let experienceCap = (maximum: ceilingDivide(totalExperiencedPlayers(on: players), divisor: playerGroups.count), minimum: totalExperiencedPlayers(on: players) / playerGroups.count)

/*:
 ### Player Partitioning

 The last function we'll need for this is one of the 2 greedy heuristic implementations we'll need to make, this one choosing the team the next player will be sorted into by the total height of all the teams. This function chooses the index of the player list in `playerGroups` that has the smallest total height. I'm going to make 2 overloads, where the base implementation takes an array of indexes to choose from, and another one that takes a range of indexes and passes them to the first implementation
*/

/**
 Chooses the index of the player list in `playerGroups` with the shortest total height of the players it contains, relative to the other player lists in `playerGroups`

 - parameter indexes: An array of indexes to choose from
 - returns: The index of the player list in `playerGroups` with the shortest total height
 - precondition: The list of `indexes` cannot be empty
 - precondition: There must be at least 1 player list in `playerGroups` which contains fewer than the maximum total number of players allowed
*/
func chooseShortestIndex(from indexes: [Int]) -> Int{
//: The whole algorithm here doesn't make sense if we don't have any choices, so we'll just crash if we don't. Normally crashing is bad in production, but this is a playground where this condition should never happen. If it does, it's indicative of a bug I need to address myself
    guard indexes.count > 0 else{
        preconditionFailure("Searched for shortest index in a list of empty indexes")
    }
//: This implementation of the greedy heuristic is fairly time-expensive, so if there's only 1 possible choice, it's better to just return it immediately than go through the whole thing
    guard indexes.count > 1 else{
        return indexes[0]
    }
//: A normal greedy heuristic for this problem would simply sort the player directly into the shortest team. However, we can't quite do that, because we also need to ensure that all the teams have the same total number of players. Therefore, we need to prioritize sorting into a team that's currenly below the minimum number of players that all teams *must* have. In order to do that, we need to figure out which teams those are
    var belowMinimums = [Int]()
    for index in indexes{
        if playerGroups[index].count < playerCap.minimum{
            belowMinimums.append(index)
        }
    }
//: If there's only 1 team left that is below the minimum number of players, we know we need to sort into that one, so we can just `return` it now instead of going through the rest of the heuristic
    if belowMinimums.count == 1{
        return belowMinimums[0]
    }
//: The last thing we need to do before we actually determine the index we'll be `return`ing is figure out for sure what our choices are. If there are some teams which have fewer than the minimum number of players, our choice is easy - we just choose from those. Otherwise, we need to figure out which teams have fewer players than the maximum allowed and only choose from those
    var searchIndexes: [Int]
    if belowMinimums.isEmpty{
        var eligibles = [Int]()
        for index in indexes{
            if playerGroups[index].count < playerCap.maximum{
                eligibles.append(index)
            }
        }
        searchIndexes = eligibles
    }
    else{
        searchIndexes = belowMinimums
    }
//: Finally, we can actually choose the shortest team. We'll start out by assuming it's the first in our list of options, then compare all the rest against that one. If there are any shorter, we'll hang onto it and compare the rest against that one. We can return that shortest index once we find it
    var shortest = searchIndexes[0]
    for index in searchIndexes[1...]{ // This is Swift 4 shorthand for "everything in `searchIndexes` except for the first"
        if totalHeight(of: playerGroups[index]) < totalHeight(of: playerGroups[shortest]){
            shortest = index
        }
    }
    return shortest
}

/**
 Chooses the index of the player list in `playerGroups` with the shortest total height of the players it contains, relative to the other player lists in `playerGroups`

 - parameter range: A range of indexes for `playerGroups` in which to search. Defaults to all possible indexes
 - returns: The index of the player list in `playerGroups` with the shortest total height
 - precondition: There must be at least 1 player list in `playerGroups` which contains fewer than the maximum total number of players allowed
*/
func chooseShortestIndex(from range: Range<Int> = 0..<playerGroups.count) -> Int{
    return chooseShortestIndex(from: Array(range))
}

//: Now that we have all the functions we need and have defined all the constants and variables we'll need, we can get down to actually sorting all the players into their teams. We're gonna do this by splitting all the players into one of 2 categories: either experienced or inexperienced

var experienced = [(name: String, height: Double, hasExperience: Bool, parent: String)]()
var inexperienced = experienced // This just creates another empty array of the same type as `experienced`. Usually I like specifying the type for clarity, but I don't really feel like typing out that long type signature again

for player in players{
    if player.hasExperience{
        experienced.append(player)
    }
    else{
        inexperienced.append(player)
    }
}

//: Now that we have our players split by experience, we're going to place the players that already have previous soccer experience into their teams first. This is another implementation of this problem's greedy heuristic similar to the one in `chooseShortestIndex(from:)` above, but this one prioritizes each team having an equal number of experienced players. If there's a tie, we'll defer to sorting by height like usual. We sort the experienced players first so we don't have to worry about having an equal number of total players on each team at this stage

for player in experienced{
//: This version of the heuristic starts out the same as above. If there are any teams that currently have less than the minimum number of experienced players required, we'll find those so we can only sort into one of them
    var belowMinmums = [Int]()
    for (index, team) in playerGroups.enumerated(){
        if totalExperiencedPlayers(on: team) < experienceCap.minimum{
            belowMinmums.append(index)
        }
    }
//: Just like before, if there aren't any teams that are below the minimum experience count, we'll find the ones that are below the maximum experience count so we can only choose from those
    var searchIndexes: [Int]
    if belowMinmums.isEmpty{
        var eligibles = [Int]()
        for (index, team) in playerGroups.enumerated(){
            if totalExperiencedPlayers(on: team) < experienceCap.maximum{
                eligibles.append(index)
            }
        }
        searchIndexes = eligibles
    }
    else{
        searchIndexes = belowMinmums
    }
//: If there's only 1 team that fits the bill at this stage, we'll place the `player` into that one now and `continue` onto the next player so we don't have to go through the rest of the heuristic
    if searchIndexes.count == 1{
        playerGroups[searchIndexes[0]].append(player)
        continue
    }
//: The major difference between this implementation of the greedy heuristic and the one above is that we're going to account for ties here. If there's more than 1 team that currently have a count of experienced players that are equal to each other but fewer than all the other teams, we'll defer to the height-based heuristic to decide between them. We're going to assume that the first choice we have is the lowest, and then check all the rest. If we find a team which has fewer experiened players, we'll replace the `inexperiencedIndexes` array to only contain that team. If we find a team that has the same number of inexperienced players, we'll add it to the `inexperiencedIndexes` alongside whatever team(s) are already there
    var inexperiencedIndexes = [searchIndexes[0]]
    var leastExperienceCount = totalExperiencedPlayers(on: playerGroups[inexperiencedIndexes[0]]) // I could check this in the loop, but since this function runs in linear time, we'll hang onto it once now so we don't turn this runtime too far into an exponential one
    for index in searchIndexes[1...]{ // This is Swift 4 shorthand for "everything in `searchIndexes` after the first one
        let currentExperience = totalExperiencedPlayers(on: playerGroups[index]) // I'm hanging onto this here for basically the same reason as why I did for `leastExperienceCount`
        if currentExperience < leastExperienceCount{
            inexperiencedIndexes = [index]
            leastExperienceCount = currentExperience
        }
        else if currentExperience == leastExperienceCount{
            inexperiencedIndexes.append(index)
        }
    }
//: We now have an array of indexes to choose from. If there's only 1 index in the list, we've found the team that the `player` should go in, and we place them onto that team. If there's more than one, though, we see which of the possibilities currently has the shortest total height, and we add the `player` to that team
    if inexperiencedIndexes.count > 1{
        playerGroups[chooseShortestIndex(from: inexperiencedIndexes)].append(player)
    }
    else{
        playerGroups[inexperiencedIndexes[0]].append(player)
    }
}

//: At this point, we have all our experienced players placed onto their teams. Now all that's left is to sort the players that don't have previous experience into their teams. This is a lot more straightforward, as we only have to sort according to their height, which we already implemented in `chooseShortestIndex(from:)`, so all we have to do is defer to that function and sort the `player` into the one it chooses

for player in inexperienced{
    playerGroups[chooseShortestIndex()].append(player)
}

//: Once all the player lists are properly sorted, we just need to assign them to a preconstructed team

teamSharks.players = playerGroups[0]
teamDragons.players = playerGroups[1]
teamRaptors.players =  playerGroups[2]

//: Also, here's a quick definition for the rest of this playground. It's going to make everything from now on easier if I have an array of all the teams in the league

let teams = [teamSharks, teamDragons, teamRaptors]

//: Now we can see that all the teams have a list of players assigned to them, and they're all evenly matched, including having the same number of players, the same number of *experienced* players, and an average height within 1.5 inches of each other 🎉

print("Team summaries:\n")
for team in teams{
    print("- \(team.name):")
    print(" - \(totalHeight(of: team.players) / Double(team.players.count)) inches")
    print(" - Experienced players: \(totalExperiencedPlayers(on: team.players))")
    print(" - Total players: \(team.players.count)")
}

/*:
 ---
 ## Letters

 Now that we have everybody properly sorted, all we have left to do is generate and print out the letters to the parents, which is a pretty simple task. It's likely not really necessary without the requirement, but it's in the spec that we have to store all the letters in a collection called `letters`, so we're gonna start out by making an `Array` of `String`s for that
*/

var letters = [String]()

//: All in all, this is really short and sweet. Normally I'd put everything directly in this loop, but since we have to store each letter in the `letters` array, we're just gonna loop over all the teams, and for each player on each team, we're gonna generate a letter to their parents about what team they got placed on and when they meet for their first practice, and add that letter to the `letters` array

for team in teams{
    for player in team.players{
        letters.append("""
Dear \(player.parent),

    We are pleased to inform you that your child, \(player.name) has been placed on the \(team.name) for the upcoming 2018 soccer season! This will be an exciting year, and your child will be a very valuable member of their team.

    The \(team.name)' first practice will be on \(team.practice.date) at \(team.practice.time) at Memorial Field in Drake's Creek Park, and it's mandatory that you and your child must attend. The practice will last approximately 1.5 - 2 hours. Your child will get to know their new teammates and the basics of how to stretch properly and perform a few practice drills, all while you meet your fellow team parents, learn about the upcoming schedule, and how you can best care for and support your child during the upcoming season. Please bring all the necessary release forms that have been sent with this letter. Your child will be provided with a uniform, but we ask that you please bring them equipped with cleats that fit well and shin guards.

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
