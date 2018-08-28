require 'json'

def loadCommitLintRuleSpecFiles(rulesPath)
     Dir.entries(rulesPath).collect{ |filename| rulesPath+"/"+filename}.select{ |filename| filename.split('.').last == 'json'}
end

def ruleJsonContent(filePath)
    suffix = filePath.split('.').last
    if suffix == 'json'
        return File.read(filePath)
    else
        return nil
    end
end