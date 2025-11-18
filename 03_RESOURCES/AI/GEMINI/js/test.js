// /Users/ideaopedia/Documents/textDump/03_RESOURCES/AI/GEMINI/js/test.js
// Simple Node.js demo: fetch posts from JSONPlaceholder with a tiny in-memory cache.
// Run: node test.js         -> prints first 5 posts
//      node test.js <id>    -> prints post with that id
// Requires Node 18+ (global fetch) or an environment with fetch available.

// Cache implementation
class SimpleCache {
    constructor(ttlMs = 60_000) {  // Default 1 minute TTL
        this.ttl = ttlMs;
        this.store = new Map();  // In-memory storage
    }

    async get(key, loader) {
        const now = Date.now();
        const cached = this.store.get(key);
        // Return cached value if not expired
        if (cached && cached.expire > now) return cached.value;
        // Otherwise fetch new value
        const value = await loader();
        // Store with expiration
        this.store.set(key, { value, expire: now + this.ttl });
        return value;
    }

    clear() {
        this.store.clear();
    }
}

// Helper function to fetch JSON data
async function fetchJson(url) {
    // Requires Node 18+ for global fetch
    if (typeof fetch === 'undefined') {
        throw new Error('Global fetch is unavailable. Use Node 18+ or provide a fetch polyfill.');
    }
    const res = await fetch(url);
    if (!res.ok) throw new Error(`HTTP ${res.status} fetching ${url}`);
    return res.json();
}

// Main program logic
async function main() {
    // Initialize cache with 30 second TTL
    const cache = new SimpleCache(30_000);
    const base = 'https://jsonplaceholder.typicode.com/posts';
    const id = process.argv[2];  // Get ID from command line argument

    try {
        if (id) {
            // Fetch specific post
            const post = await cache.get(`post:${id}`, () => fetchJson(`${base}/${id}`));
            console.log('Post:', JSON.stringify(post, null, 2));
        } else {
            // Fetch all posts and show first 5
            const posts = await cache.get('posts', () => fetchJson(base));
            console.log('First 5 posts:');
            posts.slice(0, 5).forEach(({ id, title, userId }) =>
                console.log(`#${id} (user ${userId}): ${title}`)
            );
        }
    } catch (err) {
        console.error('Error:', err.message);
        process.exitCode = 1;
    }
}

// Run main() if script is run directly (not imported)
if (require.main === module) main();