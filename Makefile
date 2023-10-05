PROJECT = homework7
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0

DEPS = cowboy jsone homework6
dep_cowboy_commit = 2.9.0
dep_jsone_commit = master
dep_homework6 = git https://github.com/ImAvtandil/homework6

BUILD_DEPS += relx
include erlang.mk
