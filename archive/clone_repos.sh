#!/bin/bash

# GitHub personal access token is required for private repositories
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN environment variable is not set"
    echo "Please create a token at https://github.com/settings/tokens"
    echo "Then set it using: export GITHUB_TOKEN='your_token_here'"
    exit 1
fi

# Organization name
ORG="synnax-ai"

# Create a directory for the organization
mkdir -p "$ORG"
cd "$ORG"

# Fetch all repository names from the organization (including private ones)
repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    "https://api.github.com/orgs/$ORG/repos?type=all&per_page=100" \
    | grep -o '"ssh_url": "[^"]*' | cut -d'"' -f4)

# If no repositories were found, check if the token has the correct permissions
if [ -z "$repos" ]; then
    echo "No repositories found. Please ensure your token has the following permissions:"
    echo "- repo (Full control of private repositories)"
    echo "- read:org (Read org and team membership)"
    exit 1
fi

# Clone each repository
for repo in $repos; do
    # Extract repository name from URL
    repo_name=$(basename -s .git "$repo")
    
    # Check if directory already exists
    if [ -d "$repo_name" ]; then
        echo "Directory $repo_name already exists, pulling latest changes..."
        (cd "$repo_name" && git pull)
    else
        echo "Cloning $repo_name..."
        git clone "$repo"
    fi
done

echo "All repositories have been cloned/updated successfully!"