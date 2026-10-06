--!nocheck
--!nolint

export type SetonixRaw = {
	Events: any,
	Server: any,
	State: any,
	events: any,
	server: any,
	state: any,
	storage: any,
}

export type SetonixWorld = {
	currentTable: () -> SetonixTable,
	getTable: (table_name: string) -> SetonixTable,
	cell: (position_or_x: any, y: number?, table_name: string?) -> SetonixCell,
}

export type SetonixState = {
	raw: () -> any,
	tableName: () -> string,
	tables: () -> any,
	info: () -> any,
	players: () -> any,
	teamMembers: () -> any,
	currentTable: () -> any,
}

export type SetonixCell = {
  table: string, x: number, y: number,
  key: (self: SetonixCell) -> string,
  toGlobal: (self: SetonixCell) -> any,
  copy: (self: SetonixCell) -> any,
  withTable: (self: SetonixCell, name: string) -> any,
  equals: (self: SetonixCell, other: any) -> boolean,
  raw: (self: SetonixCell) -> any,
  objects: (self: SetonixCell) -> {any},
  tiles: (self: SetonixCell) -> {any},
  isEmpty: (self: SetonixCell) -> boolean,
  topObject: (self: SetonixCell) -> any?,
  object: (self: SetonixCell, index: number?) -> any?,
  topObjects: (self: SetonixCell, count: number?) -> {any},
  countObjects: (self: SetonixCell) -> number,
  hasObjects: (self: SetonixCell) -> boolean,
  spawn: (self: SetonixCell, objects: any, target: number?) -> (),
  spawnObject: (self: SetonixCell, asset: string, options: any?, target: number?) -> (),
  setObjects: (self: SetonixCell, objects: any, target: number?) -> (),
  layout: (self: SetonixCell, strategy: any?, span: number?, target: number?) -> (),
  remove: (self: SetonixCell, objects: any?, target: number?) -> (),
  clear: (self: SetonixCell, target: number?) -> (),
  show: (self: SetonixCell, object: number?, target: number?) -> (),
  hide: (self: SetonixCell, object: number?, target: number?) -> (),
  moveTo: (self: SetonixCell, cell: any, objects: {number}, target: number?) -> (),
  moveTopTo: (self: SetonixCell, cell: any, count: number?, target: number?) -> (),
  shuffle: (self: SetonixCell, force: boolean?) -> (),
  roll: (self: SetonixCell, object: number?, force: boolean?) -> (),
}

export type SetonixTable = {
  name: string,
  raw: (self: SetonixTable) -> any,
  cell: (self: SetonixTable, position_or_x: any, y: number?) -> SetonixCell,
  getCell: (self: SetonixTable, position_or_x: any, y: number?) -> SetonixCell,
  cells: (self: SetonixTable) -> any,
  position: (self: SetonixTable, x: number, y: number) -> any,
  bounds: (self: SetonixTable) -> (any?, any?),
  contains: (self: SetonixTable, position_or_x: any, y: number?) -> boolean,
  setBounds: (self: SetonixTable, minimum: any?, maximum: any?, target: number?) -> (),
  clearBounds: (self: SetonixTable, target: number?) -> (),
  spawn: (self: SetonixTable, position_or_x: any, y: any?, objects: any?, target: number?) -> (),
  spawnObject: (self: SetonixTable, position_or_x: any, y: any?, asset: any?, options: any?, target: number?) -> (),
}

export type SetonixStorage = {
  get: (key: string, default: any?) -> any,
  set: (key: string, value: any) -> (),
  update: (key: string, updater: (value: any) -> any, default: any?) -> any,
  remove: (key: string) -> (),
  clear: () -> (),
  all: () -> any,
}

export type SetonixNotes = {
  set: (name: string, content: string, target: number?) -> (),
  remove: (name: string, target: number?) -> (),
}

export type SetonixCollections = {
	copy: (values: any) -> any,
	shuffle: (values: any) -> any,
	sorted: (values: any, comparator: ((a: any, b: any) -> boolean)?) -> any,
}

export type SetonixScoring = {
	bestTotal: (items: any, resolver: any, max_score: number?) -> number,
}

export type SetonixEvents = {
	on: (event_name: string, handler: (event: any) -> any) -> any,
	listen: (event_name: string, handler: (event: any) -> any) -> any,
	action: (action_id: string, handler: (event: any) -> any) -> any,
}

export type SetonixCommands = {
	register: (name: string, handler: (event: any) -> any, options: any?) -> any,
}

export type SetonixTables = {
	current: () -> SetonixTable,
	get: (table_name: string) -> SetonixTable,
}

