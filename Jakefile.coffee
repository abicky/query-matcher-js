{exec, spawn} = require 'child_process'

desc 'Alias of build task'
task 'default', ['build']

desc 'Build CoffeeScript files'
task 'build', [], (params) ->
  exec 'coffee -co ./lib/ ./src/', (err, stdout, stderr) ->
    throw err if err
    complete()
, true

desc 'Run the tests'
task 'test', ['build'], (params) ->
  mocha = spawn 'mocha', ['--compilers', 'coffee:coffee-script', '-R', 'spec']
  mocha.stdout.on('data', (data) ->
    process.stdout.write "#{data}"
  )
  mocha.stderr.on('data', (data) ->
    process.stderr.write "#{data}"
  )
  mocha.on('close', (code) ->
    complete()
  )
, true
