--!nolint UnknownGlobal

-- The round is authoritative Lua state. Board cells are only a projection:
-- Send() queues board updates, so reading cells again in the same callback can
-- otherwise score an old hand or draw the same card twice.
local StorageKey = "round"
local ScoreNote = "Blackjack"
local MaxScore = 21
local HandWidth = 6
local Round
local Busy = false
local Departed = {}
local TableRef
local DeckCell
local DealerCell

local CardScores = {
  ["2"] = {2}, ["3"] = {3}, ["4"] = {4}, ["5"] = {5},
  ["6"] = {6}, ["7"] = {7}, ["8"] = {8}, ["9"] = {9},
  ["10"] = {10}, jack = {10}, queen = {10}, king = {10}, ace = {1, 11},
}

local function score(hand)
  return Setonix.scoring.bestTotal(hand, function(variation)
    return CardScores[string.match(variation, "%-([^-]+)$")] or {0}
  end, MaxScore)
end

local function newDeck()
  local cards = {}
  for _, suit in ipairs({"heart", "diamond", "club", "spade"}) do
    for _, rank in ipairs({"2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king", "ace"}) do
      table.insert(cards, suit .. "-" .. rank)
    end
  end
  return Setonix.collections.shuffle(cards)
end

local function currentSeat()
  return Round.players[Round.turn]
end

local function findSeat(id)
  for _, seat in ipairs(Round.players) do
    if seat.id == id then
      return seat
    end
  end
  return nil
end

local function onlineIds(excluded)
  local ids = {}
  for _, player in ipairs(Setonix.players.all()) do
    if player.id ~= excluded and not Departed[player.id] then
      table.insert(ids, player.id)
    end
  end
  return Setonix.collections.sorted(ids)
end

local function reply(id, message)
  Setonix.player(id):sendMessage(message)
end

local function save()
  Setonix.storage.set(StorageKey, Round)
end

local function cardObjects(hand, hidden, dealer)
  local objects = {}
  for index, variation in ipairs(hand) do
    table.insert(objects, Setonix.object(Setonix.namespace() .. ":cards", {
      variation = variation,
      hidden = hidden or (dealer and Round.phase == "playing" and index == 2),
    }))
  end
  return objects
end

