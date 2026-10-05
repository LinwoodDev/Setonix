#include <emscripten.h>
EM_JS_DEPS(setonix_host, "$stringToNewUTF8");

EM_JS(void, setonix_report_error, (const char* message), {
    console.error(UTF8ToString(message));
});

EM_JS(char*, setonix_host_sync, (int plugin, const char* method, const char* args), {
    const value = Module.setonixHost.sync(plugin, UTF8ToString(method), JSON.parse(UTF8ToString(args)));
    return stringToNewUTF8(JSON.stringify(value));
});

EM_JS(void, setonix_host_async, (int plugin, int request, const char* method, const char* args), {
    const name = UTF8ToString(method);
    const values = JSON.parse(UTF8ToString(args));
    Promise.resolve().then(() => Module.setonixHost.async(plugin, name, values)).then(
        response => Module.ccall('complete_callback', null, ['number', 'string'], [request, response]),
        error => Module.ccall('complete_callback', null, ['number', 'string'],
            [request, JSON.stringify({error: String(error)})])
    ).then(() => Module.setonixWake());
});
