# APCSFinalProject

https://docs.google.com/document/d/1e4tCY54Hs_qL2n1JYY5i5HQ0xJ0pONw4oTB4kWREFcU/edit

Group Name: CalcuLosers\
Group Member Names: Marko Zimic and Christopher Tan

## Summary
Our project is a graphing calculator. It will be very similar to applications like Desmos, taking in equation parameters in a field with textboxes and displaying the graphs for the equations on a separate grid field adjacent to the textboxes. The textbox fields will also function as simple calculators, taking basic arithmetic equations and outputting their results nearby. The program will be able to take and graph multiple equations at once and will be able to take all different sorts of equations, from simple constant and linear equations to polynomials, and - eventually, hopefully - parametric equations and conic sections.

## Instructions
To start the program, open the Processing document and click the start button.\
To enter equations, click on a textbox. When it is highlighted blue, you may enter an equation by typing it into the box. You may deselect a selected textbox by clicking elsewhere. You may also deselect the currently selected box and select the next one by pressing ENTER, TAB, or SPACE. If a deselected textbox is red, that means there is a parenthetical imbalance error. If there is content in a textbox, a little colored dot will appear on the box's right. The line that corresponds to the entered equation will have the same color as the dot.\
You can change the grid's field of view by dragging while the mouse is pressed or zooming in and out with the scroll wheel.\
y must precede all other elements of functions in which y is a function of x, and vice versa.\
Ellipses and circles must be entered in standard form to be graphed. For ellipses, this is\
(x-h)^2/a+(y-k)^2/b=1\
and for circles\
(x-h)^2+(y-k)^2=r^2\
Here are some examples of valid equation types and forms.\
Constant: y=1 x=-1\
Linear: y=2x+1\
Quadratic: y=1/2x^2+2x-3\
Cubic: x=y^3\
Circle: (x-1)^2+(y+4)^2=9\
Ellipse: x^2/4+(y+3)^2/16=1\
Point: (1, -2)\
Our calculator also supports list creation and usage. To make a list, start with any single-letter variable other than x or y, use =, and add brackets. Separate values with a comma. The calculator immitates Desmos's behaviour: if two lists have unequal sizes, substitution will truncate after the end of the shorter of the two lists, as a result, variables are not equivalent to lists with length one, variables will be substituted in all cases.\
a = [2,4]; b = [1]; y=ax+b will plot one line with a = 2, b = 1.\
a = [2,4]; b = 1; y=ax+b will plot two lines with a = 2, b = 1; and a = 4, b = 1.

## Development Log
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

**5/31/2021**\
Marko: Updated code to match Christopher's branch. Fixed a couple of bugs.

**6/1/2021**\
Christopher: I made a few slight changes to the design from line size to text readjustment.\
Marko: Modified parseExpression() to scan the input from TextBox from right to left to resolve conflicts that arose due to the associative and commutative properties.

**6/2/2021**\
Christopher: I allowed equations of the form x=f(y) to be evaluated and graphed. I also assumed a f(x) default case when there is no equation or equal sign.

**6/3/2021**\
Christopher: Worked on merging branches and fixing last minute errors, outlined presentation.\
Marko: Fixed a bug, allowing parseExpression() to read input like -x as -1 * x.

**6/6/2021**\
Marko: Wrote two versions of new evaluate() and draw() methods, both of which did not work after I spent the 4th and 5th thinking about potential algorithms and pseudocode for the methods.

**6/7/2021**\
Marko: Worked on revising the algorithms and pseudocode developed for the new evaluate() and draw() methods over the weekend.\
Christopher: I was working on writing sudocode for the variables class, and its implementation into the TextBox classes.

**6/8/2021**\
Christopher: Worked a bit on differentiating input (as in separating variables from functions and nonfunctions and making different code that deals with different inputs).\
Marko: Ditched new evaluate() method because it wouldn't work, created Conic class to graph circles and ellipses.

**6/9/2021**\
Christopher: Continued to work on differentiating input as well as working on creating the variables class, then implementing it into the TextBox. I also worked on learning how Maps work and trying to use them as a variable storage container, rewriting much of the logic that doesn't accept variables.\
Marko: Began writing Conic and fixing issues with it.

**6/10/2021**\
Christopher: I got the variables to start working, uniting the code with Marko's should not be too difficult. I will probably start work on an instruction manual to make sure that the user doesn't break any code.\
Marko: Finished writing Conic, created and finished Point class, gave each TextBox and corresponding line a unique color. Both of us merged our branches into main and did some extra work sorting out conflicts.
