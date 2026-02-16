local DeckPosition = {
  table=State.TableName,
  x="0",
  y="0"
}
local DeckPositionLocation = "("..DeckPosition.x..", "..DeckPosition.y..")"
local StackPosition = {
  table=State.TableName,
  x="0",
  y="1"
}
local StackPositionLocation = "("..StackPosition.x..", "..StackPosition.y..")"
local CurrentPlayer = nil
local PlayerScores : {[number]: number} = {}
local Colors = {
  "heart",
  "diamond",
  "club",
  "spade"
}
local Values = {
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "jack",
  "queen",
  "king",
  "ace"
}
function GetVariations() : {string}
  local variations = {}
  for _, color in ipairs(Colors) do
    for _, value in ipairs(Values) do
      table.insert(variations, color.."-"..value)
    end
  end
  return variations
end
function SpawnDeck(cell)
  local variations = GetVariations()
  local tableName = cell.table
  local vector = "("..cell.x..", "..cell.y..")"
  local objects = {}
  for i = #variations, 2, -1 do
    local j = math.random(i)
    variations[i], variations[j] = variations[j], variations[i]
  end
  for _, variation in ipairs(variations) do
    table.insert(objects, {
      asset=State.Namespace..":cards",
      variation=variation,
      hidden=true,
    })
  end
  Server:Send({
    type="ObjectsSpawned",
    table=tableName,
    objects={
      [vector]=objects
    }
  }, nil)
end
function ResetWorld()
  Server:Send({
    type="ObjectsRemoved",
    cell=DeckPosition
  }, nil)
  Server:Send({
    type="ObjectsRemoved",
    cell=StackPosition
  }, nil)
end
function Reset()
  ResetWorld()
  PlayerScores = {}
  CurrentPlayer = nil
  Setup()
end
function Setup()
  print("setup")
  print(State.Namespace)
  SpawnDeck(DeckPosition)
end
function RemoveStack()
  Server:Send({
    type="ObjectsRemoved",
    cell=StackPosition
  }, nil)
