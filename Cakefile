{spawn, exec} = require 'child_process'

option '-p', '--prefix [DIR]', 'set the installation prefix for `cake install`'
option '-w', '--watch', 'continually build the docas library'

task 'build', 'build the docco library', (options) ->
  coffee = spawn 'coffee', ['-c' + (if options.watch then 'w' else ''), '-o', 'lib', 'src']
  coffee.stdout.on 'data', console.log
  coffee.stderr.on 'data', console.error

task 'install', 'install the `docco`, `docci`, and `docas` command into /usr/local (or --prefix)', (options) ->
  base = options.prefix or '/usr/local'
  lib  = base + '/lib/docas'
  exec([
    'mkdir -p ' + lib
    'cp -rf bin README resources vendor lib ' + lib
    'ln -sf ' + lib + '/bin/docco ' + base + '/bin/docco'
    'ln -sf ' + lib + '/bin/docci ' + base + '/bin/docci'
    'ln -sf ' + lib + '/bin/docas ' + base + '/bin/docas'
  ].join(' && '), (err, stdout, stderr) ->
    console.error stderr if err
  )
