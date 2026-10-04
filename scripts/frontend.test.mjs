// Script behavior fixtures, not a browser or a layout/accessibility certification.
import test from 'node:test';
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import vm from 'node:vm';

class Element {
  constructor(tag = 'div', attrs = {}) {
    this.tag = tag; this.attrs = attrs; this.children = []; this.listeners = {};
    this.dataset = Object.fromEntries(Object.entries(attrs).filter(([key]) => key.startsWith('data-'))
      .map(([key, value]) => [key.slice(5).replace(/-([a-z])/g, (_, c) => c.toUpperCase()), value]));
    this.checked = 'checked' in attrs; this.hidden = 'hidden' in attrs; this.disabled = 'disabled' in attrs; this.style = {};
    this.classList = { add: value => { this.attrs.class = `${this.attrs.class || ''} ${value}`; } };
  }
  get id() { return this.attrs.id; }
  get name() { return this.attrs.name; }
  get value() { return this._value ?? this.attrs.value ?? (this.tag === 'select' ? this.children[0]?.value : '') ?? ''; }
  set value(value) { this._value = String(value); }
  get textContent() { return (this._text || '') + this.children.map(child => child.textContent).join(''); }
  set textContent(value) { this._text = String(value); this.children = []; }
  set className(value) { this.attrs.class = value; }
  get parentElement() { return this.parent; }
  get nextElementSibling() { return this.parent?.children[this.parent.children.indexOf(this) + 1]; }
  get previousElementSibling() { return this.parent?.children[this.parent.children.indexOf(this) - 1]; }
  get selectedOptions() { return this.children.filter(option => option.value === this.value).map(option => ({text: option.textContent})); }
  append(...children) { for (const child of children) { child.parent = this; this.children.push(child); } }
  replaceChildren(...children) { this.children = []; this.append(...children); }
  remove() { this.parent.children = this.parent.children.filter(child => child !== this); }
  setAttribute(key, value) { this.attrs[key] = value; }
  setCustomValidity(value) { this.validityMessage = value; }
  checkValidity() { return this.querySelectorAll('input').every(input => !input.validityMessage && (!('required' in input.attrs) || input.value !== '')); }
  getBoundingClientRect() { return this.rect || {left: 0, right: 100, top: 0, bottom: 24}; }
  focus() { this.focused = true; this.fire('focus'); }
  addEventListener(name, callback) { (this.listeners[name] ||= []).push(callback); }
  fire(name, details = {}) {
    const event = {target: this, preventDefault() {}, ...details};

    for (let current = this; current; current = current.parent) {
      for (const callback of current.listeners[name] || []) callback(event);
    }
  }
  matches(selector) {
    const tag = selector.match(/^[a-z]+/);

    if (tag && this.tag !== tag[0]) return false;
    const id = selector.match(/#([\w-]+)/);

    if (id && this.id !== id[1]) return false;

    for (const [, name] of selector.matchAll(/\.([\w-]+)/g)) {
      if (!(this.attrs.class || '').split(/\s+/).includes(name)) return false;
    }

    for (const [, key, value] of selector.matchAll(/\[([\w-]+)(?:="([^"]*)")?\]/g)) {
      if (!(key in this.attrs) || (value !== undefined && this.attrs[key] !== value)) return false;
    }

    return true;
  }
  closest(selector) { for (let current = this; current; current = current.parent) if (current.matches(selector)) return current;

 return null; }
  querySelectorAll(selector) {
    const parts = selector.split(' ');

    const matches = element => {
      if (!element.matches(parts.at(-1))) return false;
      let current = element.parent;

      for (let i = parts.length - 2; i >= 0; i--) {
        while (current && !current.matches(parts[i])) current = current.parent;

        if (!current) return false;
        current = current.parent;
      }

      return true;
    };

    const result = [];
    const walk = root => { for (const child of root.children) { if (matches(child)) result.push(child); walk(child); } };

    walk(this);

 return result;
  }
  querySelector(selector) { return this.querySelectorAll(selector)[0] || null; }
  set innerHTML(source) {
    this.children = [];
    const stack = [this];

    for (const token of source.match(/<[^>]*>|[^<]+/g) || []) {
      if (token.startsWith('</')) { stack.pop(); continue; }

      if (token.startsWith('<')) {
        const tag = token.match(/^<([\w-]+)/)?.[1];

        if (!tag) continue;
        const attrs = {};
        const raw = token.slice(tag.length + 1, -1);

        for (const [, key, quoted, plain] of raw.matchAll(/([\w-]+)(?:="([^"]*)"|=([^\s>]+))?/g)) attrs[key] = quoted ?? plain ?? '';
        const element = new Element(tag, attrs); stack.at(-1).append(element);

        if (!['input', 'col', 'br', 'img', 'hr', 'meta', 'link'].includes(tag)) stack.push(element);
      } else { stack.at(-1)._text = (stack.at(-1)._text || '') + token; }
    }
  }
}

const file = name => readFile(new URL(`../${name}`, import.meta.url), 'utf8');

const documentFixture = html => {
  const document = new Element('document'); document.innerHTML = html;
  document.readyState = 'complete'; document.createElement = tag => new Element(tag);

  return document;
};

async function writingFixture(url = 'https://example.test/blog/') {
  const document = documentFixture(`<main class="writing-index">
    <input id="writing-search"><details class="topic-disclosure"><span data-topic-label>Topics</span></details>
    <label class="tag-choice"><input data-tag-filter value="" checked></label>
    <label class="tag-choice" data-writing-count="1"><input data-tag-filter value="Rust"></label>
    <label class="tag-choice" data-writing-count="0"><input data-tag-filter value="Physics"></label>
    <p data-filter-status></p><button data-clear-filters hidden></button><div data-search-empty hidden></div>
    <ol><li class="post-item"><article class="post-row" data-tags="Rust" data-search="Rust compiler" data-study-note="false"><button data-tag-select="Rust"></button></article></li>
    <li class="post-item"><article class="post-row" data-tags="Economics" data-search="Housing prices" data-study-note="false"></article></li>
    <li class="post-item"><article class="post-row" data-tags="Physics" data-search="Circuits" data-study-note="true"></article></li></ol>
    <input data-study-filter type="checkbox"></main>`);

  let location = new URL(url);
  const listeners = {};

  const window = { get location() { return location; }, history: {replaceState: (_, __, url) => {location = new URL(url, location);}},
    addEventListener: (event, callback) => { listeners[event] = callback; } };

  vm.runInNewContext(await file('static/js/blog-filter.js'), {document, window, URL, URLSearchParams});

  return {document, window, visible: () => document.querySelectorAll('.post-row').filter(post => !post.hidden),
    navigate: url => {location = new URL(url, location); listeners.popstate();}};
}

test('writing restores encoded topic/search URLs and preserves unrelated URL parameters', async () => {
  const f = await writingFixture('https://example.test/blog/?topic=Rust&q=compiler&from=article#writing');
  assert.equal(f.visible().length, 1);
  assert.equal(f.document.querySelector('#writing-search').value, 'compiler');
  assert.equal(f.document.querySelector('[data-topic-label]').textContent, 'Rust');
  const search = f.document.querySelector('#writing-search'); search.value = 'Rust'; search.fire('input');
  assert.equal(f.window.location.searchParams.get('q'), 'Rust');
  assert.equal(f.window.location.searchParams.get('from'), 'article');
  assert.equal(f.window.location.hash, '#writing');
  assert.equal(f.document.querySelector('.topic-disclosure').open, undefined);
});

test('study-only topics are opt-in; switching archive off recovers a useful authored list', async () => {
  const f = await writingFixture('https://example.test/blog/?topic=Physics&study=1');
  assert.equal(f.visible().length, 1);
  const archive = f.document.querySelector('[data-study-filter]'); archive.checked = false; archive.fire('change');
  assert.equal(f.visible().length, 2);
  assert.equal(f.window.location.searchParams.has('topic'), false);
  assert.equal(f.window.location.searchParams.has('study'), false);
  assert.equal(f.document.querySelector('[data-clear-filters]').hidden, true);
});

test('empty search, reset and browser history restore filter state', async () => {
  const f = await writingFixture();
  const search = f.document.querySelector('#writing-search'); search.value = 'not present'; search.fire('input');
  assert.equal(f.visible().length, 0);
  assert.equal(f.document.querySelector('[data-search-empty]').hidden, false);
  f.document.querySelector('[data-clear-filters]').fire('click');
  assert.equal(f.visible().length, 2);
  assert.equal(search.focused, true);
  f.navigate('/blog/?topic=Rust'); assert.equal(f.visible().length, 1);
  f.navigate('/blog/?topic=unknown'); assert.equal(f.visible().length, 2);
});

async function hornetFixture() {
  const document = documentFixture(await file('templates/hornet.html'));
  const form = document.querySelector('#hornet-form');
  form.elements = {valuationDate: document.querySelector('#hornet-date')};
  const wasm = await readFile(new URL('../static/js/vendor/hornet/hornet_core.wasm', import.meta.url));
  let clipboard;

  const context = {document, Intl, Date, console, Response, WebAssembly, requestAnimationFrame: callback => callback(),
    window: {innerWidth: 390, innerHeight: 844}, fetch: async () => new Response(wasm, {headers: {'Content-Type': 'application/wasm'}}),
    navigator: {clipboard: {writeText: async value => {clipboard = value;}}}};

  vm.runInNewContext(await file('static/js/hornet.js'), context);

  for (let attempt = 0; attempt < 100 && document.querySelector('#hornet-copy').disabled; attempt++) await new Promise(resolve => setTimeout(resolve, 5));
  assert.notEqual(document.querySelector('[data-total="0"]').textContent, '—', 'real WASM module must initialize');

  return {document, form, context, clipboard: () => clipboard, row: () => document.querySelector('#hornet-trades').children[0]};
}

test('Hornet caps source precision, rejects invalid cells, and uses explicit increments', async () => {
  const f = await hornetFixture();
  const spot = f.document.querySelector('#hornet-spot');
  const previous = f.document.querySelector('[data-total="0"]').textContent;
  spot.value = '20.123456'; spot.fire('input'); assert.equal(spot.value, '20.123');
  assert.notEqual(f.document.querySelector('[data-total="0"]').textContent, previous);
  spot.fire('wheel'); assert.equal(spot.value, '20.123');
  spot.parentElement.querySelector('button').fire('click'); assert.equal(spot.value, '20.133');
  spot.value = '-1'; spot.fire('input');
  assert.equal(f.document.querySelector('#hornet-status').dataset.state, 'error');
  assert.equal(f.document.querySelector('[data-total="0"]').textContent, '—');
  spot.value = '20'; spot.fire('focusout'); assert.equal(spot.value, '20.000');
  assert.notEqual(f.document.querySelector('[data-total="0"]').textContent, '—');
  const notional = f.row().querySelector('[name="notional"]');
  notional.value = '1000000.99'; notional.fire('input'); assert.equal(notional.value, '1000000');
  notional.fire('focusout'); assert.equal(notional.value, '1,000,000');
});

test('Hornet adds and removes trades; an equal short cancels all nine totals', async () => {
  const f = await hornetFixture();
  f.document.querySelector('#hornet-add').fire('click');
  const rows = f.document.querySelector('#hornet-trades').children;
  assert.equal(rows.length, 2);
  const side = rows[1].querySelector('[name="side"]'); side.value = '-1'; side.fire('change');

  for (const output of f.document.querySelectorAll('[data-total]')) assert.equal(output.textContent, '0');
  f.document.querySelector('#hornet-copy').fire('click');
  await new Promise(resolve => setImmediate(resolve));
  const copied = f.clipboard().split('\n');
  assert.equal(copied.length, 4); assert.equal(copied[0].split('\t').length, 15);
  assert.equal(copied.at(-1), 'Total\t\t\t0\t\t\t0\t0\t0\t0\t0\t0\t0\t0\t0');
  rows[1].querySelector('.hornet-remove').fire('click');
  assert.equal(f.document.querySelector('#hornet-trades').children.length, 1);
  f.row().querySelector('.hornet-remove').fire('click');
  assert.equal(f.document.querySelector('#hornet-status').textContent, 'Add a trade to start a scenario.');
  assert.equal(f.document.querySelector('#hornet-add').focused, true);
});

test('Hornet clears stale prices for invalid expiry and positions dismissible tooltips within the viewport', async () => {
  const f = await hornetFixture();
  const expiry = f.row().querySelector('[name="expiry"]'); expiry.value = '2000-01-01'; expiry.fire('change');
  assert.equal(f.document.querySelector('[data-total="0"]').textContent, '—');
  assert.match(f.document.querySelector('#hornet-status').textContent, /expiry must be/);
  const help = f.document.querySelector('.hornet-help');
  help.rect = {right: 385, top: 800, bottom: 824}; help.fire('focus');
  const tooltip = help.querySelector('[role="tooltip"]');
  assert.equal(tooltip.style.left, '172px'); assert.equal(tooltip.style.top, '712px');
  help.fire('keydown', {key: 'Escape'}); assert.equal(help.dataset.dismissed, 'true');
});
