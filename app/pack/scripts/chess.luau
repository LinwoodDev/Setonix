--!nolint UnknownGlobal

-- Rules use an independent position. The canvas is an asynchronous projection,
-- never the source of truth for legality, captures or draw claims.
local Chess = {}
local Files = "abcdefgh"
local Promotions = {"q", "r", "b", "n"}
local Names = {p = "pawn", n = "knight", b = "bishop", r = "rook", q = "queen", k = "king"}
local KnightSteps = {{1, 2}, {2, 1}, {2, -1}, {1, -2}, {-1, -2}, {-2, -1}, {-2, 1}, {-1, 2}}
local Directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}}

local function other(color) return color == "w" and "b" or "w" end
local function square(x, y)
  if type(x) ~= "number" or type(y) ~= "number" or x % 1 ~= 0 or y % 1 ~= 0 then return nil end
  if x < 1 or x > 8 or y < 1 or y > 8 then return nil end
  return string.sub(Files, x, x) .. tostring(9 - y)
end
local function coordinates(s)
  if type(s) ~= "string" or not string.match(s, "^[a-h][1-8]$") then return nil end
  return string.find(Files, string.sub(s, 1, 1), 1, true), 9 - tonumber(string.sub(s, 2, 2))
end
local function pieceAt(position, x, y)
  local s = square(x, y)
  return s and position.board[s]
end

function Chess.new()
  local position = {board = {}, turn = "w", rights = "KQkq", halfmove = 0, fullmove = 1}
  for x, kind in ipairs({"r", "n", "b", "q", "k", "b", "n", "r"}) do
    position.board[square(x, 1)] = "b" .. kind
    position.board[square(x, 2)] = "bp"
    position.board[square(x, 7)] = "wp"
    position.board[square(x, 8)] = "w" .. kind
  end
  return position
end

function Chess.attacked(position, target, color)
  local x, y = coordinates(target)
  local step = color == "w" and -1 or 1
  if pieceAt(position, x - 1, y - step) == color .. "p"
    or pieceAt(position, x + 1, y - step) == color .. "p" then return true end
  for _, delta in ipairs(KnightSteps) do
    if pieceAt(position, x + delta[1], y + delta[2]) == color .. "n" then return true end
  end
  for index, delta in ipairs(Directions) do
    for distance = 1, 7 do
      local nx, ny = x + delta[1] * distance, y + delta[2] * distance
      if not square(nx, ny) then break end
      local piece = pieceAt(position, nx, ny)
      if piece then
        if string.sub(piece, 1, 1) == color then
          local kind = string.sub(piece, 2)
          if kind == "q" or (index <= 4 and kind == "r") or (index > 4 and kind == "b")
            or (distance == 1 and kind == "k") then return true end
        end
        break
      end
    end
  end
  return false
end

function Chess.check(position, color)
  for s, piece in pairs(position.board) do
    if piece == color .. "k" then return Chess.attacked(position, s, other(color)) end
  end
  return true -- Missing kings are never legal positions.
end

function Chess.apply(position, move)
  local next = {
    board = table.clone(position.board), turn = other(position.turn), rights = position.rights,
    halfmove = position.halfmove + 1, fullmove = position.fullmove + (position.turn == "b" and 1 or 0),
  }
  local piece = position.board[move.from]
  local color, kind = string.sub(piece, 1, 1), string.sub(piece, 2)
  local fx, fy = coordinates(move.from)
  local tx, ty = coordinates(move.to)
  local capture = position.board[move.to] ~= nil or move.enPassant
  next.board[move.from] = nil
  next.board[move.to] = move.promotion and color .. move.promotion or piece
  if move.enPassant then next.board[square(tx, fy)] = nil end
  if kind == "k" and math.abs(tx - fx) == 2 then
    local rookFrom = square(tx > fx and 8 or 1, fy)
    local rookTo = square(tx > fx and 6 or 4, fy)
    next.board[rookTo], next.board[rookFrom] = next.board[rookFrom], nil
  end
  local remove = ""
  if kind == "k" then remove = color == "w" and "KQ" or "kq" end
  for s, right in pairs({a1 = "Q", h1 = "K", a8 = "q", h8 = "k"}) do
    if move.from == s or move.to == s then remove ..= right end
  end
  for index = 1, #remove do next.rights = string.gsub(next.rights, string.sub(remove, index, index), "") end
  if kind == "p" then
    next.halfmove = 0
    if math.abs(ty - fy) == 2 then next.ep = square(fx, (fy + ty) / 2) end
  end
  if capture then next.halfmove = 0 end
  return next
