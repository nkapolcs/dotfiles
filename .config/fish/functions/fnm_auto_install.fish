function fnm_auto_install --on-variable PWD
    # Check for .node-version file in the current directory
    set -l node_version_path (command find (pwd) -maxdepth 1 -name '.node-version')

    # If .node-version is found, read the required version
    if test -n "$node_version_path"
        set -l required_node_version (command cat $node_version_path)

        # Check if the required version is installed
        if not fnm ls | grep -q $required_node_version
            echo "Installing Node.js version $required_node_version..."
            fnm install $required_node_version
        end

        # Use the required version
        fnm use $required_node_version
    end
end