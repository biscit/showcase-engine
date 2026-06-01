**IMPORTANT NOTICE:** This is the legacy version (v1) of the engine, kept online for code comparison purposes. The architecture has been completely refactored from scratch.

**Please visit the active, modular v2 repository here: [showcase-engine-2](https://github.com/biscit/showcase-engine-2)**

# Engine Showcase: Modular Bash Installer

A professional demonstration of advanced Bash scripting, automating the deployment of a full-stack Laravel environment.

## Overview

This project is a **technical showcase** of how Bash, combined with [Gum](https://github.com), can be used to build a modular, interactive, and robust CLI tool. It automates everything from environment checks to GitHub deployment.

> **Note:** This repository is a snapshot for demonstration purposes. The active development of this engine continues in a private project.

## Key Features

- **Interactive UI:** Powered by `gum` for a modern terminal experience.
- **Stack:** Laravel, Livewire, MySQL & SQLite in memory for testing (showcase-specific)
- **Modular Architecture:** Framework-specific logic (Laravel) is separated from shared core utilities.
- **End-to-End Automation:**
  - Automated Database setup (MySQL with dedicated user).
  - Apache Vhost configuration and activation with support for subdomains (Wildcard ServerAlias).
  - Integration of additional packages via data-lists.
  - CI/CD ready: Automated GitHub repository creation and initial push with test badges.
- **Defensive Scripting:** Includes environment validation, dependency checks before execution and includes service-ready synchronization to prevent 503 errors during cold starts in wsl2.
- **Production-ready Security:** Unlike default installers that often rely on root access, this engine follows the principle of least privilege. It automatically provisions a dedicated MySQL user and database, ensuring the local environment mirrors a secure production setup.

## Project Structure

- `setup-dev`: The main entry point (orchestrator).
- `modules/shared/lib`: Core functions and styles.
- `modules/shared/scripts`: Core shared utility scripts.
- `modules/shared/data-lists`: External configuration files for package management (keeping code DRY).
- `modules/laravel/`: Specific installation logic for the Laravel framework.
- `Makefile`: Containing post-install logic related to installed packages.
- `.installed_packages`: Containing the history of installed extra packages per installed app
- `.installed_apps`: Containing the history of installed apps
- `README.md`

## Requirements

- WSL2 / Linux (Ubuntu recommended)
- [Gum](https://github.com)
- PHP, Composer, MySQL, Laravel Installer and GitHub CLI (`gh`)

## Troubleshooting

Logs for the framework installation process are stored in /tmp/laravel_install.log and are automatically cleared upon the next run.

---

_Created as a showcase for Bash Scripting and DevOps automation._
