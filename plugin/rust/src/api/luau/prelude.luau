--!nolint UnknownGlobal
--!nolint BuiltinGlobalWrite

local runtime = SetonixRaw
local runtimeEvents = runtime.Events
local runtimeServer = runtime.Server
local runtimeState = runtime.State

local PositionMethods = {}
local TableMethods = {}
local CellMethods = {}
local PlayerMethods = {}
local EventMethods = {}
local WorldMethods = {}
local StateMethods = {}
local CollectionMethods = {}
local ScoringMethods = {}

local normalize_position

local function create_namespace(methods)
  return setmetatable({}, {
    __index = function(_, key)
      return methods[key]
    end,
  })
end

local function copy_array(values)
  local copy = {}
  for index, value in ipairs(values or {}) do
    copy[index] = value
  end
  return copy
end

local function assign_fields(target, source)
  for key, value in pairs(source or {}) do
    target[key] = value
  end
  return target
end

local function create_event(event_type, payload)
  return assign_fields({ type = event_type }, payload)
end

local function parse_vector_string(str)
  if type(str) == "string" then
    local x_str, y_str = string.match(str, "%((%-?%d+),%s*(%-?%d+)%)")
    if x_str and y_str then
      return tonumber(x_str), tonumber(y_str)
    end
  end
  return nil, nil
end

local function normalize_toolbar(toolbar)
  local actions = {}
  for _, action in ipairs((toolbar and toolbar.actions) or {}) do
    table.insert(actions, {
      id = action.id,
      label = action.label,
      enabled = action.enabled ~= false,
    })
  end
  return {
    editable = toolbar == nil or toolbar.editable ~= false,
    actions = actions,
  }
end

local function normalize_global_cell(position_or_x, y, table_name)
  local position = normalize_position(position_or_x, y, table_name)
  return {
    table = position.table,
    x = position.x,
    y = position.y,
  }, position
end

local function build_index_list(count)
  local indices = {}
  for index = 0, math.max((count or 1) - 1, 0) do
    table.insert(indices, index)
  end
  return indices
end

local PositionMetatable = {
  __index = function(_, key)
    return PositionMethods[key]
  end,
}

local TableMetatable = {
  __index = function(_, key)
    return TableMethods[key]
  end,
}

local CellMetatable = {
  __index = function(_, key)
    return CellMethods[key] or PositionMethods[key]
  end,
}

local PlayerMetatable = {
  __index = function(_, key)
    return PlayerMethods[key]
  end,
}

local EventMetatable = {
  __index = function(self, key)
    if key == "cancelled" then
      return self.details.cancelled
    end
    if key == "serverEvent" then
      return self.details.server_event
    end
    return EventMethods[key]
  end,
  __newindex = function(self, key, value)
    if key == "cancelled" then
      self.details.cancelled = value
      return
    end
    if key == "serverEvent" then
      self.details.server_event = value
      return
    end
    rawset(self, key, value)
  end,
}

