# Fastest Fish shell completions for nmcat
# Optimized for minimal latency even with thousands of packages

# Disable file completions
complete -c nmcat -f

# Options
complete -c nmcat -s h -l help -d "Show help message"
complete -c nmcat -s v -l version -d "Show version"
complete -c nmcat -s p -l print -d "Print copied files/content, and also copy to clipboard"
complete -c nmcat -s P -l print-only -d "Print copied files/content, but DON'T copy to clipboard"
complete -c nmcat -s t -l tree-only -d "Only output directory tree"
complete -c nmcat -s i -l ignore -d "Additional ignore patterns" -x
complete -c nmcat -s H -l hidden -d "Include hidden files/directories"
complete -c nmcat -l debug -d "Enable debug output"

# Fastest package completion with smart filtering
function __nmcat_fastest_packages
    # Get what the user has typed so far
    set -l token (commandline -ct)
    
    # Find node_modules directory
    set -l dir $PWD
    while test "$dir" != "/"
        if test -d "$dir/node_modules"
            set -l nm "$dir/node_modules"
            
            # If user has typed something, use smart filtering
            if test -n "$token"
                # If token starts with @, only search in scoped packages
                if string match -q "@*" "$token"
                    # Extract scope if user typed @scope/
                    if string match -q "*/*" "$token"
                        set -l scope (string split "/" "$token")[1]
                        set -l pkg_prefix (string split "/" "$token")[2]
                        # List only packages in that specific scope
                        if test -d "$nm/$scope"
                            command ls -1 "$nm/$scope" 2>/dev/null | while read -l pkg
                                if string match -q "$pkg_prefix*" "$pkg"
                                    echo "$scope/$pkg"
                                end
                            end | head -20
                        end
                    else
                        # List matching scopes - use a safer approach
                        command ls -1 "$nm" 2>/dev/null | while read -l entry
                            if string match -q "$token*" "$entry"
                                # It's a matching scope - show it and first few packages
                                echo "$entry/"
                                if test -d "$nm/$entry"
                                    command ls -1 "$nm/$entry" 2>/dev/null | head -2 | while read -l pkg
                                        echo "$entry/$pkg"
                                    end
                                end
                            end
                        end | head -30
                    end
                else
                    # Regular package - filter results instead of using wildcards
                    command ls -1 "$nm" 2>/dev/null | while read -l entry
                        if string match -q "$token*" "$entry"; and not string match -q ".*" "$entry"
                            echo "$entry"
                        end
                    end | head -20
                end
            else
                # No token - show a curated list of common packages
                # This avoids the slow full scan on initial tab press
                echo -e "express\nlodash\nreact\nvue\n@types/\n@babel/\n@testing-library/\naxios\ntypescript\njest"
                echo "... (type to filter packages)"
            end
            
            return 0
        end
        set dir (dirname "$dir")
    end
    return 1
end

# Only complete if no argument provided yet
complete -c nmcat -n "__fish_is_first_token; or not __fish_seen_argument" -a "(__nmcat_fastest_packages)" -d "Package" 