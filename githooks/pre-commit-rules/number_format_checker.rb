
class String
	def is_modified_mfile?
		File.extname(self.split.last) == '.m' &&
			['A', 'M', 'R'].include?(self.split.first)
    end

    def get_change_content
        git_dir = `git rev-parse --show-toplevel`
        file_path = "#{git_dir.strip}/#{self.split.last.strip}"
        change_content = `git diff --cached #{file_path}`
            .lines
            .map(&:strip)
            .select{|line| '+'.eql?(line.split.first)}
        return change_content
    end

    def is_error_format(fileName)
        format_patterns = Array[
            '\[NSString stringWithFormat:@".*%.[0-9]f.*",(\s*)(.*)\]', 
            '\[NSString stringWithFormat:@".*%@.*",(\s*)@\((.*)\)\]', 
            '\[NSString stringWithFormat:@".*%@.*",(\s*)\[NSNumber (.*)\]\]'
        ]
        format_patterns.each do |pattern|
            if self.match(pattern)
                puts "❌文件：#{fileName}有不合规的format内容：\n#{self} \n请使用NSNumber+TAFormat中的format方法!"
                exit 1
            end
         end
    end
end

def format_check
    changed_mfiles = `git diff HEAD --name-status`
    .lines
    .map(&:strip)
    .select{|line| line.is_modified_mfile? }

    if changed_mfiles.size > 0
        changed_mfiles.each {|file| 
            change_content_array = file.get_change_content.each{|item| item.is_error_format(file.split.last)}
        }
	end
end

format_check()
exit 0
