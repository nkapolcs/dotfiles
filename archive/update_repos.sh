#!/bin/bash

# GitHub personal access token check
if [ -z "your_token_here" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set"
    echo "Please create a token at https://github.com/settings/tokens"
    echo "Then set it using: export GITHUB_TOKEN='your_token_here'"
    exit 1
fi

# Organization name
ORG="synnax-ai"

# Check if we're in the organization directory
if [ ! -d "$ORG" ]; then
    echo "Error: $ORG directory not found"
    echo "Please run this script from the parent directory of $ORG"
    exit 1
fi

# Change to the organization directory
cd "$ORG"

# Initialize counters for status reporting
updated_count=0
failed_count=0
total_repos=0

# Function to update a repository
update_repo() {
    local repo_name=$1
    if [ ! -d "$repo_name" ]; then
        echo "Warning: $repo_name directory not found, skipping..."
        return 1
    fi

    echo "Updating $repo_name..."
    if (cd "$repo_name" && git fetch && git pull); then
        echo "✓ Successfully updated $repo_name"
        return 0
    else
        echo "✗ Failed to update $repo_name"
        return 1
    fi
}

# Get all repository directories
for repo_dir in */; do
    if [ -d "$repo_dir" ]; then
        total_repos=$((total_repos + 1))
        repo_name=${repo_dir%/}
        
        if update_repo "$repo_name"; then
            updated_count=$((updated_count + 1))
        else
            failed_count=$((failed_count + 1))
        fi
    fi
done

# Print summary
echo ""
echo "Update Summary:"
echo "---------------"
echo "Total repositories: $total_repos"
echo "Successfully updated: $updated_count"
echo "Failed to update: $failed_count"

if [ $failed_count -gt 0 ]; then
    exit 1
else
    echo "All repositories have been updated successfully!"
    exit 0
fi