local EventAliases = {
  player_join = "UserJoined",
  player_joined = "UserJoined",
  joined = "UserJoined",
  user_join = "UserJoined",
  user_joined = "UserJoined",
  team_join_request = "TeamJoinRequest",
  team_leave_request = "TeamLeaveRequest",
  cell_roll_request = "CellRollRequest",
  shuffle_cell_request = "ShuffleCellRequest",
  packs_change_request = "PacksChangeRequest",
  message = "MessageRequest",
  chat = "MessageRequest",
  boards_spawn = "BoardsSpawnRequest",
  toolbar_action = "ToolbarActionRequest",
  action = "ToolbarActionRequest",
  cell_switched = "CellSwitched",
  background_changed = "BackgroundChanged",
  objects_moved = "ObjectsMoved",
  objects_spawned = "ObjectsSpawned",
  objects_removed = "ObjectsRemoved",
  cell_hide_changed = "CellHideChanged",
  cell_hidden = "CellHideChanged",
  object_index_changed = "ObjectIndexChanged",
  team_changed = "TeamChanged",
  team_removed = "TeamRemoved",
  merge_strategy_changed = "CellMergeStrategyChanged",
  metadata_changed = "MetadataChanged",
  table_renamed = "TableRenamed",
  table_removed = "TableRemoved",
  note_changed = "NoteChanged",
  note_removed = "NoteRemoved",
  waypoint_changed = "WaypointChanged",
  waypoint_removed = "WaypointRemoved",
  boards_spawn_request = "BoardsSpawnRequest",
  board_remove_request = "BoardRemoveRequest",
  board_move_request = "BoardMoveRequest",
  dialog_close_request = "DialogCloseRequest",
  images_request = "ImagesRequest",
  mode_change_request = "ModeChangeRequest",
  authenticate_request = "AuthenticateRequest",
  toolbar_action_request = "ToolbarActionRequest",
  world_initialized = "WorldInitialized",
  team_joined = "TeamJoined",
  team_left = "TeamLeft",
  objects_changed = "ObjectsChanged",
  cell_shuffled = "CellShuffled",
  message_sent = "MessageSent",
  board_tiles_spawned = "BoardTilesSpawned",
  board_tiles_changed = "BoardTilesChanged",
  dialog_opened = "DialogOpened",
  dialogs_closed = "DialogsClosed",
  images_updated = "ImagesUpdated",
  server_state_updated = "ServerStateUpdated",
  authenticated_requested = "AuthenticatedRequested",
  toolbar_updated = "ToolbarUpdated",
}

local function to_number_if_possible(value)
  local converted = tonumber(value)
  if converted ~= nil then
    return converted
  end
  return value
end

local function vector_key(x, y)
  return "(" .. tostring(x) .. ", " .. tostring(y) .. ")"
end

local function normalize_event_name(name)
  return EventAliases[name] or name
end

local function create_position(table_name, x, y)
  return setmetatable({
    table = table_name or runtimeState.TableName,
    x = to_number_if_possible(x),
    y = to_number_if_possible(y),
  }, PositionMetatable)
end

normalize_position = function(position_or_x, y, table_name)
  if type(position_or_x) == "table" then
    if position_or_x.position ~= nil then
      local px, py = parse_vector_string(position_or_x.position)
      if px and py then
        return create_position(position_or_x.table or table_name, px, py)
      end
    end
    return create_position(
      position_or_x.table or table_name,
      position_or_x.x,
      position_or_x.y
    )
  end
  if type(position_or_x) == "string" then
    local px, py = parse_vector_string(position_or_x)
    if px and py then
      return create_position(table_name, px, py)
    end
  end
  return create_position(table_name, position_or_x, y)
end

local function fetch_table(table_name)
  return runtimeState:GetTable(table_name or runtimeState.TableName) or {}
end

local function create_table_ref(table_name)
  return setmetatable({
    name = table_name or runtimeState.TableName,
  }, TableMetatable)
end

local function create_cell_ref(table_name, x, y)
  return setmetatable({
    table = table_name or runtimeState.TableName,
    x = to_number_if_possible(x),
    y = to_number_if_possible(y),
  }, CellMetatable)
end

local function create_player(player_id)
  return setmetatable({ id = player_id }, PlayerMetatable)
end

local function normalize_object_list(objects)
  if objects == nil then
    return {}
  end
  if objects.asset ~= nil then
    return { objects }
  end
  return objects
end

local function split_arguments(input)
  local arguments = {}
  for value in string.gmatch(input or "", "%S+") do
    table.insert(arguments, value)
  end
  return arguments
end

local function wrap_position_field(raw_event, key)
  local value = raw_event[key]
  
  if key == "cell" or key == "from" or key == "to" then
    local table_name = raw_event.table
    if type(value) == "table" then
      if value.table ~= nil then
        table_name = value.table
      end
      if value.position ~= nil then
        local px, py = parse_vector_string(value.position)
        if px and py then
          return create_cell_ref(table_name, px, py)
        end
      end
      return create_cell_ref(table_name, value.x, value.y)
    elseif type(value) == "string" then
      local px, py = parse_vector_string(value)
      if px and py then
        return create_cell_ref(table_name, px, py)
      end
    end
  end

  return value
end

