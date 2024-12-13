# **VS Code Workspace Automation**

This script automates the creation of a Visual Studio Code workspace by adding all first-level subdirectories of a specified folder as projects in the workspace. The workspace file is dynamically generated and opened in VS Code.

---

## **Features**
- Automatically adds all first-level directories in a specified folder to a `.code-workspace` file.
- Ensures all paths are absolute for compatibility.
- Reliably formats the workspace file using `jq` for JSON handling.
- Opens the workspace in Visual Studio Code after creation.

---

## **Requirements**
- **Bash Shell**: The script is designed for Bash (or compatible shells like Zsh).
- **`code` Command**: Ensure Visual Studio Code is installed, and the `code` command is available in your terminal. To enable it:
  1. Open VS Code.
  2. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS).
  3. Run the command `Shell Command: Install 'code' command in PATH`.
- **`jq`**: Install `jq` for JSON manipulation.
  - **Debian/Ubuntu**: `sudo apt-get install jq`
  - **macOS**: `brew install jq`
  - **Fedora/CentOS**: `sudo yum install jq`

---

## **Usage**

### **1. Add the Function to Your Shell**
1. Copy the script function into your `~/.bashrc` or `~/.zshrc` file.
2. Reload your shell configuration:
   ```
   source ~/.bashrc  # For Bash
   source ~/.zshrc   # For Zsh
   ```

### **2. Run the Script**
Execute the function with the path to your target folder:
```
create_vscode_workspace /path/to/folder
```

---

## **Example**

### **Directory Structure**
Suppose your directory looks like this:
```
/Users/yourname/projects/
├── java-app/
├── python-app/
├── js-app/
```

### **Command**
```
create_vscode_workspace /Users/yourname/projects
```

### **Generated Workspace File**
A `.code-workspace` file is created in the folder:
```
{
  "folders": [
    {
      "path": "/Users/yourname/projects/java-app"
    },
    {
      "path": "/Users/yourname/projects/python-app"
    },
    {
      "path": "/Users/yourname/projects/js-app"
    }
  ],
  "settings": {}
}
```

---

## **Troubleshooting**

1. **`code` Command Not Found**:
   - Ensure Visual Studio Code is installed and the `code` command is in your PATH.
   - Run:
     ```
     code --version
     ```

2. **`jq` Not Installed**:
   - Install `jq` using your package manager:
     ```
     sudo apt-get install jq  # Debian/Ubuntu
     brew install jq          # macOS
     sudo yum install jq      # Fedora/CentOS
     ```

3. **Workspace Doesn’t Open**:
   - Check the `.code-workspace` file for correctness:
     ```
     cat /path/to/folder/folder-name.code-workspace
     ```
   - Open the workspace manually:
     ```
     code /path/to/folder/folder-name.code-workspace
     ```

---

## **Acknowledgments**
This script uses `jq` for JSON handling and the Visual Studio Code CLI (`code`) to automate workspace management. Developed for seamless multi-project management in VS Code.

---