end

function Chess.moves(position)
  local candidates = {}
  local function add(from, to, enPassant)
    if to == nil then return end
    local target = position.board[to]
    if target and (string.sub(target, 1, 1) == position.turn or string.sub(target, 2) == "k") then return end
    local _, y = coordinates(to)
    if string.sub(position.board[from], 2) == "p" and (y == 1 or y == 8) then
      for _, promotion in ipairs(Promotions) do
        table.insert(candidates, {from = from, to = to, promotion = promotion})
      end
    else
      table.insert(candidates, {from = from, to = to, enPassant = enPassant or nil})
    end
  end
  for from, piece in pairs(position.board) do
    if string.sub(piece, 1, 1) ~= position.turn then continue end
    local kind = string.sub(piece, 2)
    local x, y = coordinates(from)
    if kind == "p" then
      local step = position.turn == "w" and -1 or 1
      if square(x, y + step) and not pieceAt(position, x, y + step) then
        add(from, square(x, y + step))
        if y == (position.turn == "w" and 7 or 2) and not pieceAt(position, x, y + 2 * step) then
          add(from, square(x, y + 2 * step))
        end
      end
      for _, dx in ipairs({-1, 1}) do
        local to = square(x + dx, y + step)
        local target = to and position.board[to]
        if target and string.sub(target, 1, 1) ~= position.turn then add(from, to) end
        if to and to == position.ep and not target and pieceAt(position, x + dx, y) == other(position.turn) .. "p" then
          add(from, to, true)
        end
      end
    elseif kind == "n" then
      for _, delta in ipairs(KnightSteps) do add(from, square(x + delta[1], y + delta[2])) end
    else
      for index, delta in ipairs(Directions) do
        if kind == "b" and index <= 4 or kind == "r" and index > 4 then continue end
        for distance = 1, kind == "k" and 1 or 7 do
          local to = square(x + delta[1] * distance, y + delta[2] * distance)
          if not to then break end
          add(from, to)
          if position.board[to] then break end
        end
      end
      if kind == "k" then
        local rank = position.turn == "w" and "1" or "8"
        if from == "e" .. rank and not Chess.check(position, position.turn) then
          for _, kingSide in ipairs({true, false}) do
            local right = kingSide and "K" or "Q"
            if position.turn == "b" then right = string.lower(right) end
            local rook = (kingSide and "h" or "a") .. rank
            local transit = (kingSide and "f" or "d") .. rank
            local to = (kingSide and "g" or "c") .. rank
            if string.find(position.rights, right, 1, true) and position.board[rook] == position.turn .. "r"
              and not position.board[transit] and not position.board[to]
              and (kingSide or not position.board["b" .. rank])
              and not Chess.attacked(position, transit, other(position.turn))
              and not Chess.attacked(position, to, other(position.turn)) then add(from, to) end
          end
        end
      end
    end
  end
  local legal = {}
  for _, move in ipairs(candidates) do
    if not Chess.check(Chess.apply(position, move), position.turn) then table.insert(legal, move) end
  end
  return legal
end

function Chess.find(position, from, to, promotion)
  for _, move in ipairs(Chess.moves(position)) do
    if move.from == from and move.to == to and move.promotion == promotion then return move end
  end
  return nil
end

function Chess.key(position)
  local parts = {position.turn, position.rights}
  -- En passant only distinguishes repetitions when a legal capture exists.
  local ep = "-"
  if position.ep then
    for _, move in ipairs(Chess.moves(position)) do if move.enPassant then ep = position.ep; break end end
  end
  table.insert(parts, ep)
  for y = 1, 8 do for x = 1, 8 do table.insert(parts, pieceAt(position, x, y) or "--") end end
  return table.concat(parts, ":")
end

function Chess.insufficient(position)
  local minors, bishops, bishopColor = 0, 0, nil
  for s, piece in pairs(position.board) do
    local kind = string.sub(piece, 2)
    if kind == "k" then continue end
    if kind ~= "b" and kind ~= "n" then return false end
    minors += 1
    if kind == "b" then
      local x, y = coordinates(s)
      local color = (x + y) % 2
      if bishopColor ~= nil and bishopColor ~= color then return false end
      bishopColor = color
      bishops += 1
    end
  end
  return minors <= 1 or bishops == minors
end