local function wrap_event(event_name, raw_event, details)
  local event = {
    name = event_name,
    raw = raw_event,
    details = details,
    source = details.source,
    target = details.target,
  }

  for key, value in pairs(raw_event) do
    if key == "cell" or key == "from" or key == "to" then
      event[key] = wrap_position_field(raw_event, key)
    else
      event[key] = value
    end
  end

  local player_id = raw_event.channel or raw_event.user or details.source
  if player_id ~= nil then
    event.player = create_player(player_id)
  end
  if raw_event.table ~= nil then
    event.tableRef = create_table_ref(raw_event.table)
  end
  if raw_event.actionId ~= nil then
    event.action = raw_event.actionId
  end

  return setmetatable(event, EventMetatable)
end

function PositionMethods:key()
  return vector_key(self.x, self.y)
end

function PositionMethods:toGlobal()
  return {
    table = self.table,
    x = self.x,
    y = self.y,
  }
end

function PositionMethods:cell()
  return create_cell_ref(self.table, self.x, self.y)
end

function PositionMethods:copy()
  return create_position(self.table, self.x, self.y)
end

function PositionMethods:withTable(table_name)
  return create_position(table_name, self.x, self.y)
end

function PositionMethods:equals(other)
  local normalized = normalize_position(other)
  return self.table == normalized.table and self.x == normalized.x and self.y == normalized.y
end

function TableMethods:raw()
  return fetch_table(self.name)
end

function TableMethods:cell(position_or_x, y)
  local position = normalize_position(position_or_x, y, self.name)
  return create_cell_ref(position.table, position.x, position.y)
end

function TableMethods:getCell(position_or_x, y)
  return self:cell(position_or_x, y)
end

function TableMethods:cells()
  return self:raw().cells or {}
end

function TableMethods:position(x, y)
  return create_position(self.name, x, y)
end

function TableMethods:spawn(position_or_x, y, objects, target)
  local position
  local resolved_objects
  local resolved_target

  if type(position_or_x) == "table" then
    position = normalize_position(position_or_x, nil, self.name)
    resolved_objects = y
    resolved_target = objects
  else
    position = normalize_position(position_or_x, y, self.name)
    resolved_objects = objects
    resolved_target = target
  end

  return self:cell(position):spawn(resolved_objects, resolved_target)
end

function TableMethods:spawnObject(position_or_x, y, asset, options, target)
  if type(position_or_x) == "table" then
    return self:cell(position_or_x):spawnObject(y, asset, options)
  end
  return self:cell(position_or_x, y):spawnObject(asset, options, target)
end

function CellMethods:raw()
  local cells = fetch_table(self.table).cells or {}
  return cells[self:key()] or {}
end

function CellMethods:objects()
  return self:raw().objects or {}
end

function CellMethods:tiles()
  return self:raw().tiles or {}
end

function CellMethods:isEmpty()
  local cell = self:raw()
  return #(cell.objects or {}) == 0 and #(cell.tiles or {}) == 0
end

function CellMethods:topObject()
  return self:objects()[1]
end

function CellMethods:object(index)
  return self:objects()[index or 1]
end

function CellMethods:topObjects(count)
  local objects = {}
  local limit = math.min(count or 1, self:countObjects())
  for index = 1, limit do
    table.insert(objects, self:object(index))
  end
  return objects
end

function CellMethods:countObjects()
  return #self:objects()
end

function CellMethods:hasObjects()
  return self:countObjects() > 0
end

function CellMethods:spawn(objects, target)
  return runtimeServer:Send({
    type = "ObjectsSpawned",
    table = self.table,
    objects = {
      [self:key()] = normalize_object_list(objects),
    },
  }, target)
end

function CellMethods:spawnObject(asset, options, target)
  return self:spawn(Setonix.object(asset, options), target)
end

function CellMethods:remove(objects, target)
  return runtimeServer:Send({
    type = "ObjectsRemoved",
    cell = self:toGlobal(),
    objects = objects,
  }, target)
end

function CellMethods:clear(target)
  return self:remove(nil, target)
end

function CellMethods:show(object, target)
  return runtimeServer:Send({
    type = "CellHideChanged",
    cell = self:toGlobal(),
    object = object,
    hide = false,
  }, target)
end

