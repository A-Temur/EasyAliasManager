# EasyAliasManager
A simple Bash script to manage aliases with descriptions. Easily add, edit, list, remove, and retrieve alias + descriptions.

## Features
- Add aliases from Bash history or explicitly.
- Assign descriptions while creating aliases or later.
- Retrieve alias descriptions with `helpalias aliasname`.
- Easily list all aliases and descriptions.
- Remove aliases when no longer needed.

## Installation

Run the following command to install:

```bash
curl -sSL https://raw.githubusercontent.com/A-Temur/EasyAliasManager/refs/heads/main/install.sh | bash
```

This will:
- Download and install `alias_manager` to `/usr/local/bin`.
- Ensure the alias file is sourced in your `~/.bashrc`.

## Usage

### Add an Alias
```bash
alias_manager add ll "ls -la" "List all files with details"
```

### Edit an Alias
```bash
alias_manager edit ll "ls -lh" "List files with human-readable sizes"
```

### List Aliases
```bash
alias_manager list
```

### Remove an Alias
```bash
alias_manager remove ll
```

### Get Alias Description
```bash
alias_manager helpalias ll
```

## License

This project is licensed under the **Unlicense**, allowing unrestricted use, modification, and distribution.

## Contributing
Feel free to contribute by submitting pull requests!

## Support
If you encounter issues, create an issue on GitHub.

## Author
Developed by **Abdullah Temur**.

