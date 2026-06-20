#!/usr/bin/env python3

import os
import sys
import json
import subprocess

HISTORY_FILE = os.path.expanduser("~/.clipmgr_history.json")
MAX_ITEMS = 100

def load_history():
    if os.path.exists(HISTORY_FILE):
        try:
            with open(HISTORY_FILE, 'r') as f:
                return json.load(f)
        except Exception:
            return []
    return []

def save_history(history):
    with open(HISTORY_FILE, 'w') as f:
        json.dump(history, f, indent=2)

def add_item():
    try:
        result = subprocess.run(['wl-paste', '--no-newline'], capture_output=True)
        content = result.stdout.decode('utf-8', errors='ignore').strip()
    except Exception:
        return

    if not content:
        return

    history = load_history()

    # Remove if it already exists so we can move it to the top
    history = [item for item in history if item != content]

    history.insert(0, content)

    if len(history) > MAX_ITEMS:
        history = history[:MAX_ITEMS]

    save_history(history)

def start_daemon():
    print("Starting clipboard manager daemon...")
    print("Press Ctrl+C to stop.")
    try:
        subprocess.run(['wl-paste', '--watch', '/home/amiel/.config/hypr/scripts/clipmgr-add.sh'])
    except KeyboardInterrupt:
        print("\nDaemon stopped.")

def list_items():
    history = load_history()
    if not history:
        print("Clipboard history is empty.")
        return

    for i, item in enumerate(history):
        display_text = item.replace('\n', '\\n')
        if len(display_text) > 80:
            display_text = display_text[:77] + '...'
        print(f"[{i}] {display_text}")

def get_item(index):
    history = load_history()
    try:
        index = int(index)
        if 0 <= index < len(history):
            content = history[index]
            # Write to a temp file and copy using wl-copy
            import tempfile
            with tempfile.NamedTemporaryFile('w', delete=False) as f:
                f.write(content)
                tmp_path = f.name
            subprocess.Popen(f'wl-copy < {tmp_path}; rm {tmp_path}', shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, start_new_session=True)
            print(f"Copied item {index} back to clipboard.")
        else:
            print("Invalid index.")
    except ValueError:
        print("Index must be an integer.")

def menu():
    history = load_history()
    if not history:
        print("Clipboard history is empty.")
        return

    menu_items = []
    for item in history:
        display_text = item.replace('\n', ' ↵ ')
        if len(display_text) > 100:
            display_text = display_text[:97] + '...'
        menu_items.append(display_text)
    
    # We prefix items with their index so we know which one was selected
    menu_input = '\n'.join(f"{i} {item}" for i, item in enumerate(menu_items))
    
    selected_line = None

    try:
        result = subprocess.run(['fzf', '--prompt', 'Clipboard> '], 
                                input=menu_input, capture_output=True, text=True)
        if result.returncode == 0:
            selected_line = result.stdout.strip()
    except FileNotFoundError:
        print("fzf not found. Please install fzf for the interactive menu.")
        print("Alternatively, you can use 'clipmgr.py list' and 'clipmgr.py get <idx>'.")
        return

    if selected_line:
        try:
            idx = int(selected_line.split(' ', 1)[0])
            content = history[idx]
            # Write to a temp file and copy using wl-copy in background
            import tempfile
            with tempfile.NamedTemporaryFile('w', delete=False) as f:
                f.write(content)
                tmp_path = f.name
            subprocess.Popen(f'wl-copy < {tmp_path}; rm {tmp_path}', shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, start_new_session=True)
        except Exception as e:
            print(f"Error copying item: {e}")

def clear_history():
    if os.path.exists(HISTORY_FILE):
        os.remove(HISTORY_FILE)
        print("Clipboard history cleared.")
    else:
        print("No clipboard history to clear.")

def print_usage():
    print("Usage: clipmgr.py <command>")
    print("Commands:")
    print("  daemon    Run the clipboard watcher daemon (in background or in terminal)")
    print("  list      List clipboard history")
    print("  get <idx> Copy item at index back to clipboard")
    print("  menu      Show interactive CLI menu to select an item (uses fzf)")
    print("  clear     Clear the clipboard history")
    print("  add       (Internal) Add current clipboard to history via stdin")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print_usage()
        sys.exit(1)
    
    command = sys.argv[1]
    if command == "daemon":
        start_daemon()
    elif command == "add":
        add_item()
    elif command == "list":
        list_items()
    elif command == "get":
        if len(sys.argv) == 3:
            get_item(sys.argv[2])
        else:
            print("Usage: clipmgr.py get <index>")
    elif command == "menu":
        menu()
    elif command == "clear":
        clear_history()
    else:
        print_usage()