function CellMethods:hide(object, target)
  return runtimeServer:Send({
    type = "CellHideChanged",
    cell = self:toGlobal(),
    object = object,
    hide = true,
  }, target)
end

function CellMethods:moveTo(target_cell, objects, target)
  return Setonix.moveObjects(self, target_cell, objects, target)
end

function CellMethods:moveTopTo(target_cell, count, target)
  return self:moveTo(target_cell, build_index_list(count), target)
end

function CellMethods:shuffle(force)
  return Setonix.requests.shuffleCell(self, force)
end

function CellMethods:roll(object, force)
  return Setonix.requests.cellRoll(self, object, force)
end

function PlayerMethods:sendMessage(message, author)
  return runtimeServer:Send({
    type = "MessageSent",
    user = author or 0,
    message = message,
  }, self.id)
end

function PlayerMethods:setToolbar(toolbar)
  return Setonix.setToolbar(toolbar, self.id)
end

function PlayerMethods:isOnline()
  for _, player_id in ipairs(runtimeState.Players or {}) do
    if player_id == self.id then
      return true
    end
  end
  return false
end

function PlayerMethods:equals(other)
  local other_id = type(other) == "table" and other.id or other
  return self.id == other_id
end

function EventMethods:cancel()
  self.details.cancelled = true
end

function EventMethods:isCancelled()
  return self.details.cancelled
end

function EventMethods:schedule(event, target)
  self.details:ScheduleEvent(event, target)
end

function EventMethods:reply(message, author)
  return Setonix.message(message, self.source, author)
end

function EventMethods:broadcast(message, author)
  return Setonix.broadcast(message, author)
end

function EventMethods:setToolbar(toolbar)
  return Setonix.setToolbar(toolbar, self.source)
end

function EventMethods:getPlayer()
  return self.player
end

function EventMethods:getCell()
  return self.cell
end

function EventMethods:isFrom(player)
  local player_id = type(player) == "table" and player.id or player
  return self.source == player_id
end

function EventMethods:table()
  if self.tableRef ~= nil then
    return self.tableRef
  end
  return create_table_ref(runtimeState.TableName)
end

function WorldMethods:currentTable()
  return create_table_ref(runtimeState.TableName)
end

function WorldMethods:getTable(table_name)
  return create_table_ref(table_name)
end

function WorldMethods:cell(position_or_x, y, table_name)
  local position = normalize_position(position_or_x, y, table_name or runtimeState.TableName)
  return create_cell_ref(position.table, position.x, position.y)
end

function StateMethods.raw()
  return runtimeState
end

function StateMethods.tableName()
  return runtimeState.TableName
end

function StateMethods.tables()
  return runtimeState.Tables
end

function StateMethods.info()
  return runtimeState.Info
end

function StateMethods.players()
  return Setonix.getPlayers()
end

function StateMethods.teamMembers()
  return runtimeState.TeamMembers
end

function StateMethods.currentTable()
  return Setonix.currentTable()
end

function CollectionMethods.copy(values)
  return copy_array(values)
end

function CollectionMethods.shuffle(values)
  local shuffled = copy_array(values)
  for index = #shuffled, 2, -1 do
    local random_index = math.random(index)
    shuffled[index], shuffled[random_index] = shuffled[random_index], shuffled[index]
  end
  return shuffled
end

function ScoringMethods.bestTotal(items, resolver, max_score)
  local score_limit = max_score or 21
  local totals = { 0 }
  for _, item in ipairs(items or {}) do
    local values
    if type(resolver) == "function" then
      values = resolver(item)
    else
      values = resolver and resolver[item] or nil
    end
    values = values or { 0 }
    local next_totals = {}
    for _, total in ipairs(totals) do
      for _, value in ipairs(values) do
        local candidate = total + value
        if not table.find(next_totals, candidate) then
          table.insert(next_totals, candidate)
        end
      end
    end
    totals = next_totals
  end

  local best_under = nil
  local lowest_over = nil
  for _, total in ipairs(totals) do
    if total <= score_limit then
      if best_under == nil or total > best_under then
        best_under = total
      end
    elseif lowest_over == nil or total < lowest_over then
      lowest_over = total
    end
  end
  return best_under or lowest_over or 0
end

