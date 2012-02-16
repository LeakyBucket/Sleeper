# Sleeper

## What is it?

Sleeper is a very small library for handling variable sleep intervals.  It will handle a \"list\" of intervals or it will also handle conditional schedules.  It is also possible to specify whether a schedule is cyclic or not.

## How?

~~~~~~
require 'sleeper'

# The simplest form
timer = Sleeper::Timer.new [30, 60, 90]

timer.run # sleep for 30 seconds
timer.run # sleep for 60 seconds
timer.run # sleep for 90 seconds
timer.run # sleep for 90 seconds

# You can also create a cyclic schedule
timer = Sleeper::Timer.new [30, 60, 90], true

timer.run # sleep for 30 seconds
timer.run # sleep for 60 seconds
timer.run # sleep for 90 seconds
timer.run # sleep for 30 seconds

# What if you want different schedules based on a condition
timer = Sleeper::Timer.new({ "fish" => [30, 20, 10], "bird" => [15, 20, 25] })

timer.run { "fish" } # sleep for 30 seconds
timer.run { "bird" } # sleep for 15 seconds

# Keyed schedules (above) can be cyclic too.
timer = Sleeper::Timer.new({ "fish" => [30, 20, 10], "bird" => [15, 20, 25] }, true)

timer.run { "fish" } # sleep for 30 seconds
timer.run { "fish" } # sleep for 20 seconds
timer.run { "fish" } # sleep for 10 seconds
timer.run { "fish" } # sleep for 30 seconds
~~~~~~