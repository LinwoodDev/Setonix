---@meta

type Channel = number
type JsonObject = { [string]: any }

type EventDetails = {
	source: Channel,
	server_event: JsonObject,
	target: Channel,
	cancelled: boolean,
	needs_update: { Channel }?
}

type EventConnection = {
	Disconnect: () -> nil
}

declare function ResetWorld(): number

declare State: {
	TableName: string,
	Tables: { string },
	Info: JsonObject,
	Players: { number },
	PluginId: string,
	Namespace: string,
	Game: string,
	Table: JsonObject,
	GetTable: (self: any, name: string) -> JsonObject?
}

declare Server: {
	Process: (self: any, event: JsonObject, force: boolean) -> number,
	Send: (self: any, event: JsonObject, target: number) -> number,
}

declare Events: {
	[string]: {
		Connect: (callback: (event: JsonObject, details: EventDetails) -> nil) -> EventConnection
	}
}