local function layout()
  TableRef:setBounds({x = 0, y = 0}, {x = HandWidth - 1, y = math.max(#Round.players, 1)})
  DealerCell:layout({type = "DistributeCellMergeStrategy", direction = "horizontal", maxCards = 52, fillVariableSpace = false}, HandWidth - 1)
  -- Keep the previous round's rows empty when the player count shrinks.
  for row = 1, math.max(Round.rows or 0, #Round.players, 1) do
    local cell = TableRef:cell(0, row)
    if row <= math.max(#Round.players, 1) then
      cell:layout({type = "DistributeCellMergeStrategy", direction = "horizontal", maxCards = 52, fillVariableSpace = false}, HandWidth)
    end
  end
  Round.rows = math.max(#Round.players, 1)
end

local function render()
  DeckCell:setObjects(cardObjects(Round.deck, true, false))
  DealerCell:setObjects(cardObjects(Round.dealer, false, true))
  for row = 1, math.max(Round.rows or 0, 1) do
    local seat = Round.players[row]
    TableRef:cell(0, row):setObjects(cardObjects(seat and seat.hand or {}, false, false))
  end
end

local function updateToolbar(id)
  local seat = findSeat(id)
  local active = Round.phase == "playing" and currentSeat() and currentSeat().id == id
  local betweenRounds = Round.phase ~= "playing"
  local status = "Round " .. Round.number .. " · " .. (Round.rules == "dealer" and "Dealer" or "Competition")
  if seat ~= nil then
    status = "Hand: " .. score(seat.hand) .. " · " .. (seat.result or seat.status)
  elseif not betweenRounds then
    status = "Spectating · join next round"
  end
  Setonix.player(id):setToolbar({
    editable = false,
    actions = {
      Setonix.server.toolbarAction("blackjack_status", status, false),
      Setonix.server.toolbarAction("blackjack_start", Round.phase == "finished" and "Next round" or "Deal", betweenRounds),
      Setonix.server.toolbarAction("blackjack_hit", "Hit", active and #Round.deck > 0),
      Setonix.server.toolbarAction("blackjack_stand", "Stand", active),
      Setonix.server.toolbarAction("blackjack_scores", "Scores"),
      Setonix.server.toolbarAction("blackjack_rules", "Rules: " .. Round.rules, betweenRounds and id == Round.host),
      Setonix.server.toolbarAction("blackjack_help", "Help"),
    },
  })
end

local function updateNotes()
  local lines = {
    "# Blackjack",
    "**Round " .. Round.number .. " · " .. (Round.rules == "dealer" and "Dealer" or "Competition") .. "**",
    "",
  }
  if Round.phase == "ready" then
    table.insert(lines, "Choose **Deal** to start.")
  elseif Round.phase == "playing" then
    local seat = currentSeat()
    table.insert(lines, "**Player " .. seat.id .. "'s turn** · row " .. Round.turn)
    table.insert(lines, "Choose **Hit** or **Stand**.")
  else
    table.insert(lines, "Round complete. Choose **Next round** to play again.")
  end
  if Round.rules == "dealer" and #Round.dealer > 0 then
    local hidden = Round.phase == "playing"
    local total = hidden and score({Round.dealer[1]}) or score(Round.dealer)
    table.insert(lines, "")
    table.insert(lines, "**Dealer:** " .. total .. (hidden and " + hidden card" or (total > MaxScore and " · bust" or "")))
  end
  if #Round.players > 0 then
    table.insert(lines, "")
    table.insert(lines, "| Row | Player | Score | Status |")
    table.insert(lines, "| --- | --- | --- | --- |")
    for row, seat in ipairs(Round.players) do
      local status = seat.result or seat.status
      if status == "playing" then status = "**Playing**" end
      table.insert(lines, "| " .. row .. " | " .. seat.id .. " | " .. score(seat.hand) .. " | " .. status .. " |")
    end
  end
  table.insert(lines, "")
  table.insert(lines, "## Rules")
  table.insert(lines, "Aces count as **1 or 11**. Face cards count as **10**. Going over **21** loses.")
  table.insert(lines, Round.rules == "dealer"
    and "Beat the dealer, who stands on **17**, including soft 17. A two-card blackjack beats other 21s. Equal hands push."
    or "The highest hand at or below 21 wins. Ties share the win.")
  table.insert(lines, "")
  table.insert(lines, "The host can switch rules between rounds. Late arrivals join the next round.")
  Setonix.notes.set(ScoreNote, table.concat(lines, "\n"))
end

local function refresh(excluded)
  local ids = onlineIds(excluded)
  if not table.find(ids, Round.host) then
    Round.host = ids[1]
  end
  for _, id in ipairs(ids) do
    updateToolbar(id)
  end
  updateNotes()
  save()
end

local function draw(hand)
  if #Round.deck == 0 then
    return false
  end
  table.insert(hand, table.remove(Round.deck, 1))
  return true
end

local function scoreboard(id)
  local lines = {"Round " .. Round.number .. " (" .. Round.rules .. ")"}
  if Round.rules == "dealer" and #Round.dealer > 0 then
    local dealerScore = Round.phase == "playing" and score({Round.dealer[1]}) or score(Round.dealer)
    table.insert(lines, "Dealer: " .. dealerScore .. (Round.phase == "playing" and " + hidden card" or ""))
  end
  for row, seat in ipairs(Round.players) do
    table.insert(lines, "Player " .. seat.id .. " (row " .. row .. "): " .. score(seat.hand) .. " · " .. (seat.result or seat.status))
  end
  reply(id, table.concat(lines, "\n"))
end

local function finishRound()
  Round.phase = "finished"
  if Round.rules == "dealer" then
    local hasLiveHand = false
    for _, seat in ipairs(Round.players) do
      if seat.status ~= "left" and score(seat.hand) <= MaxScore then
        hasLiveHand = true
      end
    end
    while hasLiveHand and score(Round.dealer) < 17 and draw(Round.dealer) do end
    local dealerScore = score(Round.dealer)
    local dealerBlackjack = #Round.dealer == 2 and dealerScore == MaxScore
    Setonix.broadcast("Dealer reveals " .. dealerScore .. (dealerBlackjack and " (blackjack)." or " points."))
    for _, seat in ipairs(Round.players) do
      local total = score(seat.hand)
      local natural = seat.status == "blackjack"
      if seat.status == "left" then
        seat.result = "left"
      elseif total > MaxScore then
        seat.result = "loss"
      elseif dealerBlackjack then
        seat.result = natural and "push" or "loss"
      elseif natural or dealerScore > MaxScore or total > dealerScore then
        seat.result = "win"
      elseif total == dealerScore then
        seat.result = "push"
      else
        seat.result = "loss"
      end
    end
  else
    local best = 0
    for _, seat in ipairs(Round.players) do
      local total = score(seat.hand)
      if seat.status ~= "left" and total <= MaxScore then
        best = math.max(best, total)
      end
    end
    local winners = {}
    for _, seat in ipairs(Round.players) do
      if seat.status == "left" then
        seat.result = "left"
      elseif score(seat.hand) == best and best > 0 then
        seat.result = "win"
        table.insert(winners, tostring(seat.id))
      else
        seat.result = "loss"
      end
    end
    Setonix.broadcast(#winners == 0 and "No eligible hands. No winner this round."
      or "Winners: " .. table.concat(winners, ", ") .. " with " .. best .. " points.")
  end
  for _, seat in ipairs(Round.players) do
    Setonix.broadcast("Player " .. seat.id .. ": " .. score(seat.hand) .. " · " .. seat.result)
  end
  Setonix.broadcast("Round complete. Choose Next round to play again.")
end

local function advance()
  while Round.turn <= #Round.players do
    local seat = currentSeat()
    if seat.status == "waiting" then
      seat.status = "playing"
      Setonix.broadcast("Player " .. seat.id .. "'s turn (row " .. Round.turn .. ", " .. score(seat.hand) .. " points).")
      return
    end
    Round.turn += 1
  end
  finishRound()
end

local function start(id)
  if Round.phase == "playing" then
    reply(id, "A round is already in progress.")
    return
  end
  local ids = onlineIds()
  if not table.find(ids, id) then
    reply(id, "Join the game before dealing.")
    return
  end
  local previousRows = Round.rows or 1
  -- Clear old hands before reducing the bounds.
  for row = 1, previousRows do
    TableRef:cell(0, row):setObjects({})
    TableRef:cell(0, row):layout(nil)
  end
  Round.number += 1
  Round.phase = "playing"
  Round.players = {}
  Round.deck = newDeck()
  Round.dealer = {}
  Round.turn = 1
  for _, playerId in ipairs(ids) do
    table.insert(Round.players, {id = playerId, hand = {}, status = "waiting"})
  end
  -- Deal in two passes; cap seats by the 52-card deck, leaving late players
  -- as spectators rather than silently giving them empty opening hands.
  local maxPlayers = Round.rules == "dealer" and 25 or 26
  while #Round.players > maxPlayers do
    local seat = table.remove(Round.players)
    reply(seat.id, "The table is full. You can join a later round.")
  end
  for _ = 1, 2 do
    for _, seat in ipairs(Round.players) do draw(seat.hand) end
    if Round.rules == "dealer" then draw(Round.dealer) end
  end
  for _, seat in ipairs(Round.players) do
    if score(seat.hand) == MaxScore then seat.status = "blackjack" end
  end
  Setonix.broadcast("Round " .. Round.number .. " started: " .. Round.rules .. ". Two cards dealt to each player.")
  if Round.rules == "dealer" and score(Round.dealer) == MaxScore then
    finishRound()
  else
    advance()
  end
  layout()
  render()
end

local function canPlay(id)
  if Round.phase ~= "playing" then
    reply(id, "Choose Deal or Next round to start.")
    return false
  end
  local seat = currentSeat()
  if seat == nil or seat.id ~= id then
    reply(id, findSeat(id) and "It's not your turn." or "You can join the next round.")
    return false
  end
  return true
end

local function hit(id)
  if not canPlay(id) then return end
  local seat = currentSeat()
  if not draw(seat.hand) then
    reply(id, "The deck is empty. Your hand stands.")
    seat.status = "stood"
  else
    local total = score(seat.hand)
    reply(id, "Your score is " .. total .. ".")
    if total > MaxScore then
      seat.status = "bust"
      Setonix.broadcast("Player " .. id .. " busted with " .. total .. ".")
    elseif total == MaxScore then
      seat.status = "stood"
      Setonix.broadcast("Player " .. id .. " reached 21.")
    end
  end
  if seat.status ~= "playing" then
    Round.turn += 1
    advance()
  end
  render()
end

local function stand(id)
  if not canPlay(id) then return end
  local seat = currentSeat()
  seat.status = "stood"
  Setonix.broadcast("Player " .. id .. " stands on " .. score(seat.hand) .. ".")
  Round.turn += 1
  advance()
  render()
end

local function rules(id, value)
  if id ~= Round.host then
    reply(id, "Only the host can change blackjack rules.")
  elseif Round.phase == "playing" then
    reply(id, "Rules can be changed between rounds.")
  elseif value ~= "dealer" and value ~= "competitive" then
    reply(id, "Use /rules dealer or /rules competitive.")
  else
    Round.rules = value
    Setonix.broadcast("Blackjack rules: " .. value .. ". Dealer mode stands on all 17s; two-card blackjack beats other 21s.")
  end
end

local function help(id)
  reply(id, "Blackjack: get closest to 21 without going over. Aces count as 1 or 11.\n"
    .. "Choose Deal, then Hit or Stand on your turn. Each player's hand is shown in their numbered row.\n"
    .. "Competition: highest non-busted score wins; ties share the win. Dealer: beat the dealer, who stands on 17 (including soft 17).\n"
    .. "The host can switch rules between rounds. Late joins play next round.\n"
    .. "Commands: /deal, /hit, /stand (or /stay), /scores, /rules dealer|competitive, /help.")
end

-- Serialize actions even when Send yields to Dart/browser callbacks.
local function reconcile(excluded)
  if Round.phase ~= "playing" then return end
  local ids = onlineIds(excluded)
  for _, seat in ipairs(Round.players) do
    if seat.status ~= "left" and not table.find(ids, seat.id) then
      seat.status = "left"
    end
  end
  local seat = currentSeat()
  if seat and seat.status == "left" then
    Round.turn += 1
    advance()
    render()
  end
end

local function action(handler)
  return function(event)
    event:cancel()
    if Busy then
      reply(event.source, "Please wait for the current action to finish.")
      return
    end
    Busy = true
    local ok, failure = pcall(function()
      reconcile()
      handler(event)
      reconcile()
      refresh()
    end)
    Busy = false
    if not ok then error(failure) end
  end
end

for name, handler in pairs({
  start = function(event) start(event.source) end,
  hit = function(event) hit(event.source) end,
  stand = function(event) stand(event.source) end,
  scores = function(event) scoreboard(event.source) end,
  rules = function(event) rules(event.source, Round.rules == "dealer" and "competitive" or "dealer") end,
  help = function(event) help(event.source) end,
}) do
  Setonix.events.action("blackjack_" .. name, action(handler))
end

for name, handler in pairs({
  deal = function(event) start(event.source) end,
  hit = function(event) hit(event.source) end,
  stand = function(event) stand(event.source) end,
  stay = function(event) stand(event.source) end,
  scores = function(event) scoreboard(event.source) end,
  rules = function(event) rules(event.source, event.arguments[1]) end,
  help = function(event) help(event.source) end,
}) do
  Setonix.commands.register(name, action(handler))
end

-- Treat a deck drag as Hit, and suppress the sandbox move itself. The card
-- projection below completes the draw before advancing or ending the turn.
Setonix.events.on("objects_moved", action(function(event)
  local seat = currentSeat()
  local target = seat and TableRef:cell(0, Round.turn)
  if Round.phase ~= "playing" or not event.from:equals(DeckCell)
    or target == nil or not event.to:equals(target)
    or #event.objects ~= 1 or event.objects[1] ~= 0 then
    reply(event.source, "Use the blackjack controls to play.")
    return
  end
  hit(event.source)
end))

for _, name in ipairs({
  "objects_spawned", "objects_removed", "cell_hide_changed", "object_index_changed",
  "shuffle_cell_request", "cell_roll_request", "boards_spawn_request",
  "board_remove_request", "board_move_request", "merge_strategy_changed",
  "table_bounds_changed", "table_removed", "table_renamed", "background_changed",
}) do
  Setonix.events.on(name, function(event) event:cancel() end)
end

for _, name in ipairs({"note_changed", "note_removed"}) do
  Setonix.events.on(name, function(event)
    if event.name == ScoreNote then event:cancel() end
  end)
end

Setonix.events.on("user_joined", function(event)
  Departed[event.player.id] = nil
  if Round.host == nil then Round.host = event.player.id end
  updateToolbar(event.player.id)
  help(event.player.id)
  if Round.phase == "playing" then
    reply(event.player.id, "A round is in progress. You can join the next round.")
  end
end)

Setonix.events.on("user_left", function(event)
  Departed[event.player.id] = true
  if Busy then return end
  Busy = true
  local ok, failure = pcall(function()
    reconcile(event.player.id)
    render()
    refresh(event.player.id)
  end)
  Busy = false
  if not ok then error(failure) end
end)

Setonix.events.on("world_saving", save)
Setonix.events.on("world_closing", function()
  save()
  DealerCell:layout(nil)
  for row = 1, Round.rows or 1 do
    TableRef:cell(0, row):layout(nil)
  end
  TableRef:setBounds(Round.previousMin, Round.previousMax)
  Setonix.server.setToolbar({editable = true})
end)

local function validRound(state)
  if type(state) ~= "table" or state.version ~= 2 or type(state.tableName) ~= "string"
    or (state.rules ~= "competitive" and state.rules ~= "dealer")
    or not table.find({"ready", "playing", "finished"}, state.phase)
    or type(state.number) ~= "number" or state.number < 0 or state.number % 1 ~= 0
    or type(state.turn) ~= "number" or state.turn < 1 or state.turn % 1 ~= 0
    or type(state.players) ~= "table" or #state.players > 26 then
    return false
  end
  local function validCards(cards)
    if type(cards) ~= "table" or #cards > 52 then return false end
    for _, variation in ipairs(cards) do
      if type(variation) ~= "string" then return false end
      local suit, rank = string.match(variation, "^([^-]+)%-([^-]+)$")
      if not table.find({"heart", "diamond", "club", "spade"}, suit) or CardScores[rank] == nil then
        return false
      end
    end
    return true
  end
  if not validCards(state.deck) or not validCards(state.dealer) then return false end
  local ids = {}
  for _, seat in ipairs(state.players) do
    if type(seat) ~= "table" or type(seat.id) ~= "number" or seat.id % 1 ~= 0
      or ids[seat.id] or not validCards(seat.hand)
      or not table.find({"waiting", "playing", "stood", "blackjack", "bust", "left"}, seat.status) then
      return false
    end
    ids[seat.id] = true
  end
  if state.phase == "playing" and (state.turn > #state.players or #state.players == 0) then return false end
  if state.rows ~= nil and (type(state.rows) ~= "number" or state.rows < 1 or state.rows > 26 or state.rows % 1 ~= 0) then return false end
  if (state.previousMin == nil) ~= (state.previousMax == nil) then return false end
  for _, corner in ipairs({state.previousMin, state.previousMax}) do
    if type(corner) ~= "table" or type(corner.x) ~= "number" or type(corner.y) ~= "number"
      or corner.x % 1 ~= 0 or corner.y % 1 ~= 0 then return false end
  end
  return true
end

local saved = Setonix.storage.get(StorageKey)
if validRound(saved) then
  Round = saved
else
  local minimum, maximum = Setonix.tables.current():bounds()
  Round = {
    version = 2, tableName = Setonix.state.tableName(), rules = "competitive",
    number = 0, phase = "ready", players = {}, deck = newDeck(), dealer = {}, turn = 1,
    previousMin = minimum and {x = minimum.x, y = minimum.y},
    previousMax = maximum and {x = maximum.x, y = maximum.y},
  }
end
TableRef = Setonix.tables.get(Round.tableName)
DeckCell = TableRef:cell(0, 0)
DealerCell = TableRef:cell(1, 0)
layout()
render()
refresh()
