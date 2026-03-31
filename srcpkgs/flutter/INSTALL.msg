Flutter requires write permission to the install directory.
This package redirects writes to '~/.cache/flutter_*'.
Users should unmount and clear the cache after upgrades.

	$ fusermount -uq ~/.cache/flutter_sdk
	$ rm -rf ~/.cache/{flutter_sdk,flutter_local}

Optionally, adding the user to the 'flutter' group would
give them direct access to '/opt/flutter':

	$ sudo usermod -aG flutter <username>