function Chess.valid(position)
  if type(position) ~= "table" or type(position.board) ~= "table"
    or not table.find({"w", "b"}, position.turn) or type(position.rights) ~= "string"
    or not string.match(position.rights, "^K?Q?k?q?$") then return false end
  for _, key in ipairs({"halfmove", "fullmove"}) do
    if type(position[key]) ~= "number" or position[key] % 1 ~= 0 or position[key] < (key == "fullmove" and 1 or 0)
      or position[key] == math.huge then return false end
  end
  if position.ep ~= nil then
    if not coordinates(position.ep) or string.sub(position.ep, 2) ~= (position.turn == "w" and "6" or "3") then return false end
    local x, y = coordinates(position.ep)
    if position.board[position.ep] or pieceAt(position, x, y + (position.turn == "w" and 1 or -1)) ~= other(position.turn) .. "p" then return false end
  end
  local kings, count = {w = 0, b = 0}, 0
  for s, piece in pairs(position.board) do
    local _, y = coordinates(s)
    if not y or type(piece) ~= "string" or not string.match(piece, "^[wb][pnbrqk]$") then return false end
    local kind = string.sub(piece, 2)
    if kind == "p" and (y == 1 or y == 8) then return false end
    if kind == "k" then local color = string.sub(piece, 1, 1); kings[color] += 1 end
    count += 1
  end
  return count <= 32 and kings.w == 1 and kings.b == 1 and not Chess.check(position, other(position.turn))
end

-- Mode integration.
local StorageKey = "chess.match"
local NoteName = "Chess"
local Match
local TableRef
local Rendered = {}
local Departed = {}
local ActionLock = {}
local refresh
local function colorName(color) return color == "w" and "White" or "Black" end
local function online(excluded)
  local ids = {}
  for _, player in ipairs(Setonix.players.all()) do
    if player.id ~= excluded and not Departed[player.id] then table.insert(ids, player.id) end
  end
  return Setonix.collections.sorted(ids)
end
local function owns(id, color) return Match.seats[color] == id end
local function participant(id) return owns(id, "w") or owns(id, "b") end
local function reply(id, message) Setonix.player(id):sendMessage(message) end
local function save() Setonix.storage.set(StorageKey, Match) end
local function render()
  for y = 1, 8 do for x = 1, 8 do
    local s = square(x, y)
    local piece = Match.position.board[s]
    if Rendered[s] ~= (piece or false) then
      local objects = {}
      if piece then table.insert(objects, Setonix.object(Setonix.namespace() .. ":chess_" .. (string.sub(piece, 1, 1) == "w" and "white" or "black"), {
        variation = Names[string.sub(piece, 2)],
      })) end
      TableRef:cell(x, y):setObjects(objects)
      Rendered[s] = piece or false
    end
  end end
end
local function finish(result)
  Match.phase, Match.result, Match.pending, Match.offer = "finished", result, nil, nil
  Match.votes = {}
  Setonix.server.broadcast(result)
end
local function adjudicate()
  local position = Match.position
  local moves = Chess.moves(position)
  if #moves == 0 then
    finish(Chess.check(position, position.turn) and (colorName(other(position.turn)) .. " wins by checkmate.") or "Draw by stalemate.")
  elseif Chess.insufficient(position) then finish("Draw by insufficient material.")
  elseif (Match.repetitions[Chess.key(position)] or 0) >= 5 then finish("Draw by fivefold repetition.")
  elseif position.halfmove >= 150 then finish("Draw by the seventy-five-move rule.") end
end
local function reconcile(excluded)
  local ids = online(excluded)
  -- The local host keeps White when a hot-seat game gains an opponent.
  if Match.hotseat and #ids > 1 then
    Match.hotseat = false
    Match.seats.b = nil
  end
  for _, color in ipairs({"w", "b"}) do
    if Match.seats[color] ~= nil and not table.find(ids, Match.seats[color]) then
      Match.votes[tostring(Match.seats[color])] = nil
      Match.seats[color] = nil
      if Match.offer == color then Match.offer = nil end
    end
  end
  if Match.hotseat and #ids > 0 and Match.seats.w == nil and Match.seats.b == nil then
    Match.seats.w, Match.seats.b = ids[1], ids[1]
  end
end
local function canMove(id)
  if Match.phase ~= "playing" then reply(id, "The game has ended. Choose Rematch."); return false end
  if not Match.seats.w or not Match.seats.b then reply(id, "Waiting for both seats. Choose Join White or Join Black."); return false end
  if not owns(id, Match.position.turn) then reply(id, "It is " .. colorName(Match.position.turn) .. "'s turn."); return false end
  return true
