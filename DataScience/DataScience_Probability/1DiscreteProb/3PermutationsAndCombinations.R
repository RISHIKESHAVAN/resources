#?paste - joins two strings and inserts a space in between.
#?expand.grid - gives the combinations of 2 vectors or lists.
## We are going to create a card deck using the expand.grid and paste function
suits <- c("Diamonds", "Clubs", "Hearts", "Spades")
numbers <- c("Ace", "Deuce","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King")
deck <- expand.grid(suits=suits,numbers=numbers)
deck <- paste(deck$suits, deck$numbers) 
deck ## deck now contains all 52 possible combinations of the cards

## We can double check the probability of getting a king from the deck
kings <- paste(suits, "King")
kings ##contains the possible Kings in the deck
mean(deck %in% kings) ## finds the probability

## Now what is the conditional probability of the second card being King
## we will use combinations() and permutations() functions
## permutations() - computes "for any list of size 'n', 
## all the different ways we can select 'r' items". Order matters.
# library(gtools)
permutations(5, 2) ## all the ways we can choose 2 numbers from list 1,2,3,4,5
## in the output, first column is the number chosen first and second is later
## thus order matters. 1,3 is not same as 3,1. so they both appear

## Optionally, in permutations we can add a vector
## to see 5 random 7-digit phone numbers out of all possible numbers, we do the following
## Correction: The code shown does not generate all 7 digit phone numbers 
## because phone numbers can have repeated digits. 
## It generates all possible 7 digit numbers without repeats.
all_phone_numbers <- permutations(10, 7, v = 0:9)
n <- nrow(all_phone_numbers)
rows <- sample(n, 5)
all_phone_numbers[rows,]

## all possible ways of choosing 2 cards from a deck
all_hands <- permutations(52, 2, v = deck) ## returns all 2652 possibilities 
first_hand <- all_hands[,1] ## taking the first hand alone
second_hand <- all_hands[,2]
sum(first_hand %in% kings) ## gives number of kings in the first hand
sum(first_hand %in% kings & second_hand %in% kings) ## gives number of kings in the second hand too
## to find the conditional probability of what fraction of this 204
## has king in the second hand too -
sum(first_hand %in% kings & second_hand %in% kings) / sum(first_hand %in% kings)
## now this code is same as the following piece of code, where 
## we compute the proportions instead of the totals
mean(first_hand %in% kings & second_hand %in% kings) / mean(first_hand %in% kings)
mean(first_hand %in% kings)
## This is an R version of the multiplication rule, which tells us
## the probability of B, given A, is equal to proportion(probability) of A and B,
## divided by the proportion(probability) of A
############################
## combinations() - order does not matter. 1,3 and 3,1 are both same. 
## we don't want to count twice
#library(gtools)
combinations(5,2)
aces <- paste(suits, "Ace")
facecards <- c("King", "Queen", "Jack", "Ten")
facecards <- expand.grid(number=facecards, suits=suits)
facecards <- paste(facecards$suits, facecards$number)
hands <- combinations(52, 2, v = deck)
## blackjack
## probability of a natural 21 given that the ace is listed first in `combinations`
mean(hands[,1] %in% aces & hands[,2] %in% facecards) ## getting different answer
## probability of a natural 21 checking for both ace first and ace second
mean((hands[,1] %in% aces & hands[,2] %in% facecards)|(hands[,2] %in% aces & hands[,1] %in% facecards))

## the same probability can be computed using MonteCarlo too.
# code for one hand of blackjack
hand <- sample(deck, 2)
hand

# code for B=10,000 hands of blackjack
B <- 10000
results <- replicate(B, {
  hand <- sample(deck, 2)
  (hand[1] %in% aces & hand[2] %in% facecards) | (hand[2] %in% aces & hand[1] %in% facecards)
})
mean(results)
###########################
## The birthday problem.
## What is the chance that atleast 2 people will have the same birthday 
## in a class of 50 randomly selected students.
n <- 50
bdays <- sample(1:365, n, replace = TRUE)
bdays
## same_bday <- duplicated(bdays) - this probably returns the probability of more than 1 people having same bday - wrong approach
## p <- mean(same_bday %in% TRUE)
## duplicated() takes a vector and returns a vector of the same length 
## with TRUE for any elements that have appeared previously in that vector.
any(duplicated(bdays))
results <- replicate(10000, {
  bdays <- sample(1:365, n, replace = TRUE)
  any(duplicated(bdays))})
results
mean(results)