export type SetonixServerEvents = {
	cellSwitched: (cell: any, selected: boolean?, teleport: boolean?) -> any,
	backgroundChanged: (background: any) -> any,
	tableBoundsChanged: (table_name: string, minimum: any?, maximum: any?) -> any,
	noteChanged: (name: string, content: string) -> any,
	noteRemoved: (name: string) -> any,
	objectsChanged: (cell: any, objects: any) -> any,
	mergeStrategyChanged: (cell: any, strategy: any?, span: number?) -> any,
	objectsSpawned: (table_name: string, objects: any) -> any,
	objectsSpawnedAt: (cell: any, objects: any) -> any,
	objectsRemoved: (cell: any, objects: any?) -> any,
	objectsMoved: (from_cell: any, to_cell: any, objects: any, target: any?) -> any,
	cellHideChanged: (cell: any, hide: boolean?, object: number?) -> any,
	message: (message: string, author: any?) -> any,
	toolbarUpdated: (toolbar: any) -> any,
	boardTilesSpawned: (table_name: string, tiles: any) -> any,
	boardTilesChanged: (table_name: string, tiles: any) -> any,
	dialogOpened: (dialog: any) -> any,
	dialogsClosed: (id: any?) -> any,
}

export type SetonixServer = {
	send: (event: any, target: any?) -> any,
	process: (event: any, force: boolean?) -> any,
	message: (message: string, target: any?, author: any?) -> any,
	broadcast: (message: string, author: any?) -> any,
	setToolbar: (toolbar: any, target: any?) -> any,
	toolbarAction: (id: string, label: string, enabled: boolean?) -> any,
	events: SetonixServerEvents,
}

export type SetonixRequests = {
	teamJoin: (team: string, force: boolean?) -> any,
	teamLeave: (team: string, force: boolean?) -> any,
	cellRoll: (cell: any, object: any, force: boolean?) -> any,
	shuffleCell: (cell: any, force: boolean?) -> any,
	packsChange: (packs: any, force: boolean?) -> any,
	boardsSpawn: (table_name: string, assets: any, force: boolean?) -> any,
	boardRemove: (cell: any, index: number, force: boolean?) -> any,
	boardMove: (table_name: string, from_cell: any, to_cell: any, index: number, force: boolean?) -> any,
	dialogClose: (id: string, value: any, force: boolean?) -> any,
	images: (ids: any, force: boolean?) -> any,
	modeChange: (location: string, force: boolean?) -> any,
	modePlain: (force: boolean?) -> any,
	authenticate: (signature: string, public_key: string, force: boolean?) -> any,
	toolbarAction: (action_id: string, force: boolean?) -> any,
}

export type SetonixPlayers = ((self: SetonixPlayers) -> {any}) & {
	all: () -> {any},
	get: (player_id: number) -> any,
}

export type SetonixCells = ((self: SetonixCells, position_or_x: any, y: number?, table_name: string?) -> SetonixCell) & {
	get: (position_or_x: any, y: number?, table_name: string?) -> SetonixCell,
}

export type SetonixDef = {
	raw: SetonixRaw,
	channels: {all: number, authority: number},
	storage: SetonixStorage,
	notes: SetonixNotes,
	world: SetonixWorld,
	state: SetonixState,
	collections: SetonixCollections,
	scoring: SetonixScoring,
	events: SetonixEvents,
	commands: SetonixCommands,
	tables: SetonixTables,
	server: SetonixServer,
	requests: SetonixRequests,
	players: SetonixPlayers,
	cells: SetonixCells,
	
	event: (event_type: string, payload: any?) -> any,
	namespace: () -> string,
	game: () -> string,
	pluginId: () -> string,
	getPlayers: () -> any,
	player: (player_id: number) -> any,
	currentTable: () -> SetonixTable,
	getTable: (table_name: string) -> SetonixTable,
	cell: (position_or_x: any, y: number?, table_name: string?) -> SetonixCell,
	position: (position_or_x: any, y: number?, table_name: string?) -> any,
	object: (asset: string, options: any?) -> any,
	send: (event: any, target: any?) -> any,
	process: (event: any, force: boolean?) -> any,
	log: (message: string) -> (),
	message: (message: string, target: any?, author: any?) -> any,
	broadcast: (message: string, author: any?) -> any,
	toolbarAction: (id: string, label: string, enabled: boolean?) -> any,
	setToolbar: (toolbar: any, target: any?) -> any,
	moveObjects: (from_cell: any, to_cell: any, objects: any, target: any?) -> any,
	on: (event_name: string, handler: (event: any) -> any) -> any,
	listen: (event_name: string, handler: (event: any) -> any) -> any,
	onAction: (action_id: string, handler: (event: any) -> any) -> any,
	command: (name: string, handler: (event: any) -> any, options: any?) -> any,
}

declare Setonix: SetonixDef
declare SetonixRaw: SetonixRaw
