local DeckPosition = {
  table=State.TableName,
  x="0",
  y="0"
}
local StackPosition = {
  table=State.TableName,
  x="0",
  y="1"
}
local CurrentPlayer = 1
local PlayerScores : {[number]: number} = {}
function Reset()
  ResetWorld()
  PlayerScores = {}
  CurrentPlayer = 1
  Setup()
end
function Setup()
  print("setup")
  print(State.PluginId)
  Server:Process({
    type="CellVisibilityChanged",
    cell=DeckPosition,
    visibility=false
  }, true)
  Server:Process({
    type="DeckSpawned",
    cell=DeckPosition,
    deck=State.PluginId..":cards"
  }, true)
  Server:Process({
    type="CellShuffleRequest",
    cell=DeckPosition
  }, true)
end
function RemoveStack()
  Server:Process({
    type="ObjectsRemoved",
    cell=StackPosition
  }, true)
end
local VariationsScores : {[string]: {number}} = {
  ["1"] = {1},
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
  local splitted = string.split(identifier, ":")
  if #splitted ~= 2 or splitted[1] ~= State.PluginId then
    return {0}
  end 
  splitted = string.split(splitted[2], "-")
  if #splitted ~= 2 then
    return {0}
  end
  local value = splitted[1]
  return VariationsScores[value]
end
function GetCellObjects(position)
  local cell = State.Table.cells["("..position.x..", "..position.y..")"]
  if not cell then
    return {}
  end
  return cell.objects or {}
end
function CalculateStack() : number
  -- Gather identifiers of cards currently in the stack cell.
  -- Assuming an API like GetCellObjects(cell) -> { { identifier = "..." }, ... }
  local objects = GetCellObjects(StackPosition)

  -- Start with a single possible sum: 0
  local sums = {0}

  for _, obj in pairs(objects) do
    local id = obj.identifier or obj.id or obj.cardId
    if id then
      local values = CalculateCard(id) or {0}
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
  end

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
function GetNextPlayer() : number?
  local index = table.find(State.Players, CurrentPlayer)
  if not index then
    return nil
  end
  index = index + 1
  if index > #State.Players then
    index = 1
  end
  return State.Players[index]
end
function NextRound()
  PlayerScores[CurrentPlayer] = CalculateStack()
  RemoveStack()
  CurrentPlayer = GetNextPlayer() or CurrentPlayer
  if CurrentPlayer == 1 then
    -- All players had their turn, round is over.
    FinishRound()
  end
  print("Player "..CurrentPlayer.."'s turn")
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
function OnNewCard()
  local score = CalculateStack()
  print("Current score: "..score)
  if score > MaxScore then
    print("Player "..CurrentPlayer.." busted!")
    NextRound()
  end
end

Events.CellHideChanged.Connect(function(_, details)
  details.cancelled = true
end)
Events.ObjectsSpawned.Connect(function(event, details)
  details.cancelled = true
  print("Spawning objects is not allowed.")
end)
Events.ObjectMoved.Connect(function(event, details)
  local isFromDeck = event.from.table == DeckPosition.table and event.from.x == DeckPosition.x and event.from.y == DeckPosition.y
  local isToStack = event.to.table == StackPosition.table and event.to.x == StackPosition.x and event.to.y == StackPosition.y
  if(not isFromDeck or not isToStack) then
    details.cancelled = true
    return
  end
  OnNewCard()
end)
Events.MessageRequest.Connect(function(event, details)
  local message = event.message:lower()
  if message == "!stand" or message == "!stay" then
    if details.source == CurrentPlayer then
      NextRound()
    else
      print("It's not your turn!")
    end
    details.cancelled = true
  end
end)

Setup()
