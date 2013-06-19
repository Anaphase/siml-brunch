siml = require 'siml'

module.exports = class SIMLCompiler
  
  brunchPlugin: yes
  type: 'template'
  extension: 'siml'
  
  compile: (data, path, callback) ->
    
    try
      content = siml.angular.parse data, { pretty: no }
      content = content.replace(/'/g, "\\'")
      content = "module.exports = function() { return '#{content}' }"
      
    catch ex
      error = "Error: #{ex.message}"
      if ex.type
        error = ex.type + error
      if ex.filename
        error += " in '#{ex.filename}:#{ex.line}:#{ex.column}'"
      
    finally
      callback error, content
