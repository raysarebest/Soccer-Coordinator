# Soccer Coordinator
## *Treehouse iOS Techdegree Project 1*
---

You have volunteered to be the coordinator for your town’s youth soccer league. As part of your job you need to divide the 18 children who have signed up for the league into three even teams — Dragons, Sharks, and Raptors. In years past, the teams have been unevenly matched, so this year you are doing your best to fix that. For each child, you will have the following information: Name, height (in inches), whether or not they have played soccer before, and their guardians’ names. All code will be written and executed in a Swift Playground

## Requirements

***NOTE:*** You can *only* use tools and constructs covered in [Swift Basics](https://teamtreehouse.com/library/swift-basics-2), [Swift Collections and Control Flow](https://teamtreehouse.com/library/swift-collections-and-control-flow), and [Functions in Swift](https://teamtreehouse.com/library/functions-in-swift)

#### Part 1: Create required collections
- [ ] Create a single collection named `players` that contains all information for all 18 players
- [ ] Represent each player with a `Dictionary` with `String` keys and the corresponding values
- [ ] Store players for each team in collections named `teamSharks`, `teamDragons`, and `teamRaptors`

#### Part 2: Create satisfactory logic
- [ ] Create logic that sorts players into 3 even teams, based on player experience
    - [ ] The algorithm must not be based on magic or hard coded numbers or indexes

#### Part 3: Personalized Letters
- [ ] Store all 18 letters in the a collection called `letters`, including the player’s name, guardian names, team name, and date/time of their first team practice
- [ ] Format each letter
- [ ] Print each letter to the console
    - [ ] The word “Optional” must not be present in the letter content

<table id="practice-times">
    <thead>
        <tr>
            <th colspan="6">Team Practices</th>
        </tr>
        <tr>
            <th colspan="2">Dragons</th>
            <th colspan="2">Sharks</th>
            <th colspan="2">Raptors</th>
        </tr>
        <tr>
            <th>Date</th>
            <th>Time</th>
            <th>Date</th>
            <th>Time</th>
            <th>Date</th>
            <th>Time</th>
    </thead>
    <tbody>
        <tr>
            <td>March 17</td>
            <td>1 PM</td>
            <td>March 17</td>
            <td>13 PM</td>
            <td>March 18</td>
            <td>1 PM</td>
        </tr>
    </tbody>
</table>

#### Part 4: Naming and Comments
- [ ] Include comments
- [ ] Ensure specified naming requirements for constants, variables, keys, and methods are met

### Extra Credit

- [ ] Logic must sort players into 3 even teams based on player experience *and* height
    - [ ] All teams must have an average height within 1.5 inches of each other
    - [ ] Must not depend on initial order of the collection of players
- [ ] Print average height of each team to the console