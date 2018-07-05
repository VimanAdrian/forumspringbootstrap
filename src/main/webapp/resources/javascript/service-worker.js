var cacheName = "offlineCache";

// Default files to always cache
var cacheFiles = [
    "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js",
    "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js",
    "https://bootswatch.com/3/flatly/bootstrap.css",
    "//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Converter.js",
    "//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Editor.js",
    "//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Sanitizer.js",
    "https://cdn.rawgit.com/balpha/pagedown/master/demo/browser/demo.css",
    "https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js",
    "/resources/css/tomorrow.css",
    "/resources/javascript/jquery.flexdatalist.js",
    "/resources/css/jquery.flexdatalist.css",
    "https://use.fontawesome.com/releases/v5.0.12/css/all.css",
    "http://localhost:8080/offline"
];

self.addEventListener('install', function (e) {
    console.log('[ServiceWorker] Installed');
    // e.waitUntil Delays the event until the Promise is resolved
    e.waitUntil(
        // Open the cache
        caches.open(cacheName).then(function (cache) {
            // Add all the default files to the cache
            console.log('[ServiceWorker] Caching cacheFiles');
            return cache.addAll(cacheFiles);
        })
    ); // end e.waitUntil
});


self.addEventListener('activate', function (e) {
    console.log('[ServiceWorker] Activated');
    e.waitUntil(
        // Get all the cache keys (cacheName)
        caches.keys().then(function (cacheNames) {
            return Promise.all(cacheNames.map(function (thisCacheName) {
                // If a cached item is saved under a previous cacheName
                if (thisCacheName !== cacheName) {
                    // Delete that cached file
                    console.log('[ServiceWorker] Removing Cached Files from Cache - ', thisCacheName);
                    return caches.delete(thisCacheName);
                }
            }));
        })
    ); // end e.waitUntil
});

self.addEventListener('fetch', function (event) {
    event.respondWith(
        // Try the network
        fetch(event.request).then(function (res) {
            return caches.open(cacheName).then(function (cache) {
                // Put in cache if succeeds
                cache.put(event.request.url, res.clone());
                return res;
            })
        })
            .catch(function (err) {
                // Fallback to cache
                return caches.match(event.request)
                    .then(function (res) {
                        if (res === undefined) {
                            return caches.match("http://localhost:8080/offline");
                        }
                        return res;
                    })
            })
    );
});
