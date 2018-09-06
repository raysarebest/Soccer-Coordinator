# Soccer Coordinator
## *Treehouse iOS Techdegree Project 1*

You have volunteered to be the coordinator for your town’s youth soccer league. As part of your job you need to divide the 18 children who have signed up for the league into three even teams — Dragons, Sharks, and Raptors. In years past, the teams have been unevenly matched, so this year you are doing your best to fix that. For each child, you will have the following information: Name, height (in inches), whether or not they have played soccer before, and their guardians’ names. All code will be written and executed in a Swift Playground

## Requirements

***NOTE:*** You can *only* use tools and constructs covered in [Swift Basics](https://teamtreehouse.com/library/swift-basics-2), [Swift Collections and Control Flow](https://teamtreehouse.com/library/swift-collections-and-control-flow), and [Functions in Swift](https://teamtreehouse.com/library/functions-in-swift)

#### Part 1: Create required collections
- [x] Create a single collection named `players` that contains all information for all 18 players
- [x] Represent each player with a `Dictionary` with `String` keys and the corresponding values
- [x] Store players for each team in collections named `teamSharks`, `teamDragons`, and `teamRaptors`

#### Part 2: Create satisfactory logic
- [x] Create logic that sorts players into 3 even teams, based on player experience
    - [x] The algorithm must not be based on magic or hard coded numbers or indexes

#### Part 3: Personalized Letters
- [ ] Store all 18 letters in the a collection called `letters`, including the player’s name, guardian names, team name, and date/time of their first team practice
- [ ] Format each letter
- [ ] Print each letter to the console
    - [ ] The word “Optional” must not be present in the letter content

<table>
    <thead>
        <tr>
            <th colspan="4">Team Practices</th>
        </tr>
        <tr>
            <th></th>
            <th>Dragons</th>
            <th>Sharks</th>
            <th>Raptors</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <th>Date</th>
            <td>March 17</td>
            <td>March 17</td>
            <td>March 18</td>
        </tr>
        <tr>
            <th>Time</th>
            <td>1 PM</td>
            <td>3 PM</td>
            <td>1 PM</td>
        </tr>
    </tbody>
</table>

#### Part 4: Naming and Comments
- [ ] Include comments
- [ ] Ensure specified naming requirements for constants, variables, keys, and methods are met

### Extra Credit

- [x] Logic must sort players into 3 even teams based on player experience *and* height
    - [x] All teams must have an average height within 1.5 inches of each other
    - [x] Must not depend on initial order of the collection of players
- [x] Print average height of each team to the console
