--- 5. number of bookings that happened in stoppage time
SELECT COUNT(*)
FROM player_booked
WHERE play_schedule = 'ST';