proc(_angleToPlayer, @player, @target,
  # Get the location of the player and the target
  @playerLocation = ploc(@player)
  @victimLocation = ploc(@target)

  # Get the difference in x and z
  @dx = @playerLocation[0] - @victimLocation[0]
  @dz = @playerLocation[2] - @victimLocation[2]

  # Get the angle in the x-z plane and the direction the player is facing in the x-z plane
  @angle = to_degrees(atan2(@dz,@dx))
  @facing = pfacing(@player)[0]

  # Calculate the difference between the direction to the entity and the
  # direction the player is facing.  Adjust appropriately so that a difference
  # of zero is the player facing directly at the entity.

  @diff = round(@angle - @facing)

  @diff = @diff + 90
  if(@diff<-180) {
    @diff = @diff + 360
  }
  if(@diff>180) {
    @diff = @diff - 360
  }

  # Get the distance from the player to the entity and the difference in height (y-coordinate)
  # The 2.62 is one plus the player's eye height, which is 1.62 blocks
  @distance = sqrt(@dx**2 + @dz**2)
  @dy = @playerLocation[1] - @victimLocation[1] + 2.62

  # Get the angle in the y direction, as well as the direction of the player's facing in the y direction
  @angley = to_degrees(atan2(@dy,@distance))
  @facingy = pfacing(@player)[1]

  # Calculate the difference between the player's facing and the direction of the entity
  @diffy = round(@facingy - @angley)

  # Return the results
  return(array(@diff, @diffy))
)