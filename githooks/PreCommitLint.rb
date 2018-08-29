require 'optparse'

require_relative 'ConfigHelper.rb'
require_relative 'CommitLintRule.rb'
require_relative 'DiffHelper.rb'

def option_parser
    options = Hash.new
    parser = OptionParser.new do|opts|
        opts.on( "-w", "--workspace workspace_path", "路径" ) do |workspace_path|
            options["workspace_path"] = workspace_path
        end

        opts.on('-h', '--help', 'help') do
            puts opts
            exit 0
        end
    end
    parser.parse!
    return options
end

# 获取外部参数
option = option_parser()
workspace_path = option["workspace_path"]

# 加载规则配置文件
ruleSpecFiles = loadCommitLintRuleSpecFiles("#{workspace_path}/pre-commit-rules")

# 迭代检查
ruleSpecFiles.each { |ruleFile|
    rule_spec_json_content = ruleJsonContent(ruleFile)
    lintRule = CommitLintRule.new(rule_spec_json_content)
    # 获取改动的文件（会按规则里定义的文件扩展名过滤）
    changedFiles = getAllChangedFilesByExtensions(lintRule.fileExtentions)
    changedFiles.each { |file| 
        git_dir = `git rev-parse --show-toplevel`
        file_path = "#{git_dir.strip}/#{file.split.last.strip}"
        change_content = getChangeContentByPath(file_path)
        # puts "#{file_path}修改：#{change_content}"
        # 按正则匹配
        lintRule.patterns.each do |pattern|
            if change_content.match(pattern)
                if "error".eql?(lintRule.level)
                    
                    puts "❌检查到 #{file} 含有不符合 #{lintRule.name} 检查规范 #{pattern} 的内容：#{change_content}"
                    puts "❌#{lintRule.message}"
                    exit 1
                else
                    puts "⚠️检查到 #{file} 含有不符合 #{lintRule.name} 检查规范 #{pattern} 的内容：#{change_content}"
                    puts "⚠️#{lintRule.message}"
                end
            end
        end
    }
}


