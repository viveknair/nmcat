# Fish shell completions for nmcat

# Function to get available node packages
function __nmcat_get_packages
    # Search up the directory tree for node_modules
    set -l current_dir $PWD
    
    while test "$current_dir" != "/"
        if test -d "$current_dir/node_modules"
            # List all packages, including scoped packages
            for pkg in $current_dir/node_modules/*
                if test -d "$pkg"
                    set -l pkg_name (basename "$pkg")
                    if string match -q '@*' -- "$pkg_name"
                        # Handle scoped packages
                        for scoped_pkg in $pkg/*
                            if test -d "$scoped_pkg"
                                echo "$pkg_name/"(basename "$scoped_pkg")
                            end
                        end
                    else
                        echo "$pkg_name"
                    end
                end
            end
            return 0
        end
        set current_dir (dirname "$current_dir")
    end
    
    return 1
end

# Disable file completions for nmcat
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

# Package name completion - only suggest when no package has been specified yet
complete -c nmcat -n "not __fish_seen_subcommand_from (__nmcat_get_packages)" -a "(__nmcat_get_packages)" -d "Node module package"