end
local VariationsScores : {[string]: {number}} = {
  ["2"] = {2},
  ["3"] = {3},
  ["4"] = {4},
  ["5"] = {5},
  ["6"] = {6},
  ["7"] = {7},
  ["8"] = {8},
  ["9"] = {9},
  ["10"] = {10},
  jack = {10},
  queen = {10},
  king = {10},
  ace = {1, 11}
}
local MaxScore = 21
function CalculateCard(identifier) : {number}
  print(" - object: "..tostring(identifier["variation"]))
  local splitted = string.split(identifier["variation"], "-")
  print(" - splitted: "..tostring(#splitted))
  if #splitted ~= 2 then
    return {}
  end
  local value = splitted[2]
  print(" - value: "..tostring(value))
  return VariationsScores[value]
end
function GetCellObjects(position)
  local table = State:GetTable("")
  for k, v in pairs(table.cells) do
    print(" - "..tostring(k)..": "..tostring(v))
  end
  local cell = table.cells["("..position.x..", "..position.y..")"]
  if not cell then
    return {}
  end
  return cell.objects or {}
end
function CalculateStack(optionalCard : any) : number
  -- Gather identifiers of cards currently in the stack cell.
  -- Assuming an API like GetCellObjects(cell) -> { { identifier = "..." }, ... }
  local objects = GetCellObjects(StackPosition)
  if optionalCard then
    table.insert(objects, optionalCard)
  end
  print("Calculating stack for "..#objects.." objects")

  -- Start with a single possible sum: 0
  local sums = {0}

  for _, obj in pairs(objects) do
    local values = CalculateCard(obj) or {0}
    print(" - possible values: "..table.concat(values, ", "))
    local newSums = {}
    for _, base in ipairs(sums) do
      for _, v in ipairs(values) do
        local candidate = base + v
          -- Deduplicate
        if not table.find(newSums, candidate) then
          table.insert(newSums, candidate)
        end
      end
    end
    sums = newSums
  end
  print(" - possible sums: "..table.concat(sums, ", "))

  -- Choose the best sum: highest <= MaxScore, otherwise the lowest bust
  local bestUnder = nil
  local lowestOver = nil
  for _, total in ipairs(sums) do
    if total <= MaxScore then
      if not bestUnder or total > bestUnder then
        bestUnder = total
      end
    else
      if not lowestOver or total < lowestOver then
        lowestOver = total
      end
    end
  end

  if bestUnder then
    return bestUnder
  end
  return lowestOver or 0
end
function FinishTurn(score)
  if not score then
    score = CalculateStack()
  end
  PlayerScores[CurrentPlayer] = score
  Server:Send({
    type="MessageSent",
    user=0,
    message="Player "..CurrentPlayer.." finished with "..score.." points."
  }, nil)
  RemoveStack()
  
  local allPlayed = true
  if State.Players then
    for _, player in ipairs(State.Players) do
      if not PlayerScores[player] then
        allPlayed = false
        break
      end
    end
  end

  CurrentPlayer = nil
  if allPlayed then
    FinishRound()
  else
    print("Waiting for next player to take a card.")
  end
end
function FinishRound()
  -- Determine winner(s)
  local highest = 0
  local winners = {}
  for player, score in pairs(PlayerScores) do
    if score <= MaxScore then
      if score > highest then
        highest = score
        winners = {player}
      elseif score == highest then
        table.insert(winners, player)
      end
    end
  end
  -- Announce winners (assuming an API like Send(event))
  if #winners > 0 then
    print("Winners: "..table.concat(winners, ", ").." with score "..highest)
  else
    print("No winners this round.")
  end
  Reset()
end
function GetTopCardFromDeck() : string?
  local cell = State:GetTable("").cells["("..DeckPosition.x..", "..DeckPosition.y..")"]
  if not cell or not cell.objects or #cell.objects == 0 then
    return nil
  end
  return cell.objects[1]
end
function OnNewCard()
  local topCardId = GetTopCardFromDeck()
  print("Dealt new card: "..tostring(topCardId))
  local score = CalculateStack(topCardId)
  print("Current score: "..score)
  Server:Send({
    type="MessageSent",
    user=0,
    message="Your current score is "..score
  }, nil)
  if score > MaxScore then
    print("Player "..CurrentPlayer.." busted!")
    Server:Send({
      type="MessageSent",
      user=0,
      message="Player "..CurrentPlayer.." busted with "..score.." points!"
    }, nil)
    FinishTurn(score)
  end
end

Events.CellHideChanged.Connect(function(_, details)
  details.cancelled = true
end)
Events.ObjectsSpawned.Connect(function(event, details)
  details.cancelled = true
  print("Spawning objects is not allowed.")
end)
Events.BoardsSpawnRequest.Connect(function(event, details)
  details.cancelled = true
  print("Spawning boards is not allowed.")
end)
Events.ObjectsMoved.Connect(function(event, details)
  print("typing move event.."..type(event))
  local isFromDeck = event.table == DeckPosition.table and event.from == DeckPositionLocation
  local isToStack = event.table == StackPosition.table and event.to == StackPositionLocation
  local objects = event.objects
  local isOneObject = #objects == 1 and event.objects[1] == 0
  if(not isFromDeck or not isToStack or not isOneObject) then
    print("Invalid move attempted.")
    details.cancelled = true
    return
  end

  if CurrentPlayer == nil then
    CurrentPlayer = details.source
    print("Player "..CurrentPlayer.." started turn.")
  elseif CurrentPlayer ~= details.source then
    print("It's not your turn! Current player: "..tostring(CurrentPlayer))
    details.cancelled = true
    return
  end

  OnNewCard()
  details:ScheduleEvent({
    type="CellHideChanged",
    cell=StackPosition,
    hide=false
  })
end)
Events.MessageRequest.Connect(function(event, details)
  local message = event.message:lower()
  if message == "!stand" or message == "!stay" then
    if details.source == CurrentPlayer then
      FinishTurn()
    else
      print("It's not your turn!")
    end
    details.cancelled = true
  end
end)
Events.UserJoined.Connect(function(event, details)
  Server:Send( {
    type="ToolbarUpdated",
    toolbar={
      editable=false,
      actions={
        {
          id="blackjack_stand",
          label="Stand",
          enabled=true,
        }
      }
    }
  }, details.source)
end)
Events.ToolbarActionRequest.Connect(function(event, details)
  print("Toolbar action requested: "..event.actionId)
  if event.actionId == "blackjack_hit" then
    if details.source == CurrentPlayer then
      OnNewCard()
    else
      print("It's not your turn!")
    end
    details.cancelled = true
  elseif event.actionId == "blackjack_stand" then
    if details.source == CurrentPlayer then
      FinishTurn()
    else
      print("It's not your turn!")
    end
    details.cancelled = true
  end
end)

Setup()
