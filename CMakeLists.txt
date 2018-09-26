cmake_minimum_required ( VERSION 3.1 )
###################################################################################
#
#   Library: jasmine
#
###################################################################################
project ( jasmine VERSION 0.0.1 )

# Includes: 

# C Sources: 

# Vala Sources: 
list ( APPEND SOURCE .lib/jasmine/src/Block.vala )
list ( APPEND SOURCE .lib/jasmine/src/Core.vala )
list ( APPEND SOURCE .lib/jasmine/src/ConsoleReporter.vala )
list ( APPEND SOURCE .lib/jasmine/src/Delegates.vala )
list ( APPEND SOURCE .lib/jasmine/src/Env.vala )
list ( APPEND SOURCE .lib/jasmine/src/ExpectationResult.vala )
list ( APPEND SOURCE .lib/jasmine/src/jasmine.vala )
list ( APPEND SOURCE .lib/jasmine/src/Matchers.vala )
list ( APPEND SOURCE .lib/jasmine/src/MessageResult.vala )
list ( APPEND SOURCE .lib/jasmine/src/NestedResults.vala )
list ( APPEND SOURCE .lib/jasmine/src/MultiReporter.vala )
list ( APPEND SOURCE .lib/jasmine/src/Runner.vala )
list ( APPEND SOURCE .lib/jasmine/src/Spec.vala )
list ( APPEND SOURCE .lib/jasmine/src/Suite.vala )
list ( APPEND SOURCE .lib/jasmine/src/Queue.vala )

# Vapis: 

# Vapidir: 
list ( APPEND VALA_OPTION --vapidir=${CMAKE_SOURCE_DIR}/.lib/jasmine/vapis)

## Export to the parent scope:
set ( JASMINE true PARENT_SCOPE )


set ( VALA_SOURCES "${VALA_SOURCES};${SOURCE}" PARENT_SCOPE )

set ( VALAC_OPTIONS "${VALAC_OPTIONS};${VALA_OPTION}" PARENT_SCOPE )
set ( DEPS_LIBRARIES "${DEPS_LIBRARIES};-lm" PARENT_SCOPE)


# (generated from template: package. Do not modify. )