Setonix = {
  raw = runtime,
  world = create_namespace(WorldMethods),
  state = create_namespace(StateMethods),
  collections = create_namespace(CollectionMethods),
  scoring = create_namespace(ScoringMethods),
}

function Setonix.event(event_type, payload)
  return create_event(event_type, payload)
end

function Setonix.namespace()
  return runtimeState.Namespace
end

function Setonix.game()
  return runtimeState.Game
end

function Setonix.pluginId()
  return runtimeState.PluginId
end

function Setonix.getPlayers()
  local players = {}
  for _, player_id in ipairs(runtimeState.Players or {}) do
    table.insert(players, create_player(player_id))
  end
  return players
end

function Setonix.player(player_id)
  return create_player(player_id)
end

function Setonix.currentTable()
  return Setonix.world:currentTable()
end

function Setonix.getTable(table_name)
  return Setonix.world:getTable(table_name)
end

function Setonix.cell(position_or_x, y, table_name)
  return Setonix.world:cell(position_or_x, y, table_name)
end

function Setonix.position(position_or_x, y, table_name)
  return normalize_position(position_or_x, y, table_name or runtimeState.TableName)
end

function Setonix.object(asset, options)
  options = options or {}
  return {
    asset = asset,
    variation = options.variation,
    hidden = options.hidden == true,
  }
end

function Setonix.send(event, target)
  return runtimeServer:Send(event, target)
end

function Setonix.process(event, force)
  return runtimeServer:Process(event, force)
end

function Setonix.log(message)
  print(message)
end

function Setonix.message(message, target, author)
  return runtimeServer:Send({
    type = "MessageSent",
    user = author or 0,
    message = message,
  }, target)
end

function Setonix.broadcast(message, author)
  return Setonix.message(message, nil, author)
end

function Setonix.toolbarAction(id, label, enabled)
  return {
    id = id,
    label = label,
    enabled = enabled ~= false,
  }
end

function Setonix.setToolbar(toolbar, target)
  return runtimeServer:Send({
    type = "ToolbarUpdated",
    toolbar = normalize_toolbar(toolbar),
  }, target)
end

function Setonix.moveObjects(from_cell, to_cell, objects, target)
  local from = normalize_position(from_cell)
  local to = normalize_position(to_cell, nil, from.table)
  if from.table ~= to.table then
    error("Objects can only be moved inside the same table")
  end
  return runtimeServer:Send({
    type = "ObjectsMoved",
    table = from.table,
    objects = objects,
    from = {
      x = from.x,
      y = from.y,
    },
    to = {
      x = to.x,
      y = to.y,
    },
  }, target)
end

function Setonix.on(event_name, handler)
  local raw_name = normalize_event_name(event_name)
  return runtimeEvents[raw_name]:Connect(function(raw_event, details)
    return handler(wrap_event(raw_name, raw_event, details))
  end)
end

function Setonix.listen(event_name, handler)
  return Setonix.on(event_name, handler)
end

function Setonix.onAction(action_id, handler)
  return Setonix.on("toolbar_action", function(event)
    if event.actionId ~= action_id then
      return nil
    end
    return handler(event)
  end)
end