end
local function commit(move)
  local color = Match.position.turn
  if Match.offer and Match.offer ~= color then Match.offer = nil end
  Match.position = Chess.apply(Match.position, move)
  Match.pending = nil
  local key = Chess.key(Match.position)
  Match.repetitions[key] = (Match.repetitions[key] or 0) + 1
  table.insert(Match.history, move.from .. move.to .. (move.promotion or ""))
  adjudicate()
  render()
end
local function move(id, from, to, promotion)
  if not canMove(id) then return end
  if Match.pending then reply(id, "Choose a promotion piece before moving again."); return end
  if not coordinates(from) or not coordinates(to) then reply(id, "Use squares such as e2 and e4."); return end
  for _, candidate in ipairs(Chess.moves(Match.position)) do
    if candidate.from == from and candidate.to == to and (promotion == nil or candidate.promotion == promotion) then
      if candidate.promotion and promotion == nil then
        Match.pending = {from = from, to = to}
      else commit(candidate) end
      return
    end
  end
  reply(id, "Illegal move. Your king must remain safe.")
end
local function promote(id, kind)
  if not canMove(id) then return end
  if not Match.pending or not table.find(Promotions, kind) then reply(id, "No promotion is awaiting that choice."); return end
  local candidate = Chess.find(Match.position, Match.pending.from, Match.pending.to, kind)
  if candidate then commit(candidate) end
end
local function join(id, color)
  if Match.seats[color] == id then return end
  if Match.seats[color] ~= nil then reply(id, colorName(color) .. " is already taken."); return end
  if participant(id) then reply(id, "You already have a seat."); return end
  Match.hotseat = false
  Match.seats[color] = id
end
local function draw(id)
  if Match.phase ~= "playing" or not participant(id) or Match.pending then return end
  local color = owns(id, "w") and "w" or "b"
  if Match.hotseat or Match.offer == other(color) then finish("Draw by agreement.")
  else Match.offer = color end
end
local function claim(id, from, to, promotion)
  if not canMove(id) or Match.pending then return end
  local position = Match.position
  local repetitions = Match.repetitions[Chess.key(position)] or 0
  if from then
    local candidate = Chess.find(position, from, to, promotion)
    if not candidate then reply(id, "A draw claim must specify a legal move."); return end
    position = Chess.apply(position, candidate)
    repetitions = (Match.repetitions[Chess.key(position)] or 0) + 1
  end
  if repetitions >= 3 then finish("Draw claimed by threefold repetition.")
  elseif position.halfmove >= 100 then finish("Draw claimed by the fifty-move rule.")
  else reply(id, "No threefold repetition or fifty-move draw can be claimed.") end
end
local function rematch(id)
  if Match.phase ~= "finished" or not participant(id) then return end
  Match.votes[tostring(id)] = true
  if Match.seats.w and Match.seats.b and Match.votes[tostring(Match.seats.w)] and Match.votes[tostring(Match.seats.b)] then
    Match.position = Chess.new()
    Match.phase, Match.result, Match.pending, Match.offer = "playing", nil, nil, nil
    Match.history, Match.votes = {}, {}
    Match.repetitions = {[Chess.key(Match.position)] = 1}
    render()
  end
end
local function help(id)
  reply(id, "Chess: drag a piece, or /move e2e4. /move e7e8q promotes. /white and /black claim free seats. /resign, /draw, /claim [e2e4], /rematch. Read the Chess note for the current turn and controls.")
