module ApplicationHelper

    def hashtags(content)
        content_words = content.split(" ")
        content_with_links = content_words.map do |word| 
          if word.include?("#")
             link_to(word,root_path(q:{content_cont: word})) 
          else
            word
          end
        end
        content_with_links.join(" ")
      end
    end

    
