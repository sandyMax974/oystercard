Card

top up > tap in (entry_station) --> @new_trip = new journey with entry station

Journey

Journey contains: entry station
        contains: nil as exit_station

Journey

method: complete?
checks hash has 2 truthy values
if only one value, +5 to the fare

Card

tap out (exit_station) --> @new_trip = same journey with exit station

Journey

