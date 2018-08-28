

def getAllChangedFilesByExtensions(fileExtensions)
    allChangedFiles = `git diff HEAD --name-status`
    .lines
    .map(&:strip)
    .select{ |line| 
        ['A', 'M', 'R'].include?(line.split.first)
    }.map { |line| 
        line.split.last
    }
    if fileExtensions.size > 0
        allChangedFiles = allChangedFiles.select { |line|
           fileExtensions.include?(File.extname(line.split.last))
        }
    end
    return allChangedFiles
end


def getChangeContentByPath(filePath)
    changeContents = `git diff --cached #{filePath}`
        .lines
        .map(&:strip)
        .select{ |line| 
            ['+'].include?(line.split.first)
        }
    return changeContents.join("\n")
end


