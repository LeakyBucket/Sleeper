# Sleeper

## What is it?

Sleeper is a very small library for handling variable sleep intervals.  It will handle a "list" of intervals or it will also handle conditional schedules.  It is also possible to specify whether a schedule is cyclic or not.  Sleeper is a gem for those rare situations where you might want to wait for different periods of time.  It's probably most useful in situations where you want to sleep dependent on the result of some piece of code.

## Short How

~~~~~~
gem install sleeper
~~~~~~

~~~~~~
require 'sleeper'

# The simplest form
timer = Sleeper::Timer.new [30, 60, 90]

timer.run # sleep for 30 seconds
timer.run # sleep for 60 seconds
timer.run # sleep for 90 seconds
timer.run # sleep for 90 seconds

# You can also create a cyclic schedule
timer = Sleeper::Timer.new [30, 60, 90], cyclic: true

timer.run # sleep for 30 seconds
timer.run # sleep for 60 seconds
timer.run # sleep for 90 seconds
timer.run # sleep for 30 seconds

# Want different schedules based on a condition?
timer = Sleeper::Timer.new({ "fish" => [30, 20, 10], "bird" => [15, 20, 25] })

timer.run { "fish" } # sleep for 30 seconds
timer.run { "bird" } # sleep for 15 seconds

# Keyed schedules (above) can be cyclic too.
timer = Sleeper::Timer.new({ "fish" => [30, 20, 10], "bird" => [15, 20, 25] }, cyclic: true)

timer.run { "fish" } # sleep for 30 seconds
timer.run { "fish" } # sleep for 20 seconds
timer.run { "fish" } # sleep for 10 seconds
timer.run { "fish" } # sleep for 30 seconds
~~~~~~

-----

## Long How

You can setup a very simple sleep schedule by simply passing an array:

~~~~~
Sleeper::Timer.new [10, 30, 50]
~~~~~

This would sleep for 10 seconds the first time it is run, 30 seconds the second time and 50 seconds the third time.  The above piece of code is not cyclic so subsequent calls to run will sleep for 50 seconds.  

However, you can tell Sleeper to loop through your schedule.

~~~~~
Sleeper::Timer.new [10, 30, 50], cyclic: true
~~~~~

The Timer object returned above will sleep for 10 seconds on the first run, 30 seconds on the second and 50 seconds on the third.  If it is asked to run again it will loop back to the beginning and sleep for 10 seconds again.

----

It is possible to create more complicated schedules.

Say you are doing something that has the potential to slow a system down or takes a very long time to run and you don't necessarily want to run it that often.

It is possible to create multiple schedules and sleep depending on the result of a block of code:

~~~~~
timer = Sleeper::Timer.new({ 0 => [2000, 3000, 8000], 1 => [18000] })

timer.run do
  rand(0..1)
end
~~~~~

The above is a contrived example but hopefully you get the point.

----

It is easy to reset a simple schedule so that it will start over at the first value:

~~~~~
timer = Sleeper::Timer.new [8, 12, 22]

timer.run
=> 8

timer.run
=> 12

timer.reset

timer.run
=> 8
~~~~~

Resets are also possible when you have a keyed schedule, both on a per key level:

~~~~~
timer = Sleeper::Timer.new({ 0 => [10, 20], 1 => [50, 60] })

timer.run { 0 }
=> 10

timer.reset(0)

timer.run { 0 }
=> 10
~~~~~

and on an object wide level:

~~~~~
timer = Sleeper::Timer.new({ 0 => [10, 20, 30], 1 => [50, 60, 70] })

timer.run { 0 }
=> 10

timer.run { 0 }
=> 20

timer.run { 1 }
=> 50

timer.reset

timer.run { 0 }
=> 10

timer.run { 1 }
=> 50
~~~~~