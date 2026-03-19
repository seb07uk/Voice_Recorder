# -*- mode: python ; coding: utf-8 -*-
# =============================================================================
#  dyktafon.spec  —  PyInstaller build specification
#
#  Developer  : Sebastian Januchowski
#  Company    : polsoft.ITS™ Group
#  © 2026 Sebastian Januchowski & polsoft.ITS™ Group
# =============================================================================
#
#  Build with:
#    pyinstaller dyktafon.spec
#
#  Or use build.bat for a full automated build.
# =============================================================================

import sys
from PyInstaller.utils.hooks import collect_data_files, collect_submodules

block_cipher = None

# ---------------------------------------------------------------------------
# Hidden imports required by sounddevice / numpy / PyQt6
# ---------------------------------------------------------------------------
hidden_imports = [
    'sounddevice',
    'numpy',
    'numpy.core._multiarray_umath',
    'PyQt6.QtCore',
    'PyQt6.QtGui',
    'PyQt6.QtWidgets',
    'cffi',
    '_cffi_backend',
]

# ---------------------------------------------------------------------------
# Analysis
# ---------------------------------------------------------------------------
a = Analysis(
    ['dyktafon.py'],
    pathex=['.'],
    binaries=[],
    datas=[],
    hiddenimports=hidden_imports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[
        'tkinter',
        'matplotlib',
        'scipy',
        'pandas',
        'PIL',
        'cv2',
        'IPython',
        'jupyter',
    ],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

# ---------------------------------------------------------------------------
# PYZ archive
# ---------------------------------------------------------------------------
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

# ---------------------------------------------------------------------------
# Single-file portable EXE
# ---------------------------------------------------------------------------
exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='dyktafon',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,             # compress with UPX if available
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,        # no console window (GUI app)
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='icon.ico',
    version='version_info.txt',
)
