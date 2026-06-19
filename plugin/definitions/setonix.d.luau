--!nocheck
--!nolint

export type SetonixRaw = {
	Events: any,
	Server: any,
	State: any,
	events: any,
	server: any,
	state: any,
}

export type SetonixWorld = {
	currentTable: () -> any,
	getTable: (table_name: string) -> any,
	cell: (position_or_x: any, y: number?, table_name: string?) -> any,
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

export type SetonixCollections = {
	copy: (values: any) -> any,
	shuffle: (values: any) -> any,
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
	current: () -> any,
	get: (table_name: string) -> any,
}

export type SetonixServerEvents = {
	cellSwitched: (cell: any, selected: boolean?, teleport: boolean?) -> any,
	backgroundChanged: (background: any) -> any,
	objectsSpawned: (table_name: string, objects: any) -> any,
	objectsSpawnedAt: (cell: any, objects: any) -> any,
	objectsRemoved: (objects: any, target: any?) -> any,
	objectsMoved: (from_cell: any, to_cell: any, objects: any, target: any?) -> any,
	cellHideChanged: (cell: any, object: any?, hide: boolean?) -> any,
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

export type SetonixCells = ((self: SetonixCells, position_or_x: any, y: number?, table_name: string?) -> any) & {
	get: (position_or_x: any, y: number?, table_name: string?) -> any,
}

export type SetonixDef = {
	raw: SetonixRaw,
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
	currentTable: () -> any,
	getTable: (table_name: string) -> any,
	cell: (position_or_x: any, y: number?, table_name: string?) -> any,
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
