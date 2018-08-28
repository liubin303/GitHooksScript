require 'json'

class CommitLintRule

    def initialize(ruleSpecSsonContent)
        if ruleSpecSsonContent != nil
            @name = JSON.parse(ruleSpecSsonContent)['name']
            @description = JSON.parse(ruleSpecSsonContent)['description']
            @fileExtentions = JSON.parse(ruleSpecSsonContent)['fileExtentions']
            @patterns = JSON.parse(ruleSpecSsonContent)['patterns']
            @level = JSON.parse(ruleSpecSsonContent)['level']
            @message = JSON.parse(ruleSpecSsonContent)['message']
            @author = JSON.parse(ruleSpecSsonContent)['author']
            @checkSpecPath = JSON.parse(ruleSpecSsonContent)['checkSpecPath']
        end
    end

    def name
        return @name
    end

    def description
        return @description
    end

    def fileExtentions
        return @fileExtentions
    end

    def patterns
        return @patterns
    end

    def level
        return @level
    end

    def message
        return @message
    end

    def author
        return @author
    end

    def checkSpecPath
        return @checkSpecPath
    end
end
