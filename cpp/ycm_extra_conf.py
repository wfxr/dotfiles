import subprocess as sp
from sys import version_info

if version_info > (3, 0):
    gcc_version = sp.run(['gcc', '-dumpversion'], stdout=sp.PIPE).stdout.decode('utf-8').strip()
else:
    gcc_version = sp.check_output(['gcc', '-dumpversion']).strip()

FLAGS = [
        '-Wall',
        '-Wextra',
        '-Wno-long-long',
        '-Wno-variadic-macros',
        '-fexceptions',
        '-DNDEBUG',
        '-std=c++17',
        '-xc++',

        # For linux libc++
        '-isystem', '/usr/include/c++/v1',
        # For linux stdlibc++
        '-isystem', '/usr/include/c++/{}'.format(gcc_version),
        # For windows
        #  '-isystem', 'c:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include',

        # Project include folder
        '-I', 'include',

        # C headers
        '-isystem', '/usr/include',
        '-isystem', '/usr/local/include',

        # Use libc++/libstdc++
        #  '-stdlib=libc++',
        #  '-stdlib=libstdc++',
        ]

def FlagsForFile( filename, **kwargs ):
    return { 'flags': FLAGS, }
