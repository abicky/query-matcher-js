root = exports ? window

class root.QueryMatcher
  constructor: (query) ->
    @requiredWords = []
    @optionalWords = []
    # prepend and append a space
    # to process the first word and the last word the same as other words
    for words in " #{query} ".split /\s+OR\s+/
      [afterOrWord, requiredWords..., beforeOrWord] = words.split /\s+/
      @requiredWords.push requiredWords...
      # 'afterOrWord' is an empty string if 'words' is the first group
      @optionalWords.push afterOrWord  if afterOrWord
      # 'beforeOrWord' is undefined if 'words' doesn't contain spaces
      @optionalWords.push beforeOrWord if beforeOrWord

  match: (str) ->
    for requiredWord in @requiredWords
      if requiredWord.substring(0, 1) isnt '-'
        return false if not _match requiredWord, str
      else  # invert match
        return false if _match requiredWord.substring(1), str

    return true if @optionalWords.length is 0

    for optionalWord in @optionalWords
      if optionalWord.substring 0, 1 isnt '-'
        return true if _match optionalWord, str
      else  # invert match
        return true if not _match optionalWord.substring(1), str

    return false

  # match case insensitively if 'searchWord' contains no uppercase characters
  _match = (searchWord, targetString) ->
    pos = targetString.indexOf searchWord
    return true if pos isnt -1
    targetString.toLowerCase().indexOf(searchWord) isnt -1
