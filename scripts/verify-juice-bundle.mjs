// Verify the pinned Juice bundle before publishing or after static export.
import { createHash } from 'node:crypto';
import { readdir, readFile } from 'node:fs/promises';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptsDir = dirname(fileURLToPath(import.meta.url));
const expected = JSON.parse(await readFile(join(scriptsDir, 'juice-bundle.sha256.json'), 'utf8'));
const root = resolve(process.argv[2] || join(scriptsDir, '..', 'juice'));
const actual = {};
async function walk(dir, prefix = '') {
  for (const entry of await readdir(dir, { withFileTypes: true })) {
    const relative = prefix ? `${prefix}/${entry.name}` : entry.name;
    const path = join(dir, entry.name);
    if (entry.isDirectory()) await walk(path, relative);
    else if (entry.isFile()) actual[relative] = createHash('sha256').update(await readFile(path)).digest('hex');
    else throw new Error(`Unsupported Juice bundle entry: ${relative}`);
  }
}
await walk(root);
const errors = [];
for (const [file, hash] of Object.entries(expected)) {
  if (!(file in actual)) errors.push(`missing: ${file}`);
  else if (actual[file] !== hash) errors.push(`changed: ${file}`);
}
for (const file of Object.keys(actual)) if (!(file in expected)) errors.push(`unexpected: ${file}`);
if (errors.length) {
  console.error(`Juice bundle verification failed:\n${errors.join('\n')}`);
  process.exitCode = 1;
} else {
  console.log(`Verified ${Object.keys(expected).length} Juice bundle files in ${root}`);
}
