{{flutter_js}}
{{flutter_build_config}}

// Flutter no longer supplies an offline worker. The release build generates
// our own at this URL, also replacing legacy Flutter worker registrations.
if ('serviceWorker' in navigator && window.isSecureContext) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register(
      new URL('flutter_service_worker.js', document.baseURI),
      { scope: new URL('./', document.baseURI).href, updateViaCache: 'none' }
    ).catch((error) => console.warn('Offline cache registration failed:', error));
  });
}

_flutter.loader.load();
