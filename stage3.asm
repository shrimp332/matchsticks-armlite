// Player name block is tracked in r5
// matchstick quantity remaining is tracked in r4
// Read in player name    
      mov r0, #nameQuestion
      str r0, .WriteString
      mov r5, #player
      str r5, .ReadString
askMatchsticks:
// Read in initial matchstick quantity
      mov r0, #matchQuestion
      str r0, .WriteString
      ldr r4, .InputNum
// Check input of matchsticks in range
      cmp r4, #100
      bgt askMatchsticks
      cmp r4, #5
      blt askMatchsticks
// Display Player name eg. Player 1: Luke
      mov r0, #displayName
      str r0, .WriteString
      str r5, .WriteString
      mov r0, #0x0A
      str r0, .WriteChar
// Display Matchsticks name eg. Matchsticks: 5
      mov r0, #displayMatchsticks
      str r0, .WriteString
      str r4, .WriteUnsignedNum
      mov r0, #0x0A
      str r0, .WriteChar
gameLoop:
// print username
      mov r0, #playerStr
      str r0, .WriteString
      str r5, .WriteString
// print remaining matchsticks
      mov r0, #thereAre
      str r0, .WriteString
      str r4, .WriteSignedNum
      mov r0, #remaining
      str r0, .WriteString
askMany:
// input how many to remove
      mov r0, #playerStr
      str r0, .WriteString
      mov r0, #player
      str r0, .WriteString
      mov r0, #howMany
      str r0, .WriteString
      ldr r0, .InputNum
// check if in range
      cmp r0, #3
      bgt askMany
      cmp r0, #1
      blt askMany
// check if input is more or equal to remaining, if is game over or draw
      cmp r4, r0
      blt lose
      beq draw
// if not loop and remove more
      sub r4, r4, r0
//print Computer player's turn
      mov r0, #computerPlayer
      str r0, .WriteString
computerTurn:
// Generate Random number
      ldr R0,.Random
      and r0, r0, #0b11
// if gen num is 0 reroll
      cmp r0, #0
      beq computerTurn
// if gen num is more than remaining reroll
      cmp r4, r0
      blt computerTurn
// if gen num is same as remaining check if 1
      beq checkOne
// if not same continue
      b continue
checkOne:
// if 1 player wins, if not reroll
      cmp r0, #1
      beq win
      bne computerTurn
continue:
// print out amount computer removed
      mov r1, #computerPlay
      str r1, .WriteString
      str r0, .WriteSignedNum
      mov r1, #0x0A
      str r1, .WriteChar
// remove amount from register
      sub r4, r4, r0
// if only 1 remains player loses
      cmp r4, #1
      beq lose
// loop
      b gameLoop
win:
// print that the player won
      mov r0, #youWin
      str r0, .WriteString
      b playAgain
lose:
// print that the player lost
      mov r0, #youLose
      str r0, .WriteString
draw:
// print that it is a draw
      mov r0, #drawStr
      str r0, .WriteString
playAgain:
// Print Would you like to play again? (y/n)\n
      mov r0, #wouldYou
      str r0, .WriteString
// Read string (y/n)
      mov r0, #yesNo
      str r0, .ReadString
// Load string into register
      ldr r1, [r0]
// check if it is 0x79 (y)
      cmp r1, #0x79
// if it is restart game with same username
      beq askMatchsticks
// if it isn't, compare with 0x6E (n)
      cmp r1, #0x6E
// 0 out the memory as ReadString only changes 1 byte, which can ruin the compare
      mov r1, #0x00000000
      str r1, [r0]
// if neither y/n were entered ask if they want to play again, again
      bne playAgain
// if they don't want to play halt
      halt
//Initial Questions
nameQuestion: .ASCIZ "Please Enter your name\n"
matchQuestion: .ASCIZ "How many matchsticks (5-100)?\n"
// Displays
displayMatchsticks: .ASCIZ "Matchsticks: "
displayName: .ASCIZ "Player: "
// Player <name>, there are <x> matchsticks remaining
playerStr: .ASCIZ "Player "
thereAre: .ASCIZ ", there are "
remaining: .ASCIZ " matchsticks remaining\n"
// How many to remove
howMany: .ASCIZ ", how many do you want to remove (1-3)?\n"
// Player name in memory
player: .BLOCK 128
// Computer strings
computerPlayer: .ASCIZ "Computer Player's turn\n"
computerPlay: .ASCIZ "The computer removed: "
// Conditions
youWin: .ASCIZ "You win!\n"
youLose: .ASCIZ "You Lose!\n"
drawStr: .ASCIZ "It is a draw!\n"
// playAgain strings
wouldYou: .ASCIZ "Would you like to play again? (y/n)\n"
      .Align 4
yesNo: .BLOCK 128
