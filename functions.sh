create_vscode_workspace() {
  if [ -z "$1" ]; then
    echo "Usage: create_vscode_workspace <path-to-folder>"
    return 1
  fi

  # Convert the input path to an absolute path
  WORKSPACE_DIR=$(realpath "$1")
  echo "Workspace directory resolved to: $WORKSPACE_DIR"

  # Get the name of the folder
  WORKSPACE_NAME=$(basename "$WORKSPACE_DIR")
  echo "Workspace name: $WORKSPACE_NAME"
  
  # Check if the folder exists
  if [ ! -d "$WORKSPACE_DIR" ]; then
    echo "Error: Directory $WORKSPACE_DIR does not exist."
    return 1
  fi

  # Path for the workspace file
  WORKSPACE_FILE="$WORKSPACE_DIR/$WORKSPACE_NAME.code-workspace"
  echo "Workspace file will be created at: $WORKSPACE_FILE"

  # Collect all first-level directories
  FIRST_LEVEL_DIRS=$(find "$WORKSPACE_DIR" -mindepth 1 -maxdepth 1 -type d -exec realpath {} \;)
  if [ -z "$FIRST_LEVEL_DIRS" ]; then
    echo "No subdirectories found in $WORKSPACE_DIR."
    return 1
  fi

  # Use jq to build the workspace JSON
  echo "Creating workspace JSON..."
  FOLDERS=$(echo "$FIRST_LEVEL_DIRS" | jq -R -s -c 'split("\n") | map(select(length > 0)) | map({path: .})')
  jq -n --argjson folders "$FOLDERS" '{"folders": $folders, "settings": {}}' > "$WORKSPACE_FILE"

  # Open the workspace in VS Code
  echo "Opening workspace in VS Code..."
  code "$WORKSPACE_FILE" > /dev/null 2>&1 &
  if [ $? -eq 0 ]; then
    echo "Workspace opened successfully in VS Code."
  else
    echo "Error: Failed to open workspace in VS Code."
  fi

  echo "Workspace setup completed with directories from $WORKSPACE_DIR."
}