# metroid-password-tools
Script for viewing and manipulating passwords in Metroid. Meant for use with [Mesen](https://www.mesen.ca/) and utilizes it's Lua scripting feature.

With this tool, you can see everything that goes into a Metroid password, and manipulate it on-the-fly.

Run the script by opening Metroid inside of Mesen > Debug > Script Window > File > Open

## Password Pane
Shows a real-time generated password for your current game. Creates passwords authentic to how Metroid itself generates them, including the pseudo-encryption utilizing the shift byte.

### Freeze button
Freezes the password and prevents newly-generated passwords from overwriting it.

Only visible in-game.

### Enter button
Enters the current password on the Password screen.

Only visible outside of main game.

## Memory Pane
Shows a manipulatable overview of all memory used in the password generation process, including unused or unknown bits.

For the first 7 bytes, the memory represents whether or not Samus has obtained a specific item; behind-the-scenes the history of collected items in memory will be updated with your selections.

For the remainder of the bytes, the individual cells represent values in memory directly.

This view does not reflect the bits post-shift process, so the generated password will be right-bit-shifted the amount of times specified in the RNG bit.

#### Adding non-password memory addresses
For adding non-password related information to the Memory Pane, simply add an additional addressTableRow with the desired values. 

The password generation code will not look at any address table rows past the ones required for password generation.

An example is included, a commented-out line that adds NARPASSWORD to the Memory Pane. 

### Attribution
I would like to thank ZaneDubya for their work on [MetroidMMC3](https://github.com/ZaneDubya/MetroidMMC3). Without this excellent disassembly, I would never have been able to complete this project. 

I would also like to thank John David Ratliff for his [Metroid Password Format Guide](http://games.technoplaza.net/mpg/password.txt).

### Bugs and Features
This is my first project utilizing Mesen, Lua, 6500 assembly, or the inner workings of Metroid. It is entirely likely I got something wrong or did something inefficiently. 

Feel free to open an issue or submit a pull request.
