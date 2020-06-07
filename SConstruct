# -*- python -*-
##  Copyright 2013 UCAR, NCAR, All Rights Reserved

import eol_scons

from SCons.Errors import StopError

env = Environment(tools = ['default', 'qt5', 'qtsql', 'qtgui', 'qtwidgets', 'qtnetwork', 'qtcore', 'qwt', 'gsl'])

# Compilation generates numerous warnings relative to the Qt4 code base itself when -Weffc++ is enabled
#env['CXXFLAGS'] = ['-Weffc++','-Wall','-O2' ]
env['CXXFLAGS'] = [ '-Wall','-O2','-std=c++11' ]

uis = Split("""
    ViewTextDialog.ui
    CalibrationPlot.ui
    CalibrationForm.ui
""")

env.Uic5(uis)

sources = Split("""
    main.cc
    MainWindow.cc
    CalibrationPlot.cc
    CalibrationForm.cc
    polyfitgsl.cc
    SortFilterProxyModel.cc
    ViewTextDialog.cc
""")

caledit = env.Program('caledit', sources)

inode = env.Install('/opt/local/bin', caledit)
env.Clean('install', inode)

options = env.GlobalOptions()
options.Update(env)
Help(options.GenerateHelpText(env))
