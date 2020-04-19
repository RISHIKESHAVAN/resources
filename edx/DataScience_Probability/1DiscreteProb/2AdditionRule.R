## Addition Rule
## Pr(A or B) = Pr(A) + Pr(B) + Pr(A and B) 
## To understand this, you can take the case of a Venn diagram

## applying this to blackjack, to get 21 you can either: 1. get a ace first and facecard
## second [OR] 2. get a facecard first and ace second.
## probablity of event 1 =  4/52 * 16/51
## probablity of event 2 =  16/52 * 4/51
## Both cannot happen at the same. so Pr(A and B) = 0
## Therefore, Pr(A or B) ~ 0.5  // same as what we got with combinations
##############################

## Without switching
B <- 10000
stick <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))    # puts prizes in random order
  prize_door <- doors[prize == "car"]    # note which door has prize
  my_pick  <- sample(doors, 1)    # note which door is chosen
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)    # open door with no prize that isn't chosen
  stick <- my_pick    # stick with original door
  stick == prize_door    # test whether the original door has the prize
})
mean(stick)    # probability of choosing prize door when sticking

## with switching
switch <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))    # puts prizes in random order
  prize_door <- doors[prize == "car"]    # note which door has prize
  my_pick  <- sample(doors, 1)    # note which door is chosen first
  show <- sample(doors[!doors %in% c(my_pick, prize_door)], 1)    # open door with no prize that isn't chosen
  switch <- doors[!doors%in%c(my_pick, show)]    # switch to the door that wasn't chosen first or opened
  switch == prize_door    # test whether the switched door has the prize
})
mean(switch)    # probability of choosing prize door when switching