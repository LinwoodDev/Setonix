--!nolint UnknownGlobal

local DeckCell = Setonix.cells.get(0, 0)
local StackCell = Setonix.cells.get(0, 1)
local MaxScore = 21
local CurrentPlayer : number? = nil
local PlayerScores : {[number]: number} = {}
local Toolbar = {
  editable = false,
  actions = {
    Setonix.server.toolbarAction("blackjack_hit", "Hit"),
    Setonix.server.toolbarAction("blackjack_stand", "Stand"),
  },
}

local CardScores : {[string]: {number}} = {
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

local function getCardVariations() : {string}
  local suits = {
    "heart",
    "diamond",
    "club",
    "spade",
  }
  local ranks = {
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
    "ace",
  }
  local variations = {}
  for _, suit in ipairs(suits) do
    for _, rank in ipairs(ranks) do
      table.insert(variations, suit .. "-" .. rank)
    end
  end
  return variations
end

local function spawnStackedObjects(cell, asset, variations, options)
  local objects = {}
  for _, variation in ipairs(variations) do
    local object_options = {
      hidden = options and options.hidden == true,
      variation = variation,
    }
    table.insert(objects, Setonix.object(asset, object_options))
  end
  cell:spawn(objects)
end

local function resetWorld()
  DeckCell:clear()
  StackCell:clear()
end

local function resetRoundState()
  PlayerScores = {}
  CurrentPlayer = nil
end

local function setupRound()
  resetWorld()
  spawnStackedObjects(
    DeckCell,
    Setonix.namespace() .. ":cards",
    Setonix.collections.shuffle(getCardVariations()),
    { hidden = true }
  )
end

local function resetRound()
  resetRoundState()
  setupRound()
end

local function notifyPlayer(playerId : number, message : string)
  Setonix.player(playerId):sendMessage(message)
end

local function getStackCards(optionalCard : any?) : {any}
  local cards = {}
  for _, card in ipairs(StackCell:objects()) do
    table.insert(cards, card)
  end
  if optionalCard ~= nil then
    table.insert(cards, optionalCard)
  end
  return cards
end

local function calculateStack(optionalCard : any?) : number
  local score_values = {}
  for rank, values in pairs(CardScores) do
    score_values[rank] = values
  end
  return Setonix.scoring.bestTotal(getStackCards(optionalCard), function(card)
    local variation = card and card.variation
    if variation == nil then
      return {0}
    end
    local parts = string.split(variation, "-")
    if #parts ~= 2 then
      return {0}
    end
    return score_values[parts[2]] or {0}
  end, MaxScore)
end

local function claimTurn(playerId : number) : boolean
  if CurrentPlayer == nil then
    CurrentPlayer = playerId
    Setonix.broadcast("Player " .. playerId .. " started turn.")
    return true
  end
  if CurrentPlayer ~= playerId then
    notifyPlayer(playerId, "It's not your turn!")
    return false
  end
  return true
end

local function finishRound()
  local highest = 0
  local winners = {}
  for playerId, score in pairs(PlayerScores) do
    if score <= MaxScore then
      if score > highest then
        highest = score
        winners = { playerId }
      elseif score == highest then
        table.insert(winners, playerId)
      end
    end
  end

  if #winners > 0 then
    Setonix.broadcast(
      "Winners: " .. table.concat(winners, ", ") .. " with score " .. highest
    )
  else
    Setonix.broadcast("No winners this round.")
  end

  resetRound()
end

local function finishTurn(score : number?)
  local playerId = CurrentPlayer
  if playerId == nil then
    return
  end

  local finalScore = score or calculateStack()
  PlayerScores[playerId] = finalScore
  Setonix.broadcast("Player " .. playerId .. " finished with " .. finalScore .. " points.")
  StackCell:clear()
  CurrentPlayer = nil

  local allPlayed = true
  for _, player in ipairs(Setonix.players.all()) do
    if PlayerScores[player.id] == nil then
      allPlayed = false
      break
    end
  end

  if allPlayed then
    finishRound()
  else
    Setonix.broadcast("Waiting for next player to take a card.")
  end
end

local function evaluateDraw(playerId : number, drawnCard : any?)
  local score = calculateStack(drawnCard)
  notifyPlayer(playerId, "Your current score is " .. score)
  if score > MaxScore then
    Setonix.broadcast("Player " .. playerId .. " busted with " .. score .. " points!")
    finishTurn(score)
  end
end

local function drawFromToolbar(playerId : number)
  if not claimTurn(playerId) then
    return
  end

  local topCard = DeckCell:topObject()
  if topCard == nil then
    notifyPlayer(playerId, "No cards are left in the deck.")
    return
  end

  DeckCell:moveTopTo(StackCell, 1)
  StackCell:show()
  evaluateDraw(playerId, topCard)
end

Setonix.events.on("cell_hide_changed", function(event)
  event:cancel()
end)

Setonix.events.on("objects_spawned", function(event)
  event:cancel()
  Setonix.log("Spawning objects is not allowed.")
end)

Setonix.events.on("boards_spawn_request", function(event)
  event:cancel()
  Setonix.log("Spawning boards is not allowed.")
end)

Setonix.events.on("objects_moved", function(event)
  local isFromDeck = event.table == DeckCell.table and event.from ~= nil and event.from:equals(DeckCell)
  local isToStack = event.to ~= nil and event.to:equals(StackCell)
  local isSingleTopCard = #event.objects == 1 and event.objects[1] == 0

  if not isFromDeck or not isToStack or not isSingleTopCard then
    Setonix.log("Invalid move attempted.")
    event:cancel()
    return
  end

  if not claimTurn(event.source) then
    event:cancel()
    return
  end

  evaluateDraw(event.source, DeckCell:topObject())
  event:schedule(Setonix.server.events.cellHideChanged(StackCell, false))
end)

Setonix.commands.register("stand", function(event)
  if event.source == CurrentPlayer then
    finishTurn()
  else
    notifyPlayer(event.source, "It's not your turn!")
  end
  event:cancel()
end)

Setonix.commands.register("stay", function(event)
  if event.source == CurrentPlayer then
    finishTurn()
  else
    notifyPlayer(event.source, "It's not your turn!")
  end
  event:cancel()
end)

Setonix.events.on("user_joined", function(event)
  event.player:setToolbar(Toolbar)
end)

Setonix.events.action("blackjack_hit", function(event)
  drawFromToolbar(event.source)
end)

Setonix.events.action("blackjack_stand", function(event)
  if event.source == CurrentPlayer then
    finishTurn()
  else
    notifyPlayer(event.source, "It's not your turn!")
  end
end)

resetRound()
