# APCSFinalProject

https://docs.google.com/document/d/1e4tCY54Hs_qL2n1JYY5i5HQ0xJ0pONw4oTB4kWREFcU/edit

Group Name: CalcuLosers
Group Member Names: Marko Zimic and Christopher Tan

### Summary
Our project is a graphing calculator. It will be very similar to applications like Desmos, taking in equation parameters in a field with textboxes and displaying the graphs for the equations on a separate grid field adjacent to the textboxes. The textbox fields will also function as simple calculators, taking basic arithmetic equations and outputting their results nearby. The program will be able to take and graph multiple equations at once and will be able to take all different sorts of equations, from simple constant and linear equations to polynomials, and - eventually, hopefully - parametric equations and conic sections.

### Development Log
**5/25/2021**\
Christopher: I created and worked on the UML diagram and outlined the basic classes (including functions, and instance variables). I also created a few classes and filled in the basic structure and layout.\
Marko: I began working on the Grid class, adding basic lines and a zooming feature as well as an empty region on the left where the textboxes will go, where the equations will be entered.

**5/26/2021**\
Marko: I almost completely finished the TextBox class, which now consists of a typeable field and takes parameters. Tomorrow I plan on starting the Function class and tying that into the TextBox class and vice versa.\
Christopher: I worked on recreating the grid to allow for zooming and appropriate scaling, however, it is not finished because I have yet to figure out a formula for the size of the intervals. I finished / uploaded the UML diagram as well to the prototype.

**5/27/2021**\
Marko: I did a good portion of the Function class and implemented it into TextBox like I said I would. Function still needs work regarding creating the expression tree, but I can certainly piece that together by Saturday or Sunday.\
Christopher: I implemented a dragging feature that moves the grid with the mouse. I also worked a bit on the axes to make sure the coordinates are always visible by "sticking" them to the edge.

**5/28/2021**\
Marko: TextBox turns red when there is parenthetical imbalance. parseExpression() works with multiplication,
division, and exponentiation.

**5/29/2021**\
Marko: Mother Zimic decided to make today a cleaning today so I couldn't do any work until 2am technically on the 30th, but parseExpression() can now handle decimals and multidigit numbers. Started work on parentheses.

**5/30/2021**\
Marko: parseExpression now correctly parses parentheses and makes appropriate trees, added a new if statement to correctly identify distribution multiplication that looks like 4(x-1).\
Christopher: Helped a little bit in parseExpression, debugging some of my previous code and leaving comments. I completed the visual part of displaying the functions based on Marko's tree.
