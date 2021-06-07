# Useful Demo For Vim Workflow
Resource(s): 
- <[Copy search matches | Vim Tips Wiki | Fandom](https://vim.fandom.com/wiki/Copy_search_matches)>
- [Delete all lines containing a pattern | Vim Tips Wiki | Fandom](https://vim.fandom.com/wiki/Delete_all_lines_containing_a_pattern)
- [Create a new file in the directory of the open file in vim? - Stack Overflow](https://stackoverflow.com/questions/13239464/create-a-new-file-in-the-directory-of-the-open-file-in-vim)

For this example, I want to take a list of items that I've drafted as a todo list in markdown format. I want to check the items off as they are finished and collect them into the system's clipboard so that I can append them as a detailed message in a git commit so they show up correctly in git logs.

With vim, I want to do this by copying everything I want first, and then I want to delete them from my working file (buffer). Using the resources above, I was able to chain together a couple commands that help along this path of vim.    

1. Search and preview matching criteria `/pattern` and `:g/` to list lines from previous search query. Alternatively, `:g/pattern` will display all lines matching the pattern. See the [Copy search matches | Vim Tips Wiki | Fandom](https://vim.fandom.com/wiki/Copy_search_matches) for more in-depth search functions. For my example, I'm wanting to target all lines that begin with `- [x]` for a completed task list. The simple search query would look like this:

    /-\ \[x\]\ # to go to each next occurence one by one

And if you are running it in g mode:

    :g/-\ \[x\]\ # to list the items in a preview

2. Copy all lines matching a pattern to register 'a'. In the following code we are first setting the register `a` to empty and then performing the global command search to find all matching lines and append them to register `a`. 
	
    qaq:g/pattern/y A

3. Next, let's copy the contents of register `a` to the system clipboard (register `+` or possibly register `*` if you are on a mac?). Do note that these commands work for my purposes of copying each line of each match. For more copying of mutliline matches refer to the article [Copy search matches | Vim Tips Wiki | Fandom](https://vim.fandom.com/wiki/Copy_search_matches)

    :let @+ = @a 

4. Delete all lines from open buffer: note that if you have completed the first two points then you can use the shortcut to delete all previously lines that match the previously queried search with this:  		
    :g//d  

Otherwise the standard global use of deleting lines are here:
    :g/pattern/d  

_Note this does not cut them into the register, this deletes them from the document._

5. open/create new document to paste system clipboard into. finally if you want to edit/start a new document from the same directory you are currently in:

    :e %:h/filename

This is handy for creating a file called `filename` in the same directory as the file you are currently editing. However if that file is already present you can remove the `%:h` from the argument as that specifies the current file and the modifier for its directory minus the file name. This was found on the [Create a new file in the directory of the open file in vim? - Stack Overflow](https://stackoverflow.com/questions/13239464/create-a-new-file-in-the-directory-of-the-open-file-in-vim)

