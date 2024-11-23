#!/bin/bash

# Print error message and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Check if required commands exist
check_requirements() {
    command -v curl >/dev/null 2>&1 || error_exit "curl is required but not installed. Please install curl first."
    command -v unzip >/dev/null 2>&1 || error_exit "unzip is required but not installed. Please install unzip first."
}

# Clean up files in case of script interruption
cleanup() {
    echo "Cleaning up temporary files..."
    rm -f awscliv2.zip
    rm -rf aws
    cd - >/dev/null 2>&1
}

# Set up trap for cleanup on script exit
trap cleanup EXIT

echo "Starting AWS CLI installation..."

# Check for required commands
check_requirements

# Create and change to temporary directory
cd /tmp || error_exit "Failed to change to /tmp directory"

# Download AWS CLI
echo "Downloading AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" || error_exit "Failed to download AWS CLI"

# Unzip the installer
echo "Extracting AWS CLI..."
unzip -q awscliv2.zip || error_exit "Failed to unzip AWS CLI package"

# Install AWS CLI
echo "Installing AWS CLI..."
sudo ./aws/install || error_exit "Failed to install AWS CLI"

# Verify installation
echo "Verifying installation..."
if command -v aws >/dev/null 2>&1; then
    VERSION=$(aws --version)
    echo "AWS CLI installed successfully!"
    echo "Version: $VERSION"
    echo ""
    echo "To configure AWS CLI, run: aws configure"
    echo "You will need:"
    echo "  - AWS Access Key ID"
    echo "  - AWS Secret Access Key"
    echo "  - Default region name"
    echo "  - Default output format"
else
    error_exit "AWS CLI installation verified failed. Please check the installation manually."
fi

# Clean up is handled by the trap