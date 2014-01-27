{expect} = require 'chai'
{QueryMatcher} = require '../lib/query-matcher'

describe 'QueryMatcher', ->
  describe '#match', ->
    context 'with no words', ->
      it 'matches all items', ->
        matcher = new QueryMatcher ''
        expect(matcher.match ''     ).to.be.true
        expect(matcher.match 'apple').to.be.true

    context 'with no uppercase characters', ->
      it 'matches items case insensitively', ->
        matcher = new QueryMatcher 'ap'
        expect(matcher.match 'apple' ).to.be.true
        expect(matcher.match 'Apple' ).to.be.true
        expect(matcher.match 'orange').to.be.false

    context 'with uppercase characters', ->
      it 'matches items case sensitively', ->
        matcher = new QueryMatcher 'Ap'
        expect(matcher.match 'apple').to.be.false
        expect(matcher.match 'Apple').to.be.true

    context 'with multiple words', ->
      it 'matches items which contain the both words', ->
        matcher = new QueryMatcher 'ap le'
        expect(matcher.match 'apple').to.be.true
        expect(matcher.match 'grape').to.be.false

    context 'with "OR" keyword', ->
      it 'matches items which contain the each word', ->
        matcher = new QueryMatcher 'ap OR le'
        expect(matcher.match 'grape' ).to.be.true
        expect(matcher.match 'lemon' ).to.be.true
        expect(matcher.match 'orange').to.be.false

    context 'with words which have "-" prefix', ->
      it "matches items which don't contain the word", ->
        matcher = new QueryMatcher '-ap'
        expect(matcher.match 'apple' ).to.be.false
        expect(matcher.match 'orange').to.be.true

    context 'with multiple words and "OR"', ->
      # 'c' AND 'e' AND 'r' AND ('d' OR 'h' OR 'l' OR 'm')
      matcher = new QueryMatcher 'c d OR h e l OR m r'

      context 'when items contain all required words and one of optional words', ->
        it 'matches', ->
          expect(matcher.match 'blackberry').to.be.true
          expect(matcher.match 'cherry'    ).to.be.true
          expect(matcher.match 'cucumber'  ).to.be.true
          expect(matcher.match 'redcurrant').to.be.true

      context "when items contain all required words, but don't any optional words", ->
        it "doesn't match", ->
          expect(matcher.match 'cranberry').to.be.false

      context "when items contain one of optional words, but don't all required words", ->
        it "doesn't match", ->
          expect(matcher.match 'apple'    ).to.be.false
          expect(matcher.match 'blueberry').to.be.false
          expect(matcher.match 'mango'    ).to.be.false
          expect(matcher.match 'peach'    ).to.be.false
