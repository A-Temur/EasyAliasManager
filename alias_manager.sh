#!/bin/bash

# Define the file paths for storing aliases and descriptions
ALIASES_FILE="$HOME/.aliases"
DESCRIPTIONS_FILE="$HOME/.alias_descriptions"

# Ensure alias and description files exist
touch "$ALIASES_FILE" "$DESCRIPTIONS_FILE"

# Function to add a new alias
add_alias() {
    local name="$1"       # Alias name
    local command="$2"    # Command associated with the alias
    local description="$3" # Description of the alias

    # Check if alias already exists
    if grep -q "^alias $name=" "$ALIASES_FILE"; then
        echo "Alias '$name' already exists. Use edit_alias to modify."
        return 1
    fi

    # Append the alias and description to respective files
    echo "alias $name='$command'" >> "$ALIASES_FILE"
    echo "$name:$description" >> "$DESCRIPTIONS_FILE"
    echo "Alias '$name' added successfully!"

    # Reload aliases to make the new alias available
    source "$ALIASES_FILE"
}

# Function to edit an existing alias
edit_alias() {
    local name="$1"          # Alias name
    local new_command="$2"   # New command for the alias
    local new_description="$3" # New description for the alias

    # Remove existing alias and description
    sed -i "/^alias $name=/d" "$ALIASES_FILE"
    sed -i "/^$name:/d" "$DESCRIPTIONS_FILE"

    # Add updated alias and description
    echo "alias $name='$new_command'" >> "$ALIASES_FILE"
    echo "$name:$new_description" >> "$DESCRIPTIONS_FILE"
    echo "Alias '$name' updated successfully!"

    # Reload aliases to apply changes
    source "$ALIASES_FILE"
}

# Function to delete an alias
delete_alias() {
    local name="$1"  # Alias name to delete

    # Check if the alias exists
    if ! grep -q "^alias $name=" "$ALIASES_FILE"; then
        echo "Alias '$name' not found."
        return 1
    fi

    # Remove the alias and its description
    sed -i "/^alias $name=/d" "$ALIASES_FILE"
    sed -i "/^$name:/d" "$DESCRIPTIONS_FILE"
    echo "Alias '$name' removed successfully!"

    # Reload aliases to apply changes
    source "$ALIASES_FILE"
}


# Function to list all aliases with descriptions
list_aliases() {
    echo "Aliases and Descriptions:"
    # Format and print aliases with their descriptions
    paste -d ' - ' <(awk -F '=' '{print $1}' "$ALIASES_FILE" | sed 's/alias //') <(cut -d ':' -f2 "$DESCRIPTIONS_FILE")
}

# Function to retrieve alias description
helpalias() {
    local name="$1"  # Alias name to search for
    # Find and print the description or show an error if not found
    grep "^$name:" "$DESCRIPTIONS_FILE" | cut -d ':' -f2- || echo "No description found for alias '$name'."
}

# Command-line interface (CLI) handler
case "$1" in
    add) add_alias "$2" "$3" "$4" ;;   # Add alias
    edit) edit_alias "$2" "$3" "$4" ;; # Edit alias
    list) list_aliases ;;                  # List aliases
    helpalias) helpalias "$2" ;;          # Get alias description
    remove) delete_alias "$2" ;;
    *) echo "Usage: $0 {add|edit|list|helpalias} [args]" ;; # Default usage message
esac
