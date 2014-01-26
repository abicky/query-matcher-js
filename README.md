# JavaScript matcher for user queries

This matcher supports some queries, like queries for search engines.


## Download

You can download the JavaScript file from the following link:

http://abicky.github.io/query-matcher/lib/query-matcher.js


You can also build the file the following steps:
```
$ git clone https://github.com/abicky/query-matcher.git
$ cd ./query-matcher/
$ npm install
$ npm run build
```

## Usage

First, initialize `QuerMatcher` with the query, then call `QuerMatcher#match` with the string.
`QuerMatcher#match` returns `true` if the query matches the string, otherwise returns `false`.

```javascript
var matcher = new QuerMatcher(query);
matcher.match(string);
```

When the query contains no uppercase characters, it matches strings case insensitively.

```javascript
var matcher = new QueryMatcher('ap');;
matcher.match('apple');  // => true
matcher.match('Apple');  // => true
```

When the query contains uppercase characters, it matches strings case sensitively.

```javascript
var matcher = new QueryMatcher('Ap');
matcher.match('apple');  // => false
matcher.match('Apple');  // => true
```

When the query contains multiple words, it matches strings which contain the both words.

```javascript
var matcher = new QueryMatcher('ap le');
matcher.match('apple');  // => true
matcher.match('grape');  // => false
```

When the query contains 'OR' keyword, it matches strings which contain the each word.

```javascript
var matcher = new QueryMatcher('ap OR le');
matcher.match('grape');   // => true
matcher.match('lemon');   // => true
matcher.match('orange');  // => false
```

When the query contains words with '-' prefix, it matches strings which don't contain the word.

```javascript
var matcher = new QueryMatcher('-ap');
matcher.match('apple');   // => false
matcher.match('orange');  // => true
```


## Demo

http://abicky.github.io/query-matcher/