function Setonix.command(name, handler, options)
  options = options or {}
  local prefixes = options.prefixes or { "!", "/" }
  local expected_name = string.lower(name)
  return Setonix.on("message", function(event)
    local message = tostring(event.message or "")
    local lower_message = string.lower(message)
    local result = nil
    for _, prefix in ipairs(prefixes) do
      local command = string.lower(prefix .. expected_name)
      if string.sub(lower_message, 1, #command) == command then
        local rest = string.sub(message, #command + 1)
        if rest == "" or string.sub(rest, 1, 1) == " " then
          event.command = name
          event.arguments = split_arguments(rest)
          result = handler(event)
          break
        end
      end
    end
    return result
  end)
end

Setonix.events = {
  on = Setonix.on,
  listen = Setonix.listen,
  action = Setonix.onAction,
}

Setonix.commands = {
  register = Setonix.command,
}

Setonix.tables = {
  current = Setonix.currentTable,
  get = Setonix.getTable,
}

Setonix.server = {
  send = Setonix.send,
  process = Setonix.process,
  message = Setonix.message,
  broadcast = Setonix.broadcast,
  setToolbar = Setonix.setToolbar,
  toolbarAction = Setonix.toolbarAction,
}

Setonix.server.events = {
  cellSwitched = function(cell, selected, teleport)
    return create_event("CellSwitched", {
      cell = normalize_position(cell):toGlobal(),
      selected = selected ~= false,
      teleport = teleport == true,
    })
  end,
  backgroundChanged = function(background)
    return create_event("BackgroundChanged", { background = background })
  end,
  objectsSpawned = function(table_name, objects)
    return create_event("ObjectsSpawned", {
      table = table_name,
      objects = objects or {},
    })
  end,
  objectsSpawnedAt = function(cell, objects)
    local global_cell, position = normalize_global_cell(cell)
    return create_event("ObjectsSpawned", {
      table = global_cell.table,
      objects = {
        [position:key()] = normalize_object_list(objects),
      },
    })
  end,
  objectsMoved = function(from_cell, to_cell, objects)
    local from = normalize_position(from_cell)
    local to = normalize_position(to_cell, nil, from.table)
    return create_event("ObjectsMoved", {
      table = from.table,
      objects = objects,
      from = { x = from.x, y = from.y },
      to = { x = to.x, y = to.y },
    })
  end,
  cellHideChanged = function(cell, hide, object)
    local global_cell = normalize_global_cell(cell)
    return create_event("CellHideChanged", {
      cell = global_cell,
      object = object,
      hide = hide,
    })
  end,
  objectIndexChanged = function(cell, object, index)
    return create_event("ObjectIndexChanged", {
      cell = normalize_global_cell(cell),
      object = object,
      index = index,
    })
  end,
  teamChanged = function(name, team, new_name)
    local payload = { name = name, team = team }
    if new_name ~= nil then
      payload.newName = new_name
    end
    return create_event("TeamChanged", payload)
  end,
  teamRemoved = function(team)
    return create_event("TeamRemoved", { team = team })
  end,
  mergeStrategyChanged = function(cell, strategy, span)
    return create_event("CellMergeStrategyChanged", {
      cell = normalize_global_cell(cell),
      strategy = strategy,
      span = span or 1,
    })
  end,
  metadataChanged = function(metadata)
    return create_event("MetadataChanged", { metadata = metadata })
  end,
  objectsRemoved = function(cell, objects)
    return create_event("ObjectsRemoved", {
      cell = normalize_global_cell(cell),
      objects = objects,
    })
  end,
  tableRenamed = function(name, new_name)
    return create_event("TableRenamed", { name = name, newName = new_name })
  end,
  tableRemoved = function(name)
    return create_event("TableRemoved", { name = name })
  end,
  noteChanged = function(name, content)
    return create_event("NoteChanged", { name = name, content = content })
  end,
  noteRemoved = function(name)
    return create_event("NoteRemoved", { name = name })
  end,
  waypointChanged = function(waypoint, team, name)
    return create_event("WaypointChanged", {
      team = team,
      waypoint = waypoint,
      name = name,
    })
  end,
  waypointRemoved = function(name, team)
    return create_event("WaypointRemoved", { team = team, name = name })
  end,
  worldInitialized = function(payload)
    return create_event("WorldInitialized", payload)
  end,
  teamJoined = function(user, team)
    return create_event("TeamJoined", { user = user, team = team })
  end,
  teamLeft = function(user, team)
    return create_event("TeamLeft", { user = user, team = team })
  end,
  objectsChanged = function(cell, objects)
    return create_event("ObjectsChanged", {
      cell = normalize_global_cell(cell),
      objects = objects or {},
    })
  end,
  cellShuffled = function(cell, positions)
    return create_event("CellShuffled", {
      cell = normalize_global_cell(cell),
      positions = positions or {},
    })
  end,
  message = function(message, user)
    return create_event("MessageSent", { user = user or 0, message = message })
  end,
  boardTilesSpawned = function(table_name, tiles)
    return create_event("BoardTilesSpawned", { table = table_name, tiles = tiles or {} })
  end,
  boardTilesChanged = function(table_name, tiles)
    return create_event("BoardTilesChanged", { table = table_name, tiles = tiles or {} })
  end,
  dialogOpened = function(dialog, close_others)
    return create_event("DialogOpened", { dialog = dialog, closeOthers = close_others == true })
  end,
  dialogsClosed = function(ids)
    return create_event("DialogsClosed", { ids = ids })
  end,
  dialogsClosedAll = function()
    return create_event("DialogsClosed", { ids = nil })
  end,
  imagesUpdated = function(images)
    return create_event("ImagesUpdated", { images = images })
  end,
  serverStateUpdated = function(state)
    return create_event("ServerStateUpdated", { state = state })
  end,
  authenticatedRequested = function(challenge, is_required)
    return create_event("AuthenticatedRequested", {
      challenge = challenge,
      isRequired = is_required ~= false,
    })
  end,
  toolbarUpdated = function(toolbar)
    return create_event("ToolbarUpdated", { toolbar = normalize_toolbar(toolbar) })
  end,
}

Setonix.requests = {
  emit = function(event, force)
    return Setonix.process(event, force)
  end,
  teamJoin = function(team, force)
    return Setonix.process(create_event("TeamJoinRequest", { team = team }), force)
  end,
  teamLeave = function(team, force)
    return Setonix.process(create_event("TeamLeaveRequest", { team = team }), force)
  end,
  cellRoll = function(cell, object, force)
    return Setonix.process(create_event("CellRollRequest", {
      cell = normalize_global_cell(cell),
      object = object,
    }), force)
  end,
  shuffleCell = function(cell, force)
    return Setonix.process(create_event("ShuffleCellRequest", {
      cell = normalize_global_cell(cell),
    }), force)
  end,
  packsChange = function(packs, force)
    return Setonix.process(create_event("PacksChangeRequest", { packs = packs }), force)
  end,
  message = function(message, force)
    return Setonix.process(create_event("MessageRequest", { message = message }), force)
  end,
  boardsSpawn = function(table_name, assets, force)
    return Setonix.process(create_event("BoardsSpawnRequest", {
      table = table_name,
      assets = assets or {},
    }), force)
  end,
  boardsSpawnAt = function(cell, assets, force)
    local global_cell, position = normalize_global_cell(cell)
    return Setonix.process(create_event("BoardsSpawnRequest", {
      table = global_cell.table,
      assets = {
        [position:key()] = assets,
      },
    }), force)
  end,
  boardRemove = function(cell, index, force)
    return Setonix.process(create_event("BoardRemoveRequest", {
      position = normalize_global_cell(cell),
      index = index,
    }), force)
  end,
  boardMove = function(table_name, from_cell, to_cell, index, force)
    local from = normalize_position(from_cell, nil, table_name)
    local to = normalize_position(to_cell, nil, table_name)
    return Setonix.process(create_event("BoardMoveRequest", {
      table = table_name or from.table,
      from = { x = from.x, y = from.y },
      to = { x = to.x, y = to.y },
      index = index,
    }), force)
  end,
  dialogClose = function(id, value, force)
    return Setonix.process(create_event("DialogCloseRequest", { id = id, value = value }), force)
  end,
  images = function(ids, force)
    return Setonix.process(create_event("ImagesRequest", { ids = ids }), force)
  end,
  modeChange = function(location, force)
    return Setonix.process(create_event("ModeChangeRequest", { location = location }), force)
  end,
  modePlain = function(force)
    return Setonix.process(create_event("ModeChangeRequest", { location = nil }), force)
  end,
  authenticate = function(signature, public_key, force)
    return Setonix.process(create_event("AuthenticateRequest", {
      signature = signature,
      publicKey = public_key,
    }), force)
  end,
  toolbarAction = function(action_id, force)
    return Setonix.process(create_event("ToolbarActionRequest", { actionId = action_id }), force)
  end,
}

Setonix.players = setmetatable({
  all = Setonix.getPlayers,
  get = Setonix.player,
}, {
  __call = function(_, ...)
    return Setonix.getPlayers(...)
  end,
})

Setonix.cells = setmetatable({
  get = Setonix.cell,
}, {
  __call = function(_, ...)
    return Setonix.cell(...)
  end,
})