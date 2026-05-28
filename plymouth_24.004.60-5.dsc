-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Format: 3.0 (quilt)
Source: plymouth
Binary: plymouth, plymouth-x11, libplymouth5, libplymouth-dev, plymouth-label, plymouth-themes
Architecture: any
Version: 24.004.60-5
Maintainer: Laurent Bigonville <bigon@debian.org>
Uploaders: Sjoerd Simons <sjoerd@debian.org>
Homepage: https://www.freedesktop.org/wiki/Software/Plymouth
Standards-Version: 4.6.1
Vcs-Browser: https://salsa.debian.org/debian/plymouth
Vcs-Git: https://salsa.debian.org/debian/plymouth.git
Build-Depends: debhelper-compat (= 13), docbook-xsl, libdrm-dev, libcairo2-dev, libevdev-dev, libfreetype-dev, libgtk-3-dev (>= 3.14.0), libpango1.0-dev, libpng-dev, libudev-dev [linux-any], meson, pkgconf, systemd-dev, xsltproc
Package-List:
 libplymouth-dev deb libdevel optional arch=any
 libplymouth5 deb libs optional arch=any
 plymouth deb misc optional arch=linux-any
 plymouth-label deb misc optional arch=linux-any
 plymouth-themes deb misc optional arch=linux-any
 plymouth-x11 deb misc optional arch=linux-any
Checksums-Sha1:
 3ea1d5b1f755122dc78b82a60c2f3d096668d92e 1059904 plymouth_24.004.60.orig.tar.xz
 80c819b85a3c27b66688c0ff5e91c7960bfd8779 31284 plymouth_24.004.60-5.debian.tar.xz
Checksums-Sha256:
 f3f7841358c98f5e7b06a9eedbdd5e6882fd9f38bbd14a767fb083e3b55b1c34 1059904 plymouth_24.004.60.orig.tar.xz
 4e1b061eef5f80021c735f263062aa78839612d2561058a8a71442dc43068355 31284 plymouth_24.004.60-5.debian.tar.xz
Files:
 6a6d6ec1a6d6e9bd776f368619864949 1059904 plymouth_24.004.60.orig.tar.xz
 da99fce0d8aa039af06d3e35b945e91e 31284 plymouth_24.004.60-5.debian.tar.xz

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEmRrdqQAhuF2x31DwH8WJHrqwQ9UFAmg1fFwRHGJpZ29uQGRl
Ymlhbi5vcmcACgkQH8WJHrqwQ9WE9ggAhmBKp0YSkajAHc2GnvDKQ1oVFWh0lzEF
qC9/v6xnRlJkYmiVcXFmzKmTpeZGGCn16L6WoHozcYNh+LG5yJcpihagh/ycGivZ
QQyb3IvgN1pOukBAOx3blHlvTyDK3paqXmY/ng+wTyGBxoIf5cXStCabims0bwYC
Tr6X5FkyINzYQrVgqjYWmQBP6PFpUyyl2BMbY6qBEcmbA4q5UsKpUf3xdBB3AjI9
vvey7b9uaTqgiYeoWVTGbRXUYC4NVR03Kl6V4ddPuMFdvCArnF02XvBOISPkeEeC
Ubkqw6zvbdXHtc0kcoQqTUM8PoohX0muuVXPizrwc42vSXE9rkzf6A==
=z5Kl
-----END PGP SIGNATURE-----
