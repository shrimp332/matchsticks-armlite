// Player name block is tracked in r5
// matchstick quantity remaining is tracked in r4
// Read in player name eg. Please Enter your name
      mov r0, #nameQuestion
      str r0, .WriteString
      mov r5, #player
      str r5, .ReadString
askMatchsticks:
// Read in initial matchstick quantity eg. How many matchsticks (5-100)?
      mov r0, #matchQuestion
      str r0, .WriteString
      ldr r4, .InputNum
// Checks input of matchsticks in range
      cmp r4, #100
      bgt askMatchsticks
      cmp r4, #5
      blt askMatchsticks
// Display Player name eg. Player: Luke
      mov r0, #displayName
      str r0, .WriteString
      str r5, .WriteString
      mov r0, #0x0A
      str r0, .WriteChar
// Display Matchsticks name eg. Matchsticks: 5
      mov r0, #displayMatchsticks
      str r0, .WriteString
      str r4, .WriteUnsignedNum
      halt
nameQuestion: .ASCIZ "Please Enter your name\n"
matchQuestion: .ASCIZ "How many matchsticks (5-100)?\n"
displayMatchsticks: .ASCIZ "Matchsticks: "
displayName: .ASCIZ "Player: "
player: .BLOCK 128
