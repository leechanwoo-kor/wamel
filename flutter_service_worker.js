'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "7741075bb98b0097cc86306a495973b5",
"/": "7741075bb98b0097cc86306a495973b5",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "728fc5592507be7e40fac86947650653",
"assets/AssetManifest.bin.json": "ce0aa63b17b620e06b0b7998f9d98593",
"assets/assets/images/ai.jpg": "27479fecba4c2e75927841d745d80d94",
"assets/assets/images/fruits/5.png": "60d08989d81ca6cfad8350f8d0aa185b",
"assets/assets/images/fruits/8.png": "b35861c6b98b9a55765157d8c3be074d",
"assets/assets/images/fruits/3.png": "2565f687b176777af7b5c7d5ef187e1f",
"assets/assets/images/fruits/9.png": "8c363eb66ec576236ff168f915455edc",
"assets/assets/images/fruits/1.png": "fc014ed265e605830dc927b812e20933",
"assets/assets/images/fruits/4.png": "53975916191b89d5a0793d2d5b8fc558",
"assets/assets/images/fruits/2.png": "17fd063588c43e3ee5e61f5aa1fb2f75",
"assets/assets/images/fruits/6.png": "defe31745a84ac9d53a55646be01f302",
"assets/assets/images/fruits/10.png": "7079202863241fcca04c400621f77096",
"assets/assets/images/fruits/11.png": "d389b5a8f5bf08cad5ce61cc0f073b8f",
"assets/assets/images/fruits/7.png": "db02a5098ca3a4a4852cc206633ae404",
"assets/assets/images/flame.png": "8c3eb8306a355c0e988e15edf755b01f",
"assets/assets/images/qr.jpg": "f7f42af62fd1020e765dd3e1c6f74e3e",
"assets/assets/images/shine.png": "b31c4812ec5e279b8e53d5bee3dd781d",
"assets/assets/images/dead_line.png": "f35c5f41cdfcb17d846570fdcb270e2d",
"assets/assets/images/setting.png": "5580421b58e6735887a5887944f4df98",
"assets/assets/images/bg.png": "ccd7527bac6fc8e89f8026bcf32bf5a2",
"assets/assets/audio/cheer.mp3": "09d3ea18508b1c84ed1d21b9d2b33442",
"assets/assets/audio/coin.wav": "27cb4140ba59442d872236104879674a",
"assets/assets/audio/mix.wav": "3b18cb3d571dc0e01e6f80b3a537486c",
"assets/assets/audio/fall.mp3": "95ecdb45f28ea6a157ceb296c2af92ee",
"assets/assets/audio/boom.mp3": "d8ef645cdf329a524797a0e0d3e2f7ea",
"assets/assets/audio/boom1.mp3": "0fab96ac9809092355508850c3f3b3a2",
"assets/assets/audio/boom2.mp3": "da55d9fbb9710fd7a6c86536049ee90f",
"assets/AssetManifest.bin": "3b3af88d6bbc7f30a6369fb44119770f",
"assets/NOTICES": "081d62ced138e57f53ac795b1b9f69c8",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "b8906daf26df84be5f6d83b690d62a04",
"version.json": "942c9b72bcf1e2c1603c52b9f9bcdeef",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "32038094d3ae06cb7b7abb2b34ebfb75",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"main.dart.js": "c3bfeacf025d6af7e771217926d3dfac"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