end
refresh = function(excluded)
  reconcile(excluded)
  local position = Match.position
  for _, id in ipairs(online(excluded)) do
    local active = Match.phase == "playing" and owns(id, position.turn) and Match.seats.w ~= nil and Match.seats.b ~= nil
    local actions = {
      Setonix.toolbarAction("chess_white", "Join White", Match.seats.w == nil and not participant(id)),
      Setonix.toolbarAction("chess_black", "Join Black", Match.seats.b == nil and not participant(id)),
      Setonix.toolbarAction("chess_resign", "Resign", Match.phase == "playing" and participant(id)),
      Setonix.toolbarAction("chess_draw", Match.offer and "Accept / offer draw" or "Offer draw", Match.phase == "playing" and participant(id) and not Match.pending),
      Setonix.toolbarAction("chess_claim", "Claim draw", active and not Match.pending and (position.halfmove >= 100 or (Match.repetitions[Chess.key(position)] or 0) >= 3)),
      Setonix.toolbarAction("chess_rematch", "Rematch", Match.phase == "finished" and participant(id)),
    }
    for _, kind in ipairs(Promotions) do
      table.insert(actions, Setonix.toolbarAction("chess_promote_" .. kind, "Promote to " .. Names[kind], active and Match.pending ~= nil, Match.pending ~= nil))
    end
    Setonix.player(id):setToolbar({editable = false, actions = actions})
  end
  local lines = {"# Chess", ""}
  for _, color in ipairs({"w", "b"}) do
    table.insert(lines, "**" .. colorName(color) .. ":** " .. (Match.seats[color] and "Player " .. Match.seats[color] or "Open seat"))
  end
  table.insert(lines, "")
  if Match.phase == "finished" then table.insert(lines, "**" .. Match.result .. "**")
  else
    table.insert(lines, "**" .. colorName(position.turn) .. " to move" .. (Chess.check(position, position.turn) and " — check!" or "") .. "**")
    if not Match.seats.w or not Match.seats.b then table.insert(lines, "Waiting for both players. Claim a free seat to resume.") end
    if Match.pending then
      table.insert(lines, "Choose a promotion: [Queen](action:chess_promote_q) [Rook](action:chess_promote_r) [Bishop](action:chess_promote_b) [Knight](action:chess_promote_n)")
    end
    if Match.offer then table.insert(lines, colorName(Match.offer) .. " offers a draw.") end
  end
  table.insert(lines, "")
  table.insert(lines, "[Join White](action:chess_white) [Join Black](action:chess_black)")
  table.insert(lines, "[Resign](action:chess_resign) [Offer / accept draw](action:chess_draw) [Claim draw](action:chess_claim) [Rematch](action:chess_rematch)")
  table.insert(lines, "")
  table.insert(lines, "Drag a piece to move, or use `/move e2e4`. Promotion requires a choice; `/move e7e8n` promotes to a knight. Single-player games use local hot-seat play. Multiplayer games have two seats and spectators. Disconnected seats become available; the position is kept.")
  table.insert(lines, "")
  table.insert(lines, "Castling, en passant and king safety are enforced. Threefold repetition and 50 moves without a pawn move or capture can be claimed using `/claim`, or `/claim e2e4` for an intended move. Fivefold repetition and 75 moves end the game automatically. Standard insufficient-material positions are detected; other dead positions can be agreed drawn.")
  if #Match.history > 0 then
    local recent = {}
    for index = math.max(1, #Match.history - 11), #Match.history do table.insert(recent, Match.history[index]) end
    table.insert(lines, "\nRecent moves: " .. table.concat(recent, " "))
  end
  Setonix.notes.set(NoteName, table.concat(lines, "\n"))
  save()
end
local function action(handler)
  return Setonix.events.guard(function(event)
    reconcile()
    handler(event)
    refresh()
  end, ActionLock)
end
local function parseMove(arguments)
  local text = string.lower(table.concat(arguments, ""))
  local from, to, promotion = string.match(text, "^([a-h][1-8])([a-h][1-8])([qrbn]?)$")
  return from, to, promotion ~= "" and promotion or nil
end
local function resign(id)
  if Match.phase ~= "playing" or not participant(id) then return end
  local color = Match.hotseat and Match.position.turn or (owns(id, "w") and "w" or "b")
  local winner = other(color)
  local canMate = false
  for _, piece in pairs(Match.position.board) do
    if string.sub(piece, 1, 1) == winner and string.sub(piece, 2) ~= "k" then canMate = true; break end
  end
  if not canMate then finish("Draw by resignation: the opponent cannot checkmate."); return end
  finish(colorName(other(color)) .. " wins by resignation.")
end
for name, handler in pairs({
  white = function(event) join(event.source, "w") end,
  black = function(event) join(event.source, "b") end,
  resign = function(event) resign(event.source) end,
  draw = function(event) draw(event.source) end,
  claim = function(event) claim(event.source) end,
  rematch = function(event) rematch(event.source) end,
}) do Setonix.events.action("chess_" .. name, action(handler)) end
for _, kind in ipairs(Promotions) do
  Setonix.events.action("chess_promote_" .. kind, action(function(event) promote(event.source, kind) end))
end
for name, handler in pairs({
  move = function(event) local from, to, promotion = parseMove(event.arguments); move(event.source, from, to, promotion) end,
  white = function(event) join(event.source, "w") end,
  black = function(event) join(event.source, "b") end,
  resign = function(event) resign(event.source) end,
  draw = function(event) draw(event.source) end,
  claim = function(event)
    if #event.arguments == 0 then claim(event.source)
    else
      local from, to, promotion = parseMove(event.arguments)
      if not from then reply(event.source, "Use /claim or /claim e2e4.") else claim(event.source, from, to, promotion) end
    end
  end,
  rematch = function(event) rematch(event.source) end,
  chess = function(event) help(event.source) end,
}) do Setonix.commands.register(name, action(handler)) end
Setonix.events.on("objects_moved", action(function(event)
  if event.table ~= Match.tableName or #event.objects ~= 1 or event.objects[1] ~= 0 then
    reply(event.source, "Move one chess piece at a time."); return
  end
  move(event.source, square(event.from.x, event.from.y), square(event.to.x, event.to.y))
end))
Setonix.events.block({
  "objects_spawned", "objects_removed", "cell_hide_changed", "object_index_changed",
  "shuffle_cell_request", "cell_roll_request", "boards_spawn_request", "board_remove_request", "board_move_request",
  "merge_strategy_changed", "table_bounds_changed", "table_removed", "table_renamed", "background_changed",
})
Setonix.events.block({"note_changed", "note_removed"}, function(event) return event.name == NoteName end)
Setonix.events.on("user_joined", function(event)
  Departed[event.player.id] = nil
  if ActionLock.busy then return end
  refresh()
  help(event.player.id)
end)
Setonix.events.on("user_left", function(event)
  Departed[event.player.id] = true
  if ActionLock.busy then return end
  refresh(event.player.id)
end)
Setonix.events.on("world_saving", save)
Setonix.events.on("world_closing", function()
  save()
  TableRef:setBounds(Match.previousMin, Match.previousMax)
  Setonix.server.setToolbar({editable = true})
end)
local function validMatch(state)
  if type(state) ~= "table" or state.version ~= 1 or not Chess.valid(state.position)
    or type(state.tableName) ~= "string" or type(state.seats) ~= "table"
    or type(state.hotseat) ~= "boolean" or not table.find({"playing", "finished"}, state.phase)
    or type(state.repetitions) ~= "table" or type(state.history) ~= "table" or type(state.votes) ~= "table" then return false end
  for _, id in pairs(state.seats) do if type(id) ~= "number" or id % 1 ~= 0 or math.abs(id) == math.huge then return false end end
  if not state.hotseat and state.seats.w ~= nil and state.seats.w == state.seats.b then return false end
  if state.phase == "finished" and type(state.result) ~= "string" then return false end
  for key, value in pairs(state.repetitions) do
    if type(key) ~= "string" or type(value) ~= "number" or value < 1 or value % 1 ~= 0 or value == math.huge then return false end
  end
  for _, value in ipairs(state.history) do if type(value) ~= "string" then return false end end
  if state.pending ~= nil and (type(state.pending) ~= "table" or not Chess.find(state.position, state.pending.from, state.pending.to, "q")) then return false end
  if state.offer ~= nil and not table.find({"w", "b"}, state.offer) then return false end
  if (state.previousMin == nil) ~= (state.previousMax == nil) then return false end
  for _, corner in ipairs({state.previousMin, state.previousMax}) do
    if type(corner) ~= "table" or type(corner.x) ~= "number" or type(corner.y) ~= "number"
      or corner.x % 1 ~= 0 or corner.y % 1 ~= 0 or math.abs(corner.x) == math.huge or math.abs(corner.y) == math.huge then return false end
  end
  return true
end
local saved = Setonix.storage.get(StorageKey)
if validMatch(saved) then Match = saved
else
  local minimum, maximum = Setonix.tables.current():bounds()
  local ids = online()
  local position = Chess.new()
  Match = {
    version = 1, position = position, tableName = Setonix.state.tableName(), phase = "playing",
    seats = {w = ids[1], b = ids[2] or (#ids == 1 and ids[1] or nil)}, hotseat = #ids == 1,
    repetitions = {[Chess.key(position)] = 1}, history = {}, votes = {},
    previousMin = minimum and {x = minimum.x, y = minimum.y},
    previousMax = maximum and {x = maximum.x, y = maximum.y},
  }
end
TableRef = Setonix.tables.get(Match.tableName)
TableRef:setBounds({x = 0, y = 0}, {x = 9, y = 9})
local initialKey = Chess.key(Match.position)
Match.repetitions[initialKey] = Match.repetitions[initialKey] or 1
if Match.phase == "playing" then adjudicate() end
render()
refresh()
