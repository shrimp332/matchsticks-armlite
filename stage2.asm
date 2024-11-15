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
gameLoop:
      mov r0, #0x0A
      str r0, .WriteChar
      mov r0, #playerStr
      str r0, .WriteString
      str r5, .WriteString
      mov r0, #thereAre
      str r0, .WriteString
      str r4, .WriteSignedNum
      mov r0, #remaining
      str r0, .WriteString
// display remaining matchsticks
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
// check if input is more or equal to remaining, if is game over
      cmp r4, r0
      blt gameOver
      beq gameOver
// if not loop and remove more
      sub r4, r4, r0
      b gameLoop
gameOver:
      mov r0, #overStr
      str r0, .WriteString
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
// Game over
overStr: .ASCIZ "Game Over\n"
