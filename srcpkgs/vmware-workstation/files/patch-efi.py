#!/usr/bin/env python3
import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: patch-efi.py <EFI_ROM_PATH>")
        sys.exit(1)

    rom_path = sys.argv[1]

    with open(rom_path, "rb") as f:
        data = f.read()

    # Replace ServerVersion.plist with SystemVersion.plist (UTF-16LE)
    find_str = "ServerVersion.plist".encode("utf-16le")
    repl_str = "SystemVersion.plist".encode("utf-16le")

    patched_data = data.replace(find_str, repl_str)

    with open(rom_path, "wb") as f:
        f.write(patched_data)

if __name__ == "__main__":
    main()
