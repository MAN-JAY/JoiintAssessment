# Assessment

This is a command line application to solve the below mentioned problems. 

### Problem1
Given a two-dimensional grid (board) and word, find out whether the word exists in the grid. The word must be in alphabetical order and formed by letters in the adjacent cells where "adjacent" cells are those that are adjacent horizontally or vertically letters in the same cell are not allowed to be reused.

Example-
```elixir
board = [ 
  ['A','B','C','E'], 
  ['S','F','C','S'], 
  ['A','D','E','E'] 
] 
word1 = "ABCCED"          #return true 
word = "SEE"              #return true 
word = "ABCB"             #return false
```

### Problem2
You are a medieval king attacking your opponent at five locations simultaneously Each location has a platoon - which has a number of soldiers of a specific class You know the platoons your opponent has Your job is to figure out which of your platoons should attack which of your opponent's platoons so that you can win majority of the battles.

Advantage Map for platoons-
```json
{
    "Militia": ["Spearmen", "LightCavalry"],
    "Spearmen": ["LightCavalry", "HeavyCavalry"],
    "LightCavalry": ["FootArcher", "CavalryArcher"],
    "HeavyCavalry": ["Militia", "FootArcher", "LightCavalry"],
    "CavalryArcher": ["Spearmen", "HeavyCavalry"],
    "FootArcher": ["Militia", "CavalryArcher"]
}
```
The input to the problem statement is the list of platoons that you have with their classes and number of units in the first line The second line contains the list of platoons of the opponent (PlatoonClasses#NoOfSoldiers)

The output of the program should be to give a sequence in which you should arrange your platoons so that you win atleast 3 of the 5 battles. There could be multiple winning arrangements, it is enough to print one of the possible arrangements If there is no possibility to get atleast 3 out of 5 wins in any arrangement, it should intimate that with an error message that "There is no chance of winning"

Sample Input:
```txt
Spearmen#10; Militia#30; FootArcher#20; LightCavalry#1000; HeavyCavalry#120 
Militia#10; Spearmen#10; FootArcher#1000; LightCavalry#120; CavalryArcher#100
```

Sample Output:
```txt
Militia#30; FootArcher#20; Spearmen#10; LightCavalry#1000; HeavyCavalry#120\
```

---

## Technical stack 

This application is built using elixir, although to execute this application [erlang v11.0](https://erlang.org/doc/installation_guide/users_guide.html) and above should be installed or even [elixir v1.10](https://elixir-lang.org/install.html) and above can also be installed. To package the application [Docker](https://www.docker.com/) containerization is user. Follow this [link](https://www.docker.com/get-started) to setup docker.
Libraries used are:
* [Poison v3.1](https://hex.pm/packages/poison) : For Encoding and Decoding JSON
* [ExCoveralls v14.4](https://hex.pm/packages/excoveralls) : For test coverage


---
## Usage

### Dev-
* Clone the repository
* Run the test scenarios `mix test`. Navigate to `./test/*.exs` For all test cases
* Run `mix coveralls` to get overall summary and coverage of test cases
* Build the project `MIX_ENV=prod mix escript.build`
* Run `./assessment -c "path_to_cadvantage_map.json"`

### Realtime-
* Clone the repository to local
  ![]( "Local Repo")

* execute `make build`
  ![]( "make build command")

* execute `make run` and provide a same input
  ![]( "make run command")

* And output should be as follows - 
  ![]( "output")
---
