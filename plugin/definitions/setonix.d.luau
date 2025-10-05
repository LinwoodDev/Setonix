---@meta

type Channel = number
type JsonObject = {[string]: any}
type EventDetails = {
  source: Channel,
  server_event: JsonObject,
  target: Channel,
  cancelled: boolean,
  needs_update: {Channel}?
}
type EventConnection = {
  Disconnect: () -> nil
}

declare function ResetWorld(): number
declare function Process(event: JsonObject): number
declare function Send(event: JsonObject): number
declare TableName: string
declare Tables: {string}
declare Info: JsonObject
declare Players: {number}
declare PluginId: string
declare Table: JsonObject
declare function GetTable(name: string): JsonObject?
declare Events: {
  [string]: {
    Connect: (callback: (event: JsonObject, details: EventDetails) -> nil) -> EventConnection
  }
}
