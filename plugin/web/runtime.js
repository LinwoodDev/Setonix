(function () {
  "use strict";
  // Resolve alongside this script, including apps hosted under a base path.
  const base = new URL(".", document.currentScript.src);
  let initialization;
  let module;
  const hosts = new Map();
  const tasks = new Map();

  function resultCall(name, types, args) {
    const pointer = module.ccall(name, "number", types, args);
    try { return JSON.parse(module.UTF8ToString(pointer)); }
    finally { module.ccall("free_result", null, ["number"], [pointer]); }
  }

  function poll(id) {
    const task = tasks.get(id);
    if (!task) return;
    try {
      const result = resultCall("poll_task", ["number"], [id]);
      if (result.pending) return;
      tasks.delete(id);
      if (result.error) task.reject(new Error(result.error));
      else task.resolve(JSON.stringify(result.value));
    } catch (error) {
      tasks.delete(id);
      task.reject(error);
    }
  }

  globalThis.setonixLuau = {
    init() {
      return initialization ??= new Promise((resolve, reject) => {
        const script = document.createElement("script");
        script.src = new URL("setonix_luau.js", base).href;
        script.onerror = () => reject(new Error("Could not load the Luau WebAssembly loader"));
        script.onload = () => {
          createSetonixLuau({locateFile: file => new URL(file, base).href}).then(instance => {
            module = instance;
            module.setonixHost = {
              sync(id, method, args) {
                const host = hosts.get(id);
                if (!host) throw new Error("Plugin has been disposed");
                return JSON.parse(host.sync(method, JSON.stringify(args)));
              },
              async(id, method, args) {
                const host = hosts.get(id);
                if (!host) throw new Error("Plugin has been disposed");
                return host.async(method, JSON.stringify(args));
              }
            };
            module.setonixWake = () => queueMicrotask(() => { for (const id of [...tasks.keys()]) poll(id); });
            resolve();
          }, reject);
        };
        document.head.appendChild(script);
      }).catch(error => { initialization = undefined; throw error; });
    },
    create(code, sync, async) {
      if (!module) throw new Error("Initialize the Luau runtime first");
      const id = module.ccall("create_plugin", "number", ["string"], [code]);
      hosts.set(id, {sync, async});
      return id;
    },
    run(plugin, event) {
      return new Promise((resolve, reject) => {
        const result = resultCall("start_task", ["number", "string"], [plugin, event]);
        if (result.error) { reject(new Error(result.error)); return; }
        tasks.set(result.task, {plugin, resolve, reject});
        poll(result.task);
      });
    },
    destroy(plugin) {
      for (const [id, task] of tasks) {
        if (task.plugin === plugin) { tasks.delete(id); task.reject(new Error("Plugin has been disposed")); }
      }
      hosts.delete(plugin);
      module.ccall("destroy_plugin", null, ["number"], [plugin]);
    },
    dispose() { for (const plugin of [...hosts.keys()]) this.destroy(plugin); }
  };
